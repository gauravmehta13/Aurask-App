import 'package:flutter/material.dart';

import '../../../meta/Utility/Constants.dart';
import 'Components/Forums/forums.dart';
import 'Components/grades.dart';
import 'Components/info.dart';
import 'Components/overview.dart';
import 'Components/resources.dart';

class CourseTabs extends StatefulWidget {
  final Map course;
  const CourseTabs({Key? key, required this.course}) : super(key: key);

  @override
  _CourseTabsState createState() => _CourseTabsState();
}

class _CourseTabsState extends State<CourseTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.course["name"]),
          backgroundColor: primaryColor,
          //  leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          actions: <Widget>[
            //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(
              text: "Overview",
            ),
            Tab(
              text: "Grades",
            ),
            Tab(
              text: "Forums",
            ),
            Tab(
              text: "Resources",
            ),
            Tab(
              text: "Info",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            CourseOverview(
              course: widget.course,
            ),
            CourseGrades(
              course: widget.course,
            ),
            Forum(
              course: widget.course,
            ),
            CourseResources(
              course: widget.course,
            ),
            CourseInfoTab(
              course: widget.course,
            )
          ],
        ),
      ),
    );
  }
}
