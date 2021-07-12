import 'dart:math';

import '../../../../../meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForumQuestion extends StatefulWidget {
  final query;
  const ForumQuestion({Key? key, this.query}) : super(key: key);

  @override
  _ForumQuestionState createState() => _ForumQuestionState();
}

class _ForumQuestionState extends State<ForumQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Discussion Thread"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                box10,
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.query["query"],
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    Text(widget.query["time"],
                        style: GoogleFonts.montserrat(
                            fontSize: 10, fontWeight: FontWeight.w500)),
                  ],
                ),
                box10,
                Text(widget.query["name"],
                    style: GoogleFonts.montserrat(
                        fontSize: 10, fontWeight: FontWeight.w500)),
                box10,
                Text(widget.query["message"],
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
                Divider(),
                Row(children: [
                  Icon(Icons.reply),
                  Text("Reply"),
                  wbox20,
                  Icon(Icons.arrow_upward_sharp),
                  Text("Upvote"),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
