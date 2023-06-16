import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// このクラスは実際には呼び出されないが、IDEの補完を効かせるために定義している
class ImagePickerService {
  /// このメソッドは実際には呼び出されない
  Future<XFile?> pickImage(BuildContext context) async {
    throw UnsupportedError('');
  }

  Future<XFile?> downloadFile(String url) async {
    throw UnsupportedError('');
  }
}
