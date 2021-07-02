import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  Future updateUserData(String experience, String level) async {
    await FirebaseFirestore.instance.collection("Details").doc(uid).set({
      "level": level,
      "experience": experience,
    });
  }
}
