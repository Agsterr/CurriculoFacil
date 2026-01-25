import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../shared/widgets/permission_dialog.dart';
import '../../../../services/curriculo_service.dart';

class ProfileImagePicker extends ConsumerStatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  ConsumerState<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends ConsumerState<ProfileImagePicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    // 1. Check Permissions explicitly for Camera to show Rationale
    if (source == ImageSource.camera) {
      final status = await Permission.camera.status;
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          if (!mounted) return;
          final shouldOpenSettings = await PermissionDialog.show(
            context: context,
            title: 'Acesso à Câmera',
            content: 'Para tirar uma foto para seu currículo, precisamos acessar a câmera. Ative nas configurações.',
            icon: Icons.no_photography,
          );
          if (shouldOpenSettings) {
            await openAppSettings();
          }
          return;
        }

        if (!mounted) return;
        final shouldRequest = await PermissionDialog.show(
          context: context,
          title: 'Usar Câmera',
          content: 'Podemos usar sua câmera para tirar uma foto para o perfil?',
          icon: Icons.camera_alt,
        );

        if (!shouldRequest) return;

        final requestStatus = await Permission.camera.request();
        if (!requestStatus.isGranted) {
           if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permissão de câmera negada')),
            );
           }
           return;
        }
      }
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        await _cropImage(pickedFile.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao selecionar imagem: $e')),
        );
      }
    }
  }

  Future<void> _cropImage(String sourcePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // Square crop
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Ajustar Foto',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Ajustar Foto',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        final savedPath = await _saveImageLocally(croppedFile.path);
        
        final resume = ref.read(currentCurriculoServiceProvider);
        if (resume != null) {
          final newData = resume.personalData.copyWith(photoPath: savedPath);
          ref.read(currentCurriculoServiceProvider.notifier).updatePersonalData(newData);
        }
      }
    } catch (e) {
      debugPrint('Erro no crop: $e');
    }
  }

  Future<String> _saveImageLocally(String tempPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'profile_pic_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(tempPath).copy('${directory.path}/$fileName');
    return savedImage.path;
  }

  void _showSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Câmera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final photoPath = resume?.personalData.photoPath;

    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _showSourceBottomSheet,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: photoPath != null
                  ? FileImage(File(photoPath))
                  : null,
              child: photoPath == null
                  ? Icon(Icons.person, size: 60, color: Colors.grey.shade400)
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 18,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                onPressed: _showSourceBottomSheet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
