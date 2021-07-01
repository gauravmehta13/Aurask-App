import 'package:aurask/auth/OnBoarding.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurask',
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
