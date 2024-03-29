import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

abstract class BaseFirebaseExerciseModule {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth fbAuth = FirebaseAuth.instance;
  final String date =
      DateFormat.yMd().format(DateTime.now()).replaceAll('/', '-');
  final String month = DateFormat.M().format(DateTime.now());
  final String day = DateFormat.d().format(DateTime.now());
  final timeNow = DateTime.now();
}
