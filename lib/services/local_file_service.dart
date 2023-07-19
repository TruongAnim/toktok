import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class LocalFileService {
  LocalFileService._();
  static final LocalFileService _instance = LocalFileService._();
  static LocalFileService get instance => _instance;

  Future<File> getFileFromUint8List(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/thumbnail.png';
    final file = File(tempPath);
    await file.writeAsBytes(bytes);
    return file;
  }
}
