import 'package:flutter/material.dart';

import '../../../../../meta/Utility/Fade%20Route.dart';
import 'ForumTopic.dart';

class Forum extends StatelessWidget {
  final course;
  const Forum({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List forum = [
      {
        "title": "Dicussion Forums",
        "data": [
          {
            "title": "General Discussion",
            "subtitle":
                "Use this forum to discuss things related to the course that don't belong in any other forums"
          },
          {
            "title": "Meet & Greet",
            "subtitle":
                "Introduce yourself and say hello to your fellow classmates!"
          }
        ],
      },
      {
        "title": "Topic Forums",
        "data": [
          {
            "title": "Enterprise Design",
            "subtitle": "Discuss and ask questions about Enterprise Design."
          },
          {
            "title": "Designing for Specialization",
            "subtitle":
                "Discuss and ask questions about Designing for Specialization."
          },
          {
            "title": "Process Oriented Mindset",
            "subtitle":
                "Discuss and ask questions about Process Oriented Mindset."
          },
          {
            "title": "Release Management",
            "subtitle": "Discuss and ask questions about Release Management."
          },
        ]
      }
    ];
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: forum.length,
          itemBuilder: (BuildContext context, int index) {
            var a = forum[index];
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20),
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
                      a["title"],
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: a["data"].length,
                      itemBuilder: (BuildContext context, int i) {
                        var data = a["data"][i];
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  FadeRoute(
                                      page: ForumTopic(
                                    forum: data["title"],
                                  )),
                                );
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.format_list_bulleted),
                                ],
                              ),
                              title: Text(
                                data["title"],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                data["subtitle"],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
