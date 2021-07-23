import 'package:flutter/material.dart';

import '../../../meta/Utility/Constants.dart';
import 'Components/Forums/forums.dart';
import 'Components/grades.dart';
import 'Components/info.dart';
import 'Components/overview.dart';
import 'Components/resources.dart';

class SessionTabs extends StatefulWidget {
  final Map course;
  const SessionTabs({Key? key, required this.course}) : super(key: key);

  @override
  _SessionTabsState createState() => _SessionTabsState();
}

class _SessionTabsState extends State<SessionTabs> {
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.course["syllabus"].length; i++) {
      List newContent = ["Practice Exercise", "Discussion Forums"];
      widget.course["syllabus"][i]["content"].addAll(newContent);
    }
  }

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
            SessionOverview(
              course: widget.course,
            ),
            SessionGrades(
              course: widget.course,
            ),
            Forum(
              course: widget.course,
            ),
            SessionResources(
              course: widget.course,
            ),
            SessionInfo(
              course: widget.course,
            )
          ],
        ),
      ),
    );
  }
}
