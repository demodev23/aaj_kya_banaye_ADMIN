import 'views/profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//############# COLORS SECTION ####################

const Color black = Colors.black;
const Color amber = Colors.amber;
const Color red = Colors.red;
const Color burgandy = Color.fromARGB(0, 82, 2, 14);
const Color green = Color.fromARGB(255, 7, 134, 11);
const Color deep_blue = Color.fromARGB(255, 1, 25, 62);
const Color teal_shade = Color.fromARGB(255, 0, 98, 107);
const Color light_grey = Color.fromARGB(255, 171, 171, 171);
const Color grey = Colors.grey;
const Color dark_grey = Color.fromARGB(255, 97, 97, 97);
const Color blue = Color.fromARGB(255, 15, 140, 241);
const Color white = Colors.white;

const Color profile_display_font_color = Color(0xff00cdac);
const Color offWhite = Color.fromARGB(255, 202, 191, 191);

const List<Color> quiz_background = [
  Color.fromARGB(255, 76, 12, 87),
  Color.fromARGB(255, 40, 0, 47)
];

const List<Color> profile_display_background = [
  Color(0xff000428),
  Color(0xff004e92)
];
const Color quiz_buttons = Color.fromARGB(255, 202, 179, 179);

const Color quote_card_color = Color(0xff0F3E3A);

//############### FONTS SECTION ####################

const font_name = 'poppins';

const regular = FontWeight.w500;
const bold = FontWeight.bold;
const light = FontWeight.w300;

const extra_small = 12.0;
const small = 16.0;
const medium = 18.0;
const large = 20.0;
const extra_large = 22.0;
const splash_screen_font = 25.0;
const story_title_font = 24.0;

const text_field_style = TextStyle(
  fontFamily: font_name,
  fontSize: medium,
  fontWeight: FontWeight.w500,
);

const quiz_question_text_style = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 202, 191, 191),
  fontSize: 18,
);

const quiz_option_text_style = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 202, 191, 191),
  fontSize: 14,
);
//const Color quiz_option_border_unselected = Color.fromARGB(255, 202, 179, 179);
//const Color quiz_option_border_selected = Color.fromARGB(255, 2, 131, 36);

final Border quiz_option_border_unselected =
    Border.all(color: Color.fromARGB(255, 202, 179, 179), width: 1);

final Border quiz_option_border_selected =
    Border.all(color: Color.fromARGB(255, 2, 131, 36), width: 3);
