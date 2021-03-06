import 'dart:convert';

import 'package:aurask/app/Screens/Info%20Screens/SeminarInfo.dart';
import 'package:aurask/core/resources/api_provider.dart';
import 'package:aurask/core/resources/login_Provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart' as web;
import '../../../core/model/reviews%20Model.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/Loading.dart';
import '../../../meta/Widgets/WhatsappFab.dart';
import '../Other/CustomerReviews.dart';
import '../Other/InstructorPage.dart';

class CourseInfo extends StatefulWidget {
  final id;
  final course;
  const CourseInfo({Key? key, this.course, this.id}) : super(key: key);

  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  bool buyingCourse = false;
  Map selectedPrice = {};
  List<web.YoutubePlayerController> webcontroller = [];
  int _current = 0;
  final CarouselController carouselController = CarouselController();
  final visibleKey = new GlobalKey();
  Map course = {};

  @override
  void initState() {
    super.initState();
    print(widget.id);
    if (widget.id != null) {
      getCourse();
    } else {
      course = widget.course;
      setInitialPrice(widget.course);
    }

    loadJson();

    initialiseVideos(
        ["jCqeDolIsiY", "_REF8QRoAbE", "t3B7HHivDnY", "x45qNF6S_wk"]);
    //?Using YT player instead of chewie
    //initializeVideoPlayer();
  }

  getCourse() async {
    print(widget.id);
    setState(() {
      loading = true;
    });
    var map = await getCourseDetails(widget.id);
    print(map);
    setState(() {
      course = map;
      loading = false;
    });
    setInitialPrice(map);
  }

  initialiseVideos(List videos) {
    for (var i = 0; i < videos.length; i++) {
      webcontroller.add(web.YoutubePlayerController(
        initialVideoId: videos[i],
        params: web.YoutubePlayerParams(
          showVideoAnnotations: false,
          desktopMode: kIsWeb,
          autoPlay: false,
          strictRelatedVideos: true,
          showControls: true,
          showFullscreenButton: false,
        ),
      ));
    }

    setState(() {});
  }

  bool loading = false;

  setInitialPrice(map) {
    for (var i = 0; i < map["pricing"].length; i++) {
      if (map["pricing"][i]["selected"] == true) {
        selectedPrice = map["pricing"][i];
      }
    }
    setState(() {
      selectedPrice = selectedPrice;
    });
  }

  List<Reviews> reviews = [];

