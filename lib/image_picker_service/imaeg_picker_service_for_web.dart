// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:exif/image_picker_service/compress_for_web.dart';
import 'package:exif/image_picker_service/image_picker_service_mixin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:js/js_util.dart';
import 'package:path/path.dart' as p;

class ImagePickerService with ImagePickerServiceMixin {
  final _imagePicker = ImagePicker();

  Future<XFile?> pickImage(BuildContext context) async {
    final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    return _processImage(xFile!);
  }

  void downloadFile(String url) {
    html.AnchorElement(href: url)
      ..download = url
      ..click();
  }

  Future<XFile> _processImage(
    XFile xFile,
  ) async {
    // dartで変換すると重いのでjsで変換する
    final compressedFile =
        await promiseToFuture<html.Blob>(compress(xFile.path));

    final path = html.Url.createObjectUrlFromBlob(compressedFile);

    return XFile(
      path,
      name: p.basename('$path.jpg'),
      lastModified: await xFile.lastModified(),
    );
  }
}
