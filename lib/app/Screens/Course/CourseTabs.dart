import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';

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
          title: Text(widget.course["courses"]["name"]),
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
            Icon(Icons.directions_car),
            Icon(Icons.directions_car),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
