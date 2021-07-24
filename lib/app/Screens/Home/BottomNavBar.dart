import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:native_updater/native_updater.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../auth/Login.dart';
import '../../auth/Onboarding.dart';
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

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      print(info);
    }).catchError((e) {
      showSnack(e.toString());
    });
    print(_updateInfo?.updateAvailability);
    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? InAppUpdate.performImmediateUpdate()
            .catchError((e) => showSnack(e.toString()))
        : print("Update Not Available");
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
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
