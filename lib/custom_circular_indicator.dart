import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:flutter/material.dart';

/*
  THIS WIDGET IS USED TO DISPLAY LOADING ---BUFFER IN A CUSTOMIZED DESIGN 
*/
Widget custom_loading() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        'loading...',
        style: TextStyle(
          fontFamily: font_name,
          fontSize: small,
          fontWeight: bold,
          color: deep_blue,
        ),
      ),
      CircularProgressIndicator(),
    ],
  );
}
