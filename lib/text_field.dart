import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget name_field(
    context, String label, TextEditingController _name_controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: TextFormField(
      keyboardType: TextInputType.name,
      cursorHeight: 18,
      style: text_field_style,
      controller: _name_controller,
      decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: black, width: 1))),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
          return "Enter Correct Name...";
        }
        return null;
      },
    ),
  );
}
