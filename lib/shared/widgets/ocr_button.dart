import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/ocr/ocr_service.dart';

class OCRButton extends StatefulWidget {
  final Function(String) onTextRecognized;
  final OCRService? ocrService; // Optional dependency injection

  const OCRButton({
    super.key,
    required this.onTextRecognized,
    this.ocrService,
  });

  @override
  State<OCRButton> createState() => _OCRButtonState();
}

class _OCRButtonState extends State<OCRButton> {
  bool _isProcessing = false;
  late final OCRService _ocrService;

  @override
  void initState() {
    super.initState();
    _ocrService = widget.ocrService ?? OCRServiceImpl();
  }

  @override
  void dispose() {
    // Only dispose if we created it (if it was optional)
    // But since OCRServiceImpl creates a TextRecognizer that needs closing...
    // ideally we should use a provider. For now, we dispose if we created it.
    if (widget.ocrService == null) {
      _ocrService.dispose();
    }
    super.dispose();
  }

  Future<void> _scanText() async {
    try {
      final picker = ImagePicker();
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar Foto'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da Galeria'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      final XFile? image = await picker.pickImage(source: source);
      if (image == null) return;

      setState(() => _isProcessing = true);

      final text = await _ocrService.recognizeText(image.path);
      
      if (text.isEmpty) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nenhum texto detectado na imagem.')),
          );
        }
      } else {
        widget.onTextRecognized(text);
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Texto extraído com sucesso!')),
          );
        }
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao ler texto: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isProcessing 
          ? const SizedBox(
              width: 24, 
              height: 24, 
              child: CircularProgressIndicator(strokeWidth: 2)
            )
          : const Icon(Icons.document_scanner_outlined),
      onPressed: _isProcessing ? null : _scanText,
      tooltip: 'Escanear Texto (OCR)',
    );
  }
}
