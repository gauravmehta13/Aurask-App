import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../auth/Login.dart';
import '../../auth/Onboarding.dart';
import '../My%20Courses/MyCourses%20TabBar.dart';
import '../Other/Premium%20Membership.dart';
import '../Other/Profile.dart';
import 'HomePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var seen = (prefs.getBool('seen') ?? false);
      if (!seen) {
        Navigator.push(
          context,
          FadeRoute(page: Onboarding()),
        );
      }
    });
  }

  int currentTabIndex = 0;

  List<Widget> tabs = [
    HomePage(),
    _auth.currentUser == null ? LoginScreen() : MyCoursesTabbar(),
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
            icon: Icon(FontAwesomeIcons.graduationCap),
            label: 'Programs',
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
