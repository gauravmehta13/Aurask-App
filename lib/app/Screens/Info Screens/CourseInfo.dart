import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../../../core/model/reviews%20Model.dart';
import '../../../core/model/supabase%20Manager.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/Loading.dart';
import '../Info%20Screens/SeminarInfo.dart';
import '../Other/CustomerReviews.dart';
import '../Other/InstructorPage.dart';

class CourseInfo extends StatefulWidget {
  final Map course;
  const CourseInfo({Key? key, required this.course}) : super(key: key);

  @override
  _CourseInfoState createState() => _CourseInfoState();
}

Map selectedPrice = {};
bool buyingCourse = false;

class _CourseInfoState extends State<CourseInfo> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    print(widget.course);
    setInitialPrice();
    loadJson();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.course["videoUrl"]);
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: () => debugPrint('My option works!'),
      //       iconData: Icons.chat,
      //       title: 'My localized title',
      //     ),
      //     OptionItem(
      //       onTap: () => debugPrint('Another option working!'),
      //       iconData: Icons.chat,
      //       title: 'Another localized title',
      //     ),
      //   ];
      // },
      // fullScreenByDefault: true,
      // placeholder: Image(
      //   image: NetworkImage(widget.course["image"]),
      // ),
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 10,
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  bool loading = false;

  Future buyCourse() async {
    setState(() {
      buyingCourse = true;
    });
    try {
      var dio = Dio();
      print(auth.currentUser?.uid);
      print(widget.course["id"]);
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=ORDER01&usecase=aurask&tenantUsecase=post",
          data: {
            "id": auth.currentUser?.uid,
            "courseId": widget.course["id"],
          });
      print(response.data);
      displaySnackBar(response.data["resp"], context);
      setState(() {
        buyingCourse = false;
      });
    } catch (e) {
      setState(() {
        buyingCourse = false;
      });
      print(e);
      if (e.toString().contains("Already Purchased"))
        displaySnackBar("Course Already Purchased", context);
    }
  }

  sendData() async {
    setState(() {
      loading = true;
    });
    var pricingType = {};
    for (var i = 0; i < widget.course["pricing"].length; i++) {
      if (widget.course["pricing"][i]["selected"] == true) {
        setState(() {
          pricingType = widget.course["pricing"][i];
        });
      }
    }

    var resp = await client.from('purchasedCourses').insert([
      {
        'userId': auth.currentUser?.uid,
        "courseId": widget.course["id"],
        "courseType": pricingType,
      }
    ]).execute();
    print(resp.status);
    if (resp.status == 201) {
      setState(() {
        loading = false;
      });
      displaySnackBar("Course Purchased Successfully", context);
      Navigator.pop(context);
    } else {
      displaySnackBar(resp.error!.message, context);
    }
  }

  setInitialPrice() {
    for (var i = 0; i < widget.course["pricing"].length; i++) {
      if (widget.course["pricing"][i]["selected"] == true) {
        selectedPrice = widget.course["pricing"][i];
      }
    }
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
                  loading
                      ? Loading()
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.course["pricing"].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.6, crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  for (var i = 0;
                                      i < widget.course["pricing"].length;
                                      i++) {
                                    widget.course["pricing"][i]["selected"] =
                                        false;
                                  }
                                  widget.course["pricing"][index]["selected"] =
                                      true;
                                  selectedPrice =
                                      widget.course["pricing"][index];
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  color: widget.course["pricing"][index]
                                              ["selected"] ==
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
                                                  "₹ ${widget.course["pricing"][index]["price"] + 2000}",
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black54,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "₹ ${widget.course["pricing"][index]["price"].toString()}",
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
                                        widget.course["pricing"][index]
                                            ["title"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            color: widget.course["pricing"]
                                                        [index]["selected"] ==
                                                    true
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if (widget.course["pricing"][index]
                                              ["selected"] ==
                                          true)
                                        Icon(Icons.keyboard_arrow_down,
                                            color: Colors.white)
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
                    onTap: selectedPrice["id"] != 1
                        ? () async {
                            //await sendData();
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: SeminarInfo(
                                  id: "",
                                )));
                          }
                        : () {
                            buyCourse();
                            Navigator.pop(context);
                            // displaySnackBar("Coming Soon", context);
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
    return Theme(
      data: ThemeData(platform: TargetPlatform.android),
      child: Scaffold(
          bottomNavigationBar: InkWell(
            onTap: () {
              auth.currentUser == null
                  ? authNavigate(CourseInfo(course: widget.course), context)
                  : displayCourseChoices(context);
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
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
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
                          Text(widget.course["name"],
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
                          box20,
                          Container(
                            height: 250,
                            width: double.maxFinite,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: videoPlayerController.value.isInitialized &&
                                    chewieController.videoPlayerController.value
                                        .isInitialized
                                ? Chewie(
                                    controller: chewieController,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                            widget.course["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor.withOpacity(0.5),
                                      ),
                                    )),
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
                                "16 hours of ondemand video",
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
                                          backgroundImage: NetworkImage(widget
                                              .course["instructor"]["imgUrl"]),
                                        ),
                                        wbox20,
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.course["instructor"]
                                                    ["title"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              box5,
                                              Text(
                                                widget.course["instructor"]
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
                          CustomerReviews(
                            reviews: reviews,
                          ),
                        ])),
                // Container(
                //   color: Colors.grey[200],
                //   padding: EdgeInsets.all(10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       box10,
                //       Text(
                //         "Frequently Asked Questions",
                //         style: TextStyle(
                //             fontWeight: FontWeight.w800, fontSize: 20),
                //       ),
                //       box20,
                // ListView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: widget.course["syllabus"].length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container(
                //         decoration: BoxDecoration(
                //           border: Border(
                //             bottom: BorderSide(
                //               color: Colors.grey[300]!,
                //             ),
                //             top: BorderSide(
                //               color: Colors.grey[300]!,
                //             ),
                //           ),
                //         ),
                //         child: ExpansionTile(
                //           tilePadding:
                //               EdgeInsets.symmetric(horizontal: 10),
                //           childrenPadding:
                //               EdgeInsets.only(bottom: 20, left: 10),
                //           title: Text(
                //             "Is Financial Aid Available",
                //             style: TextStyle(
                //                 fontSize: 14.0,
                //                 fontWeight: FontWeight.w500),
                //           ),
                //           children: <Widget>[
                //             Row(
                //               children: [
                //                 Text(
                //                     "We provide free seminars every friday"),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     }),
                // box30,
                //    ],
                //  ),
                //    )
              ],
            ),
          )),
    );
  }
}
