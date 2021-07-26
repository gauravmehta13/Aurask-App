import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'dart:io' show Platform;

import '../../../meta/Utility/Constants.dart';
import '../../auth/Login.dart';
import '../My%20Courses/MyCourses%20TabBar.dart';
import '../Other/Profile.dart';
import '../Purchase/Premium Membership.dart';
import 'HomePage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isAndroid) checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      print(info);
    }).catchError((e) {
      displaySnackBar(e.toString(), context);
    });
    print(_updateInfo?.updateAvailability);
    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? InAppUpdate.performImmediateUpdate()
            .catchError((e) => displaySnackBar(e.toString(), context))
        : print("Update Not Available");
  }

  int currentTabIndex = 0;

  List<Widget> tabs = [
    HomePage(),
    auth.currentUser == null ? LoginScreen() : MyCoursesTabbar(),
    PremiumMembership(),
    auth.currentUser == null ? LoginScreen() : ProfilePage()
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
