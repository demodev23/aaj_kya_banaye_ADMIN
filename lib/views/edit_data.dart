import 'package:aaj_kya_banaye_admin/constant.dart';
import 'package:aaj_kya_banaye_admin/models/cards_model.dart';
import 'package:aaj_kya_banaye_admin/text_field.dart';
import 'package:aaj_kya_banaye_admin/views/edit_page.dart';
import 'package:aaj_kya_banaye_admin/views/firebase_collection.dart';
import 'package:aaj_kya_banaye_admin/views/profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class edit_data extends StatefulWidget {
  const edit_data({super.key});

  @override
  State<edit_data> createState() => _edit_dataState();
}

TextEditingController dishnamecontroller = TextEditingController();
List<Cards> cards = [];

class _edit_dataState extends State<edit_data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items List'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: cards_database.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamsnapshot) {
            if (streamsnapshot.hasData) {
              cards = [];
              int temp = streamsnapshot.data!.docs.length;
              for (int i = 0; i < temp; i++) {
                cards.add(Cards(
                  streamsnapshot.data!.docs[i]['title'],
                  streamsnapshot.data!.docs[i]['is_jain'],
                  streamsnapshot.data!.docs[i]['meal_type'],
                  streamsnapshot.data!.docs[i]['cuisine'],
                  streamsnapshot.data!.docs[i].id.toString(),
                ));
              }
              return ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cards[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    dataeditor(
                                                        dataobject:
                                                            cards[index])));
                                      },
                                      child: Text("Edit data")),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      String docid =
                                                          cards[index]
                                                              .document_id;
                                                      storage
                                                          .delete_photo(docid);
                                                      await cards_database
                                                          .doc(cards[index]
                                                              .document_id)
                                                          .delete();
                                                      Navigator.pop(context);
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
                                    child: Text("Delete Data"),
                                  )
                                ],
                                content: Text('Operations'),
                              );
                            });
                      },
                    );
                  });
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
