import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getRanking() async {
    return FirebaseFirestore.instance
        .collection("ranking")
        .doc('2GOkqb66RNxLpod5d99V')
        .snapshots();
  }
}
