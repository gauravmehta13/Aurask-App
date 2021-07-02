import 'package:aurask/Constants.dart';
import 'package:aurask/Screens/Date%20Card.dart';
import 'package:aurask/Screens/InstructorPage.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class CoursePage extends StatefulWidget {
  final Map course;
  const CoursePage({Key? key, required this.course}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  List pricing = [
    {
      "title": "Free Seminar",
      "price": 0,
      "description": "Free Seminars every month",
      "selected": false
    },
    {
      "title": "Self Tutorial",
      "price": 3999,
      "description":
          "Includes pre-recorded videos, live QnA doubt session, Lifetime access to the course.",
      "selected": true
    },
    {
      "title": "Live Session",
      "price": 4999,
      "description":
          "2 Day workshop from industry experts. Also includes pre-recorded videos, live QnA doubt session, Life time validity of the course.",
      "selected": false
    },
  ];

  bool free = false;
  bool live = false;
  bool self = true;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void displayCourseChoices(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (ctx) {
          return Container(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  child: Row(children: [
                    Expanded(
                        child: Card(
                      child: Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  maxRadius: 100,
                                  child: Text(
                                    "₹ 0",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Free Seminar",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: Card(
                      child: Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  maxRadius: 100,
                                  child: Text(
                                    "₹ 3999",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Self Tutorial",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: Card(
                      child: Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  maxRadius: 100,
                                  child: Text(
                                    "₹ 5999",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Live Session",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    displayCourseChoices(context);
                  },
                  child: Card(
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
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () {
            displayCourseChoices(context);
          },
          child: Card(
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
                                height: 250,
                                child: VideoPlayer(_controller),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: _controller.value.isPlaying
                                      ? Colors.transparent
                                      : Colors.black.withOpacity(0.5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(""),
                                      if (!_controller.value.isPlaying)
                                        Icon(
                                          Icons.play_arrow,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                      if (!_controller.value.isPlaying)
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        FadeRoute(page: InstructorProfile()));
                                  },
                                  child: Row(
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        box10,
                        Divider(),
                      ])),
              GridView.builder(
                shrinkWrap: true,
                itemCount: pricing.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6, crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        for (var i = 0; i < pricing.length; i++) {
                          pricing[i]["selected"] = false;
                        }
                        pricing[index]["selected"] = true;
                      });
                    },
                    child: Card(
                      child: Container(
                        color: pricing[index]["selected"] == true
                            ? primaryColor
                            : Colors.grey[300],
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor:
                                      pricing[index]["selected"] == true
                                          ? primaryColor.withOpacity(0.1)
                                          : Colors.grey[300],
                                  maxRadius: 100,
                                  child: Text(
                                    "₹ ${pricing[index]["price"].toString()}",
                                    style: GoogleFonts.montserrat(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              pricing[index]["title"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: pricing[index]["selected"] == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            if (pricing[index]["selected"] == true)
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
