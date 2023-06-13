import 'dart:typed_data';

import 'package:exif/image_picker_service/export.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _imageFile;
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                _imageFile = await ImagePickerService().pickImage(context);
                if (_imageFile == null) {
                  return;
                }
                _imageBytes = await _imageFile!.readAsBytes();
                setState(() {});
              },
              child: const Text('画像を選択'),
            ),
            if (_imageFile != null && _imageBytes != null) ...[
              ElevatedButton(
                onPressed: () {
                  ImagePickerService().downloadFile(_imageFile!.path);
                },
                child: const Text('ダウンロード'),
              ),
              Image.memory(
                _imageBytes!,
                height: 500,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
