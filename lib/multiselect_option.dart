import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:flutter/material.dart';

/*
THIS WIDGET DISPLAYS THE KIND OF BUTTON THAT SAYS SELECT INTEREST 
WHEN TAP IT REGULATES VISIBILITY OF ANOTHER WIDGET THAT HAS THE VARIABLE MENTIONED IN visibility regulator FUNCTION IN THAT WIDGET CLASS
IT IS LIE SWITCH FOR ON/OFF  --- SHOW/HIDE 
STRUCTURE OF visibility_regulator function

visibility_regulator(){
    setState(){
      variable_name != variable_name;
    }

}

*/

Widget Multiselect_display(Function visibility_regulator) {
  return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(25.0, 15, 25, 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: black, width: 1)),
        child: const Text('Select Interest'),
      ),
      onTap: () {
        visibility_regulator();
      });
}
