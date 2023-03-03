import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> upload_photo(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await storage.ref('cards/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> photo_url(String filename) async {
    String download_url = "";
    download_url = await storage.ref('cards/$filename').getDownloadURL();

    return download_url;
  }

  delete_photo(String filename) async {
    await storage.ref('cards/${filename}').delete();
  }
}
