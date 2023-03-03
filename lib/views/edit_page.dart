import 'dart:io';

import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:aaj_kya_banaye_admin/custom_circular_indicator.dart';
import 'package:aaj_kya_banaye_admin/models/cards_model.dart';
import 'package:aaj_kya_banaye_admin/text_field.dart';
import 'package:aaj_kya_banaye_admin/views/firebase_collection.dart';
import 'package:aaj_kya_banaye_admin/views/pick_crop_compress_image.dart';
import 'package:aaj_kya_banaye_admin/views/profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dataeditor extends StatefulWidget {
  Cards dataobject;
  dataeditor({super.key, required this.dataobject});

  @override
  State<dataeditor> createState() => _dataeditorState();
}

class _dataeditorState extends State<dataeditor> {
  final form_key = GlobalKey<FormState>();

  final TextEditingController title_controller = TextEditingController();
  late bool is_jain;
  var photo;
  bool is_image_uploaded = false;

  bool on_tap = false;
  File image = File("");
  late String file_path;
  late String filename;

  List<dynamic> meal = [];
  List<dynamic> cuisine_item = [];
  String meal_type_dropdownvalue = "";
  String cuisine_type_dropdownvalue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cuisine_type_dropdownvalue = widget.dataobject.cuisine;
    meal_type_dropdownvalue = widget.dataobject.meal_type;
    is_jain = widget.dataobject.is_jain;
    title_controller.text = widget.dataobject.title;
    filename = widget.dataobject.document_id;
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    List<dynamic> cuisine_data_fetch = await cuisine_database.get().then(
      (value) {
        return value.docs.single.get('cuisine');
      },
    );

    List<dynamic> meal_data_fetch = await meal_type_database.get().then(
      (value) {
        return value.docs.single.get('meal_type');
      },
    );

    setState(() {
      cuisine_item = cuisine_data_fetch;
      meal = meal_data_fetch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
      ),
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
                    file_path = _image.path;
                    filename = widget.dataobject.document_id;
                    storage
                        .upload_photo(file_path, filename)
                        .whenComplete(() => setState(() {
                              is_image_uploaded = true;
                              image = File(_image.path);
                            }));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: Storage().photo_url(is_image_uploaded
                      ? filename
                      : widget.dataobject.document_id),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(snapshot.data.toString()));
                    }
                    return custom_loading();
                  },
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
                      style: TextStyle(fontSize: 20, color: black),
                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      // Array list of items
                      items: meal.map((value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
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
                          child: Text(
                            value.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
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
                      if (form_key.currentState!.validate()) {
                        cards_database.doc(widget.dataobject.document_id).set({
                          'title': title_controller.text,
                          'meal_type': meal_type_dropdownvalue,
                          'cuisine': cuisine_type_dropdownvalue,
                          'is_jain': is_jain,
                        }, SetOptions(merge: true));

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Edited Successfully')));
                        Navigator.pop(context);
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
        ),
      ),
    );
  }
}
