import 'dart:math';
import 'package:aurask/app/Screens/Home/HomePage.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: allCourse[0]["syllabus"].length,
          itemBuilder: (BuildContext context, int index) {
            var x = allCourse[0]["syllabus"][index];
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
                          onTap: () {},
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              Text(
                                "Video",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              Text(
                                "${Random().nextInt(100)} min",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
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
}
