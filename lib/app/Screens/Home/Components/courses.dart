import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../meta/Utility/Constants.dart';

Widget buildPopularCourses(popularCourses, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Popular Courses 🔥",
                style: GoogleFonts.montserrat(
                    fontSize: 17, fontWeight: FontWeight.w600)),
            InkWell(
              onTap: () {
                Modular.to.pushNamed('/search');
              },
              child: Text("See all",
                  style: GoogleFonts.montserrat(
                      decoration: TextDecoration.underline,
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      box10,
      Container(
        height: 200,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: popularCourses.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Modular.to
                      .pushNamed('/course', arguments: popularCourses[index]);
                  // Navigator.push(
                  //   context,
                  //   FadeRoute(
                  //       page: CourseInfo(
                  //     course: popularCourses[index],
                  //   )),
                  // );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Image.network(
                                popularCourses[index]["image"],
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 7),
                              child: Text(
                                "⭐ ${popularCourses[index]["rating"]}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFf09ea3)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(popularCourses[index]["name"],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 14,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Vinay Yadav",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFf09ea3).withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                          child: Text(
                            "Best Seller",
                            style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFd88e93)),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              );
            }),
      ),
    ],
  );
}

Widget buildInterviewCourses(course, context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Interview Courses",
                style: GoogleFonts.montserrat(
                    fontSize: 17, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      box10,
      ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: course.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Modular.to.pushNamed('/course', arguments: course[index]);
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
                        course[index]["image"],
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
                          Text(course[index]["name"],
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
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
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double value) {},
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Get trained for comapnies like google , amazon , netflix etc.",
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
  );
}

Widget upcomingLiveSessions(sessions, context) {
  return Column(
    children: [
      box10,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Upcoming Live Sessions",
                style: GoogleFonts.montserrat(
                    fontSize: 17, fontWeight: FontWeight.w600)),
            InkWell(
              onTap: () {
                Modular.to.pushNamed('/search');
              },
              child: Text("See all",
                  style: GoogleFonts.montserrat(
                      decoration: TextDecoration.underline,
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      box10,
      Column(
        children: [
          Container(
            height: 200,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  var session = sessions[index];
                  return InkWell(
                    onTap: () {
                      Modular.to.pushNamed('/liveSession',
                          arguments: sessions[index]);
                      // Navigator.push(
                      //   context,
                      //   FadeRoute(
                      //       page: SeminarInfo(

                      //     seminar: sessions[index],
                      //   )),
                      // );
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    height: 200,
                                    clipBehavior: Clip.hardEdge,
                                    margin: EdgeInsets.only(right: 20),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                          color: primaryColor,
                                        )),
                                    child: Image.network(
                                      session["image"] ?? "",
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 7),
                                    child: Text(
                                      "⭐ ${session["rating"] ?? ""}",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFf09ea3)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(session["name"] + " " + session["type"],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(children: [
                              Text(session["date"] ?? "",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ],
  );
}
