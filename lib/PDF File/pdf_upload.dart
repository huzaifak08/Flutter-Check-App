import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class PDFUpload extends StatefulWidget {
  const PDFUpload({super.key});

  @override
  State<PDFUpload> createState() => _PDFUploadState();
}

class _PDFUploadState extends State<PDFUpload> {
  // PlatformFile? pickedFile;

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  Future<String?> uploadFile(File file) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('uploads/${file.path.split('/').last}');
      firebase_storage.UploadTask task = ref.putFile(file);
      firebase_storage.TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 200,
              color: Colors.blue,
              // child: pickedFile == null
              //     ? Text('No File selected')
              //     : Text(pickedFile!.name),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Select File'),
            ),
            ElevatedButton(
              onPressed: () async {
                File? file = await pickFile();
                if (file != null) {
                  String? downloadUrl = await uploadFile(file);
                  if (downloadUrl != null) {
                    // File uploaded successfully, do something with downloadUrl
                  } else {
                    // Error occurred while uploading file
                  }
                } else {
                  // No file selected
                }
              },
              child: Text('Upload file'),
            )
          ],
        ),
      ),
    );
  }
}
