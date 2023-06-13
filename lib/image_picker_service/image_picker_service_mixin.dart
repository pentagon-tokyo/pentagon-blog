import 'package:flutter/material.dart';

/// ここにはmobileとwebの両方で使える処理を書く
mixin ImagePickerServiceMixin {
  Future<void> showAccessDeniedDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
    return;
  }
}
