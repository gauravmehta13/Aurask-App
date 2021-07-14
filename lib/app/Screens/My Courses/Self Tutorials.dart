import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../Course/CourseTabs.dart';

class SelfTutorials extends StatefulWidget {
  final courses;
  SelfTutorials({required this.courses});
  @override
  _SelfTutorialsState createState() => _SelfTutorialsState();
}

class _SelfTutorialsState extends State<SelfTutorials> {
  List myCourses = [];
  List filteredCourses = [];
  @override
  void initState() {
    super.initState();
    filteredCourses = widget.courses;
  }

  filter(condition) {
    filteredCourses =
        (myCourses).where((u) => u["courseType"]["id"] == condition).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredCourses.length,
              itemBuilder: (BuildContext context, int index) {
                var course = filteredCourses[index]["data"];
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        FadeRoute(
                            page: CourseTabs(
                          course: course,
                        )));
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(bottom: 16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 100,
                          child: Image.network(
                            course["image"],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(course["name"],
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 4.3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemSize: 15,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (double value) {},
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(course["description"],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
