import 'dart:convert';

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

class _SessionTabsState extends State<SessionTabs>
    with SingleTickerProviderStateMixin {
  void _update(int count) {
    _tabController.animateTo(count);
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  int initialIndex = 0;
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final data = widget.course["data"];
    return DefaultTabController(
      length: 5,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(data["name"]),
          backgroundColor: primaryColor,
          //  leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          actions: <Widget>[
            //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          bottom: TabBar(controller: _tabController, isScrollable: true, tabs: [
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
          controller: _tabController,
          children: [
            SessionOverview(
              course: widget.course,
              tab: _update,
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
