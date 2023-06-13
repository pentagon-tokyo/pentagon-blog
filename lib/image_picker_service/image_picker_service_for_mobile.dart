import 'dart:io';

import 'package:exif/image_picker_service/image_picker_service_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ImagePickerService with ImagePickerServiceMixin {
  final _imagePicker = ImagePicker();

  Future<XFile?> pickImage(BuildContext context) async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (xFile == null) {
        return null;
      }

      if (context.mounted) {
        // do nothing
      } else {
        return null;
      }

      return _processImage(xFile);
    } on PlatformException catch (e) {
      await _handleAccessDeniedException(context, e);
    }
    return null;
  }

  void downloadFile(String url) async {
    await Share.shareFiles([url]);
  }

  Future<XFile> _processImage(
    XFile xFile,
  ) async {
    // 圧縮とExifを消す処理
    final uint8List =
        await FlutterImageCompress.compressWithFile(xFile.path, quality: 85);

    if (uint8List == null) {
      throw Exception('画像の処理に失敗しました。');
    }

    final file = File(
      (await getTemporaryDirectory()).path + p.separator + xFile.name,
    );
    final path = (await file.writeAsBytes(uint8List)).path;

    return XFile.fromData(
      uint8List,
      lastModified: await xFile.lastModified(),
      path: path,
    );
  }

  Future<void> _handleAccessDeniedException(
    BuildContext context,
    PlatformException e,
  ) async {
    if (e.code == 'camera_access_denied') {
      await showAccessDeniedDialog(
        context,
        'カメラへのアクセスを許可されていません。',
        '設定 > 不動産人脈DX > カメラから設定を変更してください。',
      );
    } else if (e.code == 'photo_access_denied') {
      await showAccessDeniedDialog(
        context,
        '写真へのアクセスを許可されていません。',
        '設定 > 不動産人脈DX > 写真から設定を変更してください。',
      );
    } else {
      throw e;
    }
  }
}
