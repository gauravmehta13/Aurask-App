import 'package:aurask/core/resources/api_provider.dart';
import 'package:aurask/meta/Widgets/Loading.dart';
import 'package:flutter/material.dart';

import '../../../meta/Utility/Constants.dart';
import '../My%20Courses/Live%20Sessions.dart';
import '../My%20Courses/Self%20Tutorials.dart';

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
    getTempCourses();
  }

  List courses = [];
  List liveSessions = [];
  bool loading = true;

  getTempCourses() async {
    var tempCourses = await getMyCourses();
    setState(() {
      courses = tempCourses["courses"];
      liveSessions = tempCourses["liveSessions"];
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
          loading
              ? Loading()
              : Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // first tab bar view widget
                      SelfTutorials(
                        courses: courses,
                      ),

                      // second tab bar view widget
                      LiveSessions(
                        liveSessions: liveSessions,
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
