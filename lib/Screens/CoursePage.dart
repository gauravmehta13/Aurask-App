import 'package:aurask/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursePage extends StatefulWidget {
  final Map course;
  const CoursePage({Key? key, required this.course}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4,
          child: Container(
              width: double.maxFinite,
              height: 60,
              color: primaryColor,
              child: Center(
                child: Text("Join Course",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              )),
        ),
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Design Thinking",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                        box10,
                        Text(widget.course["overview"]),
                        box20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "4.7",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
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
                              ],
                            ),
                            box5,
                            Text(
                              "( 78 Ratings) 120 students",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        box20,
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.update,
                                      size: 15, color: Colors.grey[800]!),
                                  wbox5,
                                  Text(
                                    "Last Updated Mar 2021",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800]),
                                  )
                                ],
                              ),
                              box10,
                              Row(
                                children: [
                                  Icon(Icons.language,
                                      size: 15, color: Colors.grey[800]!),
                                  wbox5,
                                  Text(
                                    "English",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800]),
                                  )
                                ],
                              ),
                              box10,
                              Row(
                                children: [
                                  Icon(Icons.closed_caption,
                                      size: 15, color: Colors.grey[800]!),
                                  wbox5,
                                  Text(
                                    "English , Hindi",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[800]),
                                  )
                                ],
                              ),
                              box10,
                            ],
                          ),
                        ),
                        box20,
                        Container(
                          height: 250,
                          width: double.maxFinite,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Stack(
                            children: [
                              Container(
                                height: 250,
                                child: Image.network(
                                  widget.course["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.black.withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(""),
                                    Icon(
                                      Icons.play_arrow,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Preview this Course",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    Text("")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        box20,
                        Text(
                          "This Course Includes",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.videocam,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "40 hours of ondemand video",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.light,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "Support Files",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.assignment,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "20 Assignments",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "Full time Access",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.phone_outlined,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "Access on Mobile and Web",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Row(
                          children: [
                            Icon(Icons.pause_presentation,
                                size: 20, color: Colors.grey[800]!),
                            wbox10,
                            Text(
                              "Certificate of Completion",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[800]),
                            )
                          ],
                        ),
                        box10,
                        Divider(),
                        box10,
                        Text(
                          "What you'll Learn",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        box10,
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      size: 15,
                                    ),
                                    wbox10,
                                    Expanded(
                                      child: Text(
                                        "Change your mindset and master the basi  djfwiebfhinking erdfugi.",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "SHOW MORE",
                              style: TextStyle(fontSize: 12),
                            )),
                        box20,
                        Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        box10,
                        Text(widget.course["description"]),
                        box30,
                        Text(
                          "Course Content",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        box20,
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.course["syllabus"].length,
                            itemBuilder: (BuildContext context, int index) {
                              var x = widget.course["syllabus"][index];
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
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.all(0),
                                  childrenPadding:
                                      EdgeInsets.only(left: 70, bottom: 20),
                                  title: Row(
                                    children: [
                                      Text(
                                        "Session ${x["session"]}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800]),
                                      ),
                                      wbox20,
                                      Text(
                                        x["title"],
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: x["content"].length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 2,
                                              ),
                                              wbox10,
                                              Expanded(
                                                child: Text(
                                                  x["content"][i],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              );
                            }),
                        box30,
                        InkWell(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Instructors",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                ),
                                box20,
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: NetworkImage(
                                          "https://media-exp3.licdn.com/dms/image/C5603AQGacJ-P9gTj7w/profile-displayphoto-shrink_400_400/0/1517799815988?e=1630540800&v=beta&t=8G_NtmxHv0FI0hIcXO5W4XJcVnVFJ8QG1rBXPLV2f8E"),
                                    ),
                                    wbox20,
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vinay Yadav",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          box5,
                                          Text(
                                            "Software Development Manager at Amazon",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        box10,
                        Divider(),
                      ])),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    box10,
                    Text(
                      "Frequently Asked Questions",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    box20,
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.course["syllabus"].length,
                        itemBuilder: (BuildContext context, int index) {
                          var x = widget.course["syllabus"][index];
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
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(horizontal: 10),
                              childrenPadding:
                                  EdgeInsets.only(bottom: 20, left: 10),
                              title: Text(
                                "Is Financial Aid Available",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                        "We provide free seminars every friday"),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                    box30,
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
