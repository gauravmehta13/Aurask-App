import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  Future updateUserData(String experience, String level) async {
    await FirebaseFirestore.instance.collection("Details").doc(uid).set({
      "name": _auth.currentUser?.displayName ?? "",
      "email": _auth.currentUser?.email ?? "",
      "level": level,
      "experience": experience,
    });
  }
}
