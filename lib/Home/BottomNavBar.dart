import 'package:aurask/Home/HomePage.dart';
import 'package:aurask/Screens/MyCourses.dart';
import 'package:aurask/Screens/Premium%20Membership.dart';
import 'package:aurask/Screens/Profile.dart';
import 'package:aurask/auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTabIndex = 0;

  List<Widget> tabs = [
    HomePage(),
    _auth.currentUser == null ? LoginScreen() : MyCourses(),
    PremiumMembership(),
    _auth.currentUser == null ? LoginScreen() : ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 9,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[700],
        enableFeedback: true,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            currentTabIndex = value;
          });
        },
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
