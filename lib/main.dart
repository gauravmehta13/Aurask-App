import 'package:aurask/Home/BottomNavBar.dart';
import 'package:aurask/auth/OnBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'notifications/importNoti.dart';
import 'notifications/notis/ab/abNoti.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Noti noti = AppNoti();

  @override
  void initState() {
    super.initState();
    Future(noti.init);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurask',
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: _auth.currentUser == null ? OnboardingScreen() : BottomNavBar(),
    );
  }
}
