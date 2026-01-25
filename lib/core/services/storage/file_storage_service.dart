import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileStorageService {
  Future<String> saveFile(File file, String subDirectory) async {
    final directory = await getApplicationDocumentsDirectory();
    final folderPath = '${directory.path}/$subDirectory';
    final folder = Directory(folderPath);

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}';
    final savedFile = await file.copy('$folderPath/$fileName');
    
    return savedFile.path;
  }

  Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
