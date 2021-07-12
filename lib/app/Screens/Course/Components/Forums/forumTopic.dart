import 'dart:math';

import 'package:aurask/meta/Utility/Constants.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forumQuestion.dart';

class ForumTopic extends StatefulWidget {
  final String forum;
  late bool isSelected;
  late String? title;

  ForumTopic({
    Key? key,
    this.forum = "",
    this.isSelected = false,
    this.title,
  }) : super(key: key);

  @override
  _ForumTopicState createState() => _ForumTopicState();
}

class _ForumTopicState extends State<ForumTopic> {
  List<ForumTopic> type = [];
  late ForumTopic selectedType;

  @override
  void initState() {
    super.initState();
    type.add(new ForumTopic(isSelected: true, title: 'All'));
    type.add(new ForumTopic(isSelected: false, title: 'Unanswered'));
  }

  @override
  Widget build(BuildContext context) {
    List questions = [
      {
        "query": "Manipulating Strings",
        "message":
            "There is an example of how to use the find() function in the slide named Parsing and Extracting. Could you please tell me why index 4 is not stored instead of index 31 in variable named sppos. The first space in the sentence is occurring in the 4th index just after the word From.",
        "name": "Shyam",
        "time": "3 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "i am struck here .i am near to deadline help me",
        "message": "#edited by mentor - do not post code",
        "name": "noobie",
        "time": "8 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
      {
        "query": "Assignment Instrument is broken",
        "message":
            "Assignment Instrument to week 1 is broken. I cannot use it to put the true code version to echieve to assignment. I see it like this (see the screensot). This system is not reacting on my actions",
        "name": "Rahul",
        "time": "6 days ago",
        "replies": [],
        "upvotes": ""
      },
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.forum),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: postQuery(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: new GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: type.length, childAspectRatio: 5),
              shrinkWrap: true,
              itemCount: type.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = type[index];
                      type.forEach((element) {
                        element.isSelected = false;
                      });
                      type[index].isSelected = true;
                      if (type[index].title == "All") {
                      } else {}
                      print(type[index].title);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: type[index].isSelected
                          ? primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: Center(
                      child: Text(type[index].title ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: type[index].isSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 20,
                        thickness: 5,
                      ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    var query = questions[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeRoute(
                              page: ForumQuestion(
                            query: query,
                          )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(query["query"],
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(query["time"],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            box10,
                            Text(query["name"],
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w500)),
                            box10,
                            Text(query["message"],
                                style: GoogleFonts.montserrat(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                            box20,
                            Row(
                              children: [
                                Text("${Random().nextInt(100)} Reply",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.grey)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "${Random().nextInt(100)} Upvote",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget postQuery() {
    return FloatingActionButton(
      // isExtended: true,
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            child: Container(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Ask Query",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ).then((val) {
          setState(() {});

          print(val);
        });
      },
    );
  }
}
