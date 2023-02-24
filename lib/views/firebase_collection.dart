//################ FIREBASE CONSTANT VALUES #####################

import 'profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser;
final CollectionReference user_database =
    FirebaseFirestore.instance.collection('user_profile');
final CollectionReference cards_database =
    FirebaseFirestore.instance.collection('cards');
final CollectionReference profile_card_database =
    FirebaseFirestore.instance.collection('profile_cards_database');
final CollectionReference quiz_database =
    FirebaseFirestore.instance.collection('quiz');
final interest_database = FirebaseFirestore.instance.collection('interest');
final CollectionReference quotes_database =
    FirebaseFirestore.instance.collection('quotes');

final CollectionReference saved_quote_database =
    FirebaseFirestore.instance.collection('saved_quote_database');

final CollectionReference swipe_card =
    FirebaseFirestore.instance.collection('swipe_card');

final CollectionReference swipe_quiz =
    FirebaseFirestore.instance.collection('swipe_quiz');

final CollectionReference swipe_quiz_choice =
    FirebaseFirestore.instance.collection('swipe_quiz_choice');

final Storage storage = Storage();
