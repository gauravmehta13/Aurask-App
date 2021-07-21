import 'package:flutter/material.dart';

import '../../../../meta/Utility/Constants.dart';
import '../../../../meta/Utility/Fade%20Route.dart';
import '../../Other/InstructorPage.dart';

class SessionInfo extends StatelessWidget {
  final course;
  const SessionInfo({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          box20,
          Card(
            margin: EdgeInsets.zero,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Course Instructor",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                    box20,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, FadeRoute(page: InstructorProfile()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: NetworkImage(
                                  "https://media-exp3.licdn.com/dms/image/C5603AQGacJ-P9gTj7w/profile-displayphoto-shrink_400_400/0/1517799815988?e=1630540800&v=beta&t=8G_NtmxHv0FI0hIcXO5W4XJcVnVFJ8QG1rBXPLV2f8E"),
                            ),
                            wbox20,
                            Expanded(
                              flex: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vinay Yadav",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  box5,
                                  Text(
                                    "Software Development Manager at Amazon",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          box20,
          Card(
            margin: EdgeInsets.zero,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Course Description",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                    box20,
                    Text(
                      "This course will introduce the core data structures of the Python programming language. We will move past the basics of procedural programming and explore how we can use the Python built-in data structures such as lists, dictionaries, and tuples to perform increasingly complex data analysis. This course will cover Chapters 6-10 of the textbook “Python for Everybody”.  This course covers Python 3.",
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                    ),
                    box20,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
