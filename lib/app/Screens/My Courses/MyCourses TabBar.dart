import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../My%20Courses/Live%20Sessions.dart';
import '../My%20Courses/Self%20Tutorials.dart';
import '../../../meta/Utility/Constants.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyCoursesTabbar extends StatefulWidget {
  @override
  _MyCoursesTabbarState createState() => _MyCoursesTabbarState();
}

class _MyCoursesTabbarState extends State<MyCoursesTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getMyCourses();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future getMyCourses() async {
    try {
      var dio = Dio();

      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=ORDER01&usecase=aurask&tenantUsecase=get",
          data: {
            "id": _auth.currentUser?.uid,
          });
      print(response.data);
      displaySnackBar(response.data["resp"], context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Courses',
        ),
      ),
      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: EdgeInsets.all(5),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: primaryColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Courses',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Live Sessions',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                SelfTutorials(),

                // second tab bar view widget
                LiveSessions()
              ],
            ),
          ),
        ],
      ),
    );
  }
}