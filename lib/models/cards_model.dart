import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Cards {
  late bool is_jain;
  late String meal_type;
  late String title;
  late String cuisine;
  late String document_id;
  Cards(
      this.title, this.is_jain, this.meal_type, this.cuisine, this.document_id);

  Cards.fromJSON(Map<String, dynamic> json) {
    title = json['title'];
    is_jain = json['is_jain'];
    meal_type = json['Meal_type'];
    cuisine = json['cuisine'];
    document_id = json['document_id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'is_jain': is_jain,
        'meal_type': meal_type,
        'cuisine': cuisine,
        'document_id': document_id,
      };
}

class CardImage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> card_image_url_method(String filename) async {
    String card_filename = filename;

    String card_image_url =
        await storage.ref('cards/$card_filename').getDownloadURL();

    return card_image_url;
  }
}
