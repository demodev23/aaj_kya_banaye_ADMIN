//################ FIREBASE CONSTANT VALUES #####################

import 'profile_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser;
final CollectionReference user_database =
    FirebaseFirestore.instance.collection('user_profile');
final CollectionReference cards_database =
    FirebaseFirestore.instance.collection('cards');

final interest_database = FirebaseFirestore.instance.collection('interest');

final CollectionReference cuisine_database =
    FirebaseFirestore.instance.collection('cuisine');

final Storage storage = Storage();