  loadJson() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/reviews.json");
    setState(() {
      reviews =
          (json.decode(data) as List).map((d) => Reviews.fromJson(d)).toList();
      reviews.shuffle();
    });
  }

  void displayCourseChoices(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (course["type"] == "Pega BPM")
                    Container(
                      width: double.maxFinite,
                      color: primaryColor.withOpacity(0.3),
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Pay only ??? 10000 to Register",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  box5,
                  loading
                      ? Loading()
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: course["pricing"].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.6, crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  for (var i = 0;
                                      i < course["pricing"].length;
                                      i++) {
                                    course["pricing"][i]["selected"] = false;
                                  }
                                  course["pricing"][index]["selected"] = true;
                                  selectedPrice = course["pricing"][index];
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  color: course["pricing"][index]["selected"] ==
                                          true
                                      ? primaryColor
                                      : Colors.grey[300],
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: CircleAvatar(
                                            backgroundColor: widget
                                                            .course["pricing"]
                                                        [index]["selected"] ==
                                                    true
                                                ? primaryColor.withOpacity(0.1)
                                                : Colors.grey[300],
                                            maxRadius: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "??? ${course["pricing"][index]["price"] + 2000}",
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black54,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "??? ${course["pricing"][index]["price"].toString()}",
                                                  style: GoogleFonts.montserrat(
                                                      color: primaryColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        course["pricing"][index]["name"] ??
                                            course["pricing"][index]["title"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            color: course["pricing"][index]
                                                        ["selected"] ==
                                                    true
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: course["pricing"][index]
                                                        ["name"] !=
                                                    null
                                                ? 15
                                                : 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // if (course["pricing"][index]
                                      //         ["selected"] ==
                                      //     true)
                                      //   Icon(Icons.keyboard_arrow_down,
                                      //       color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  box10,
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    color: primaryColor.withOpacity(0.3),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        selectedPrice["description"] ?? "",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ["Free Seminar", "Live Session"]
                            .contains(selectedPrice["title"])
                        ? () async {
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: SeminarInfo(
                                  id: selectedPrice["id"],
                                )));
                            // Modular.to.pushReplacementNamed(
                            //     '/liveSession/${selectedPrice["id"]}');
                          }
                        : () {
                            comingSoon(context);
                            // Navigator.pop(context);
                            // kIsWeb
                            //     ? installAppDialog(context)
                            //     : Navigator.push(
                            //         context,
                            //         FadeRoute(
                            //             page: PaymentPage(
                            //                 type: selectedPrice["title"],
                            //                 course: course,
                            //                 price: int.parse(
                            //                     selectedPrice["price"]
                            //                         .toString()))));
                          },
                    child: Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      elevation: 4,
                      child: Container(
                          width: double.maxFinite,
                          height: 60,
                          color: primaryColor,
                          child: Center(
                            child: Text("Join",
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
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider user = Provider.of<AuthenticationProvider>(context);
    return Theme(
      data: ThemeData(platform: TargetPlatform.android),
      child: loading
          ? Scaffold(body: Loading())
          : Scaffold(
              bottomNavigationBar: InkWell(
                onTap: () {
                  if (user.firebaseAuth.currentUser == null)
                    authNavigate(CourseInfo(course: course), context);
                  else {
                    Scrollable.ensureVisible(visibleKey.currentContext!,
                        duration: Duration(seconds: 1));
                    displayCourseChoices(context);
                  }
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (buyingCourse)
                        LinearProgressIndicator(
                            color: primaryColor, backgroundColor: Colors.black),
                      Container(
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
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                backgroundColor: primaryColor,
                actions: [
                  // IconButton(
                  //     onPressed: () async {
                  //       String text =
                  //           "Join this course at https://aurask.net/#/course/${course["id"]}";
                  //       !kIsWeb
                  //           ? await shareCourse(course["image"], text)
                  //           : await share(text);
                  //     },
                  //     icon: Icon(Icons.share)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(course["name"],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600)),
                                wbox5,
                                if (course["type"] == "Pega BPM")
                                  Text("MoneyBack\nGuarantee",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 8,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600)),
                              ],
                            ),
                            box10,
                            Text(course["overview"]),
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
                                            fontSize: 13,
                                            color: Colors.grey[800]),
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
                                            fontSize: 13,
                                            color: Colors.grey[800]),
                                      )
                                    ],
                                  ),
                                  box10,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (course["type"] != "Pega BPM")
                        Column(
                          children: [
                            CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.95,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: webcontroller.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return web.YoutubePlayerIFrame(
                                        gestureRecognizers: {},
                                        controller: i,
                                      );
                                    },
                                  );
                                }).toList()),
                            box10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  webcontroller.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor.withOpacity(
                                            _current == entry.key ? 0.9 : 0.1)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                      // Container(
                      //   height: 250,
                      //   width: double.maxFinite,
                      //   clipBehavior: Clip.hardEdge,
                      //   decoration: BoxDecoration(
                      //       color: Colors.transparent,
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(5))),
                      //   child: videoPlayerController.value.isInitialized &&
                      //           chewieController.videoPlayerController.value
                      //               .isInitialized
                      //       ? Chewie(
                      //           controller: chewieController,
                      //         )
                      //       : Container(
                      //           decoration: BoxDecoration(
                      //             image: new DecorationImage(
                      //               image: new NetworkImage(
                      //                   course["image"]),
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           child: Center(
                      //             child: CircularProgressIndicator(
                      //               color: primaryColor.withOpacity(0.5),
                      //             ),
                      //           )),
                      // ),

                      box10,
                      Padding(
                        key: visibleKey,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  course["type"] == "Pega BPM"
                                      ? "${20 * 4} hours of ondemand video"
                                      : "16 hours of ondemand video",
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
                                  "8 Assignments",
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
                                  "Life time Access",
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
                                Icon(Icons.question_answer,
                                    size: 20, color: Colors.grey[800]!),
                                wbox10,
                                Text(
                                  "QnA Session",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[800]),
                                )
                              ],
                            ),
                            box10,
                            Divider(),
                            box20,
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                            box10,
                            Text(course["description"]),
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
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.all(0),
                                      childrenPadding:
                                          EdgeInsets.only(left: 70, bottom: 20),
                                      title: Row(
                                        children: [
                                          Text(
                                            course["type"] == "Pega BPM"
                                                ? "4 hrs/day"
                                                : "Session ${x["session"]}",
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
                                            physics:
                                                NeverScrollableScrollPhysics(),
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
                                                      style: TextStyle(
                                                          fontSize: 13),
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
                                        Navigator.push(
                                            context,
                                            FadeRoute(
                                                page: InstructorProfile()));
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.grey[300],
                                            backgroundImage: NetworkImage(
                                                course["instructor"]["imgUrl"]),
                                          ),
                                          wbox20,
                                          Expanded(
                                            flex: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  course["instructor"]["title"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                box5,
                                                Text(
                                                  course["instructor"]
                                                      ["subtitle"],
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
                            box10,
                          ],
                        ),
                      ),
                      CustomerReviews(
                        reviews: reviews,
                      ),
                    ]),
              ),
              floatingActionButton: WhatsappFAB()),
    );
  }
}
