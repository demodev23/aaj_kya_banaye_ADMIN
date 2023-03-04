import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:aaj_kya_banaye_admin/text_field.dart';
import 'package:aaj_kya_banaye_admin/views/firebase_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseFieldEditor extends StatefulWidget {
  const DatabaseFieldEditor({super.key});

  @override
  State<DatabaseFieldEditor> createState() => _DatabaseFieldEditorState();
}

class _DatabaseFieldEditorState extends State<DatabaseFieldEditor> {
  bool CuisineEditor = true;
  bool MealTypeEditor = false;
  bool InterestEditor = false;

  TextEditingController cuisine_controller = TextEditingController();
  TextEditingController interest_controller = TextEditingController();
  TextEditingController mealtype_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Database Field Editor'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      CuisineEditor = true;
                      MealTypeEditor = false;
                      InterestEditor = false;
                    });
                  },
                  child: const Text("Cuisine Editor")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      CuisineEditor = false;
                      MealTypeEditor = true;
                      InterestEditor = false;
                    });
                  },
                  child: const Text("Mealtype Editor")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      CuisineEditor = false;
                      MealTypeEditor = false;
                      InterestEditor = true;
                    });
                  },
                  child: const Text("Interest Editor")),
            ],
          ),
          Visibility(
              visible: CuisineEditor,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Add New Cuisine",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    name_field(
                        context, "Enter Cuisine Name", cuisine_controller),
                    ElevatedButton(
                        onPressed: () async {
                          if (cuisine_controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Enter Some Text")));
                          } else {
                            final docQuery = cuisine_database.limit(1);
                            final docSnapshot = await docQuery.get();

                            // Get the reference to the document from the query snapshot
                            final docRef = docSnapshot.docs.first.reference;

                            // Use the update method to append the new value to the existing array
                            await docRef.update({
                              'cuisine': FieldValue.arrayUnion(
                                  [cuisine_controller.text])
                            });
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Added Successfully")));
                              cuisine_controller.text = "";
                            });
                          }
                        },
                        child: const Text("ADD")),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Delete Existing",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    StreamBuilder(
                        stream: cuisine_database.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> cuisine_data =
                                snapshot.data!.docs.first.get('cuisine');
                            return Expanded(
                              child: ListView.builder(
                                itemCount: cuisine_data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(cuisine_data[index].toString()),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      final docQuery =
                                                          cuisine_database
                                                              .limit(1);
                                                      final docSnapshot =
                                                          await docQuery.get();

                                                      // Get the reference to the document from the query snapshot
                                                      final docRef = docSnapshot
                                                          .docs.first.reference;

                                                      // Use the update method to append the new value to the existing array
                                                      await docRef.update({
                                                        'cuisine': FieldValue
                                                            .arrayRemove([
                                                          cuisine_data[index]
                                                        ])
                                                      });
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Deleted Successfully")));
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yes")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                              ],
                                              content: Text(
                                                  "Are You Sure You Want to Delete ?"),
                                            );
                                          });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        })
                  ],
                ),
              )),
          Visibility(
              visible: MealTypeEditor,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Add New MealType",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    name_field(context, "Enter Meal Name", mealtype_controller),
                    ElevatedButton(
                        onPressed: () async {
                          if (mealtype_controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Enter Some Text")));
                          } else {
                            final docQuery = meal_type_database.limit(1);
                            final docSnapshot = await docQuery.get();

                            // Get the reference to the document from the query snapshot
                            final docRef = docSnapshot.docs.first.reference;

                            // Use the update method to append the new value to the existing array
                            await docRef.update({
                              'meal_type': FieldValue.arrayUnion(
                                  [mealtype_controller.text])
                            });
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Added Successfully")));
                              mealtype_controller.text = "";
                            });
                          }
                        },
                        child: const Text("ADD")),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Delete Existing",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    StreamBuilder(
                        stream: meal_type_database.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> meal_type_data =
                                snapshot.data!.docs.first.get('meal_type');
                            return Expanded(
                              child: ListView.builder(
                                itemCount: meal_type_data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title:
                                        Text(meal_type_data[index].toString()),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      final docQuery =
                                                          meal_type_database
                                                              .limit(1);
                                                      final docSnapshot =
                                                          await docQuery.get();

                                                      // Get the reference to the document from the query snapshot
                                                      final docRef = docSnapshot
                                                          .docs.first.reference;

                                                      // Use the update method to append the new value to the existing array
                                                      await docRef.update({
                                                        'meal_type': FieldValue
                                                            .arrayRemove([
                                                          meal_type_data[index]
                                                        ])
                                                      });
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Deleted Successfully")));
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yes")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                              ],
                                              content: Text(
                                                  "Are You Sure You Want to Delete ?"),
                                            );
                                          });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        })
                  ],
                ),
              )),
          Visibility(
              visible: InterestEditor,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Add New Interest",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    name_field(
                        context, "Enter Interest Name", interest_controller),
                    ElevatedButton(
                        onPressed: () async {
                          if (interest_controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please Enter Some Text")));
                          } else {
                            final docQuery = interest_database.limit(1);
                            final docSnapshot = await docQuery.get();

                            // Get the reference to the document from the query snapshot
                            final docRef = docSnapshot.docs.first.reference;

                            // Use the update method to append the new value to the existing array
                            await docRef.update({
                              'interest': FieldValue.arrayUnion(
                                  [interest_controller.text])
                            });
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Added Successfully")));
                              interest_controller.text = "";
                            });
                          }
                        },
                        child: const Text("ADD")),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Delete Existing",
                          style: TextStyle(fontSize: 25, fontWeight: bold)),
                    ),
                    StreamBuilder(
                        stream: interest_database.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> interest_data =
                                snapshot.data!.docs.first.get('interest');
                            return Expanded(
                              child: ListView.builder(
                                itemCount: interest_data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title:
                                        Text(interest_data[index].toString()),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      final docQuery =
                                                          interest_database
                                                              .limit(1);
                                                      final docSnapshot =
                                                          await docQuery.get();

                                                      // Get the reference to the document from the query snapshot
                                                      final docRef = docSnapshot
                                                          .docs.first.reference;

                                                      // Use the update method to append the new value to the existing array
                                                      await docRef.update({
                                                        'interest': FieldValue
                                                            .arrayRemove([
                                                          interest_data[index]
                                                        ])
                                                      });
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Deleted Successfully")));
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yes")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                              ],
                                              content: Text(
                                                  "Are You Sure You Want to Delete ?"),
                                            );
                                          });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        })
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
