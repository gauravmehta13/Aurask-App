import 'dart:math';
import 'package:aurask/app/Screens/Quiz/quiz_page.dart';
import 'package:aurask/core/model/category.dart';
import 'package:aurask/core/model/question.dart';
import 'package:aurask/core/resources/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../meta/Utility/Constants.dart';

class SessionOverview extends StatefulWidget {
  final course;
  final ValueChanged<int> tab;
  const SessionOverview({Key? key, required this.course, required this.tab})
      : super(key: key);

  @override
  _SessionOverviewState createState() => _SessionOverviewState();
}

class _SessionOverviewState extends State<SessionOverview> {
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.course["data"]["syllabus"].length; i++) {
      List newContent = ["Practice Exercise", "Discussion Forums"];
      widget.course["data"]["syllabus"][i]["content"].addAll(newContent);
    }
  }

  final Category category =
      Category(18, "Computer", icon: FontAwesomeIcons.laptopCode);

  startQuiz() async {
    List<Question> questions = await getQuestions(category, 10, "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => QuizPage(
                  questions: questions,
                  isTest: true,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.course["data"];
    print(widget.course["meetData"]);
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data["syllabus"].length,
          itemBuilder: (BuildContext context, int index) {
            var x = data["syllabus"][index];
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
                          onTap: () async {
                            isQuiz(x["content"][i])
                                ? startQuiz()
                                : isDiscussion(x["content"][i])
                                    ? widget.tab(2)
                                    : await launch(
                                        widget.course["meetData"]["meetLink"]);
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
