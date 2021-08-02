import 'dart:math';

import 'package:aurask/app/Screens/Quiz/home.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:flutter/material.dart';

import '../../../../meta/Utility/Constants.dart';

class SessionOverview extends StatelessWidget {
  final course;
  final ValueChanged<int> tab;
  const SessionOverview({Key? key, required this.course, required this.tab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: course["syllabus"].length,
          itemBuilder: (BuildContext context, int index) {
            var x = course["syllabus"][index];
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                  top: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      x["title"],
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: x["content"].length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          onTap: () {
                            isQuiz(x["content"][i])
                                ? Navigator.push(
                                    context, FadeRoute(page: QuizHome()))
                                : isDiscussion(x["content"][i])
                                    ? tab(2)
                                    : displaySnackBar("Coming Soon", context);
                          },
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isDiscussion(x["content"][i]))
                                Icon(
                                  Icons.chat,
                                  color: primaryColor,
                                )
                              else if (isQuiz(x["content"][i]))
                                Icon(
                                  Icons.quiz,
                                  color: primaryColor,
                                )
                              else
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        shape: BoxShape.circle),
                                    padding: EdgeInsets.all(3),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: primaryColor,
                                      size: 17,
                                    )),
                            ],
                          ),
                          title: Text(
                            x["content"][i],
                            style: TextStyle(fontSize: 13),
                          ),
                          subtitle: Row(
                            children: [
                              if (isDiscussion(x["content"][i]))
                                Row(
                                  children: [
                                    Text(
                                      "Forum",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "${Random().nextInt(100)} min",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              else if (isQuiz(x["content"][i]))
                                Row(
                                  children: [
                                    Text(
                                      "Quiz",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "${Random().nextInt(100)} min",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    Text(
                                      "Video",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "${Random().nextInt(100)} min",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }

  bool isVideo(text) {
    if (text.toString().contains("Video"))
      return true;
    else
      return false;
  }

  bool isQuiz(text) {
    if (text.toString().contains("Practice"))
      return true;
    else
      return false;
  }

  bool isDiscussion(text) {
    if (text.toString().contains("Discussion"))
      return true;
    else
      return false;
  }
}
