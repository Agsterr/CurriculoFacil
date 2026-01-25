import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'permission_dialog.dart';

class SpeechTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final Widget? suffixAction;

  const SpeechTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.onSubmitted,
    this.suffixAction,
  });

  @override
  State<SpeechTextField> createState() => _SpeechTextFieldState();
}

class _SpeechTextFieldState extends State<SpeechTextField> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      // Check permission
      var status = await Permission.microphone.status;
      
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          if (!mounted) return;
          final shouldOpenSettings = await PermissionDialog.show(
            context: context,
            title: 'Permissão Necessária',
            content: 'Para usar a digitação por voz, precisamos acessar o microfone.',
            icon: Icons.mic_off,
          );
          if (shouldOpenSettings) {
            await openAppSettings();
          }
          return;
        }

        if (!mounted) return;
        final shouldRequest = await PermissionDialog.show(
          context: context,
          title: 'Digitação por Voz',
          content: 'Gostaria de usar o microfone para preencher este campo?',
          icon: Icons.mic,
        );
        
        if (!shouldRequest) return;

        status = await Permission.microphone.request();
        if (!status.isGranted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permissão de microfone negada')),
            );
          }
          return;
        }
      }

      if (!_isInitialized) {
        _isInitialized = await _speech.initialize(
          onStatus: (status) {
            if (status == 'notListening') {
              setState(() => _isListening = false);
            }
          },
          onError: (error) {
            setState(() => _isListening = false);
            debugPrint('Speech error: $error');
          },
        );
      }

      if (_isInitialized) {
        setState(() => _isListening = true);
        
        // Save cursor position to append text or insert at cursor
        final currentText = widget.controller.text;
        
        _speech.listen(
          onResult: (val) {
            setState(() {
              // Simple append strategy for now, or replace if empty
              // Better: Append to what was there before listening started
              if (currentText.isEmpty) {
                 widget.controller.text = val.recognizedWords;
              } else {
                 // If you want to append, careful with duplicates during partial results
                 // For simplicity in this "correction interface", we replace if it's a new session,
                 // or maybe just update the text field with what's being recognized.
                 // A common pattern is:
                 // 1. Store text before listening
                 // 2. newText = oldText + " " + recognizedWords
                 
                 // However, val.recognizedWords grows as you speak.
                 // So we can just append it to the original text.
                 
                 if (val.recognizedWords.isNotEmpty) {
                   widget.controller.text = '$currentText ${val.recognizedWords}';
                 }
              }
              
              // Move cursor to end
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length),
              );
            });
          },
          localeId: 'pt_BR',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.suffixAction != null) widget.suffixAction!,
            IconButton(
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: _isListening ? Colors.red : null,
              ),
              onPressed: _listen,
              tooltip: 'Digitação por voz',
            ),
          ],
        ),
      ),
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      maxLines: null, // Allow multiline for longer speech
    );
  }
}
