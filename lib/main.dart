import 'package:aurask/auth/OnBoarding.dart';
import 'package:aurask/auth/UserDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants.dart';
import 'Home/BottomNavBar.dart';
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
  late bool seen;
  bool loading = true;
  Widget home = BottomNavBar();
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
    Future(noti.init);
  }

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      seen = (prefs.getBool('seen') ?? false);
      if (!seen) {
        home = Onboarding();
      }
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(child: Center(child: CircularProgressIndicator()))
        : MaterialApp(
            title: 'Aurask',
            theme: themeData(context),
            debugShowCheckedModeBanner: false,
            home: Onboarding()
            //  home
            );
  }
}
