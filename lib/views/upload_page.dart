// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:aaj_kya_banaye_admin/custom_circular_indicator.dart';
import 'package:aaj_kya_banaye_admin/multiselect_option.dart';
import 'package:aaj_kya_banaye_admin/text_field.dart';
import 'package:aaj_kya_banaye_admin/views/firebase_collection.dart';
import 'package:aaj_kya_banaye_admin/views/pick_crop_compress_image.dart';
import 'package:aaj_kya_banaye_admin/views/profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final form_key = GlobalKey<FormState>();

  final TextEditingController title_controller = TextEditingController();
  bool is_jain = false;
  var photo;
  bool is_image_uploaded = false;

  List<String> _selectedItems = [];
  bool on_tap = false;
  File image = File("");
  late String file_path;
  late String filename;
  String docid = cards_database.doc().id.toString();
  bool file_uploaded = false;

  List<String> meal = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  List<dynamic> cuisine_item = [];
  String meal_type_dropdownvalue = 'Breakfast';
  String cuisine_type_dropdownvalue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    List<dynamic> temp = await cuisine_database.get().then(
      (value) {
        return value.docs.single.get('cuisine');
      },
    );
    cuisine_type_dropdownvalue = temp[0].toString();
    setState(() {
      cuisine_item = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
        key: form_key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade900,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Upload Profile Picture',
                        style: TextStyle(
                            fontFamily: font_name,
                            fontSize: large,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.file_upload,
                        color: white,
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  final File _image = await getCropCompressImage(context);
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No Profile Photo Selected')));
                    return null;
                  } else {
                    file_path = _image.path;
                    filename = docid;
                    storage
                        .upload_photo(file_path, filename)
                        .whenComplete(() => setState(() {
                              is_image_uploaded = true;
                              image = File(_image.path);
                            }));
                    file_uploaded = true;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              is_image_uploaded
                  ? FutureBuilder(
                      future: Storage().photo_url(filename),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (is_image_uploaded) {
                          return Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 150,
                              child: ClipRRect(
                                  child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              )));
                        }
                        return Visibility(
                          visible: is_image_uploaded,
                          child: custom_loading(),
                        );
                      },
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              const SizedBox(
                height: 20,
              ),
              name_field(context, "Enter Dish Name", title_controller),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    " Select Meal Type -:",
                    style: TextStyle(fontSize: extra_large, fontWeight: bold),
                  ),
                  DropdownButton(
                    // Initial Value
                    value: meal_type_dropdownvalue,
                    itemHeight: 50,
                    style: TextStyle(
                        fontSize: extra_large, fontWeight: bold, color: black),
                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    dropdownColor: offWhite,
                    // Array list of items
                    items: meal.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        meal_type_dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    " Select Cuisine Type -:",
                    style: TextStyle(fontSize: large, fontWeight: bold),
                  ),
                  DropdownButton(
                    value: cuisine_type_dropdownvalue,
                    items: cuisine_item.map((value) {
                      return DropdownMenuItem<dynamic>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      // Do something with the selected value
                      setState(() {
                        cuisine_type_dropdownvalue = selectedValue;
                      });
                    },
                  ),
                ],
              ),
              /*StreamBuilder(
                  stream: cuisine_database.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> cuisinesnapshot) {
                    if (cuisinesnapshot.hasData) {
                      var temp =
                          cuisinesnapshot.data!.docs.first.get('cuisine');
                      print("this is temp = ${temp}");
                      cuisine_item = [];
                      for (int i = 0; i < temp.length; i++) {
                        cuisine_item.add(temp[i].toString());
                      }

                      print("this is cuisine_item = ${cuisine_item}");
                      if (cuisine_item.isNotEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              " Select Cuisine Type -:",
                              style: TextStyle(
                                  fontSize: extra_large, fontWeight: bold),
                            ),

                          ],
                        );
                      }
                    }
                    return custom_loading();
                  }),

                  */
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " is it Jain ??",
                    style: TextStyle(
                      fontSize: large,
                      fontWeight: bold,
                    ),
                  ),
                  Switch(
                    value: is_jain,
                    onChanged: (newValue) {
                      setState(() {
                        is_jain = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (form_key.currentState!.validate() && image != null) {
                      cards_database.doc(docid).set({
                        'title': title_controller.text,
                        'meal_type': meal_type_dropdownvalue,
                        'cuisine': cuisine_type_dropdownvalue,
                        'is_jain': is_jain,
                      }, SetOptions(merge: true));

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Uploaded Successfully')));

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF004b26))),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontFamily: font_name,
                          fontSize: extra_large,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
