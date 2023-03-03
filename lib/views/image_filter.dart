import 'dart:io';

import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as image_lib;

class ImageFilterScreen extends StatefulWidget {
  static const routeName = "/image-filter-screen";
  File image;
  ImageFilterScreen({Key? key, required File this.image}) : super(key: key);

  @override
  State<ImageFilterScreen> createState() => _ImageFilterScreenState();
}

class _ImageFilterScreenState extends State<ImageFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.72,
            width: size.width,
            // color: white,
            child: Image.file(
              widget.image,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () async {
                final croppedFile = await ImageCropper().cropImage(
                  sourcePath: widget.image.path,
                  compressFormat: ImageCompressFormat.jpg,
                  compressQuality: 80,
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Crop image',
                        toolbarColor: white,
                        toolbarWidgetColor: Colors.green,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false,
                        activeControlsWidgetColor: Colors.green),
                    IOSUiSettings(
                      title: 'Crop',
                    ),
                    WebUiSettings(
                      context: context,
                      presentStyle: CropperPresentStyle.dialog,
                      boundary: const CroppieBoundary(
                        width: 520,
                        height: 520,
                      ),
                      viewPort: const CroppieViewPort(
                          width: 480, height: 480, type: 'circle'),
                      enableExif: true,
                      enableZoom: true,
                      showZoomer: true,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  setState(() {
                    {
                      setState(() {
                        widget.image = File(croppedFile.path);
                      });
                      // _croppedFile = croppedFile;
                    }
                  });
                }
              },
              child: const Text(
                "Crop",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: medium,
                  fontFamily: "Gilroy",
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.pop(context, widget.image);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              width: 100,
              child: Center(
                  child: Text(
                "Next",
                style: TextStyle(color: white),
              )),
            ),
          ),
        ],
      ),
    ));
  }
}
