import 'dart:io';

import 'package:aaj_kya_banaye_admin/views/image_filter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future<File> getCropCompressImage(BuildContext context) async {
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  File? newImage;
  if (image != null) {
    newImage = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ImageFilterScreen(
                  image: File(image.path),
                )));

    final filePath = newImage!.absolute.path;
    final fileExtension = filePath.split(".").last;

    if (fileExtension != "heic" && fileExtension != "png") {
      final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
      final splitted =
          filePath.substring(0, filePath.length - (fileExtension.length + 1));
      final outPath = "${splitted}_out.$fileExtension";

      File? newImg = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 30,
      );
      File(image.path).delete();
      newImage = newImg!;
    } else {
      newImage = File(image.path);
    }
  }
  return newImage!;
}
