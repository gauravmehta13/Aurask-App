import 'package:aurask/app/Screens/Info%20Screens/CourseInfo.dart';
import 'package:aurask/app/Screens/Other/SearchCourses.dart';
import 'package:aurask/core/redux/actions.dart';
import 'package:aurask/core/redux/app_state.dart';
import 'package:aurask/core/resources/SharedPrefs.dart';
import 'package:aurask/core/resources/api_provider.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:aurask/meta/Widgets/Loading.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Components/Stories/Story.dart';
import 'Components/banners.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

List allCourse = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List popularCourses = [];

  List stories = [];

  List interviewCourses = [];

  List allCourses = [];

  bool courseLoaded = false;
  SharedPref sharedPrefs = SharedPref();
  TextEditingController query = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (stories.length == 0) getStories();
  }

  getStories() async {
    stories = await sharedPrefs.read("stories");
    setState(() {});
    var dio = Dio();
    try {
      final response = await dio.get(
          "https://my-json-server.typicode.com/gauravmehta13/Aurask-App/stories");
      sharedPrefs.save("stories", response.data);
      setState(() {
        stories = response.data;
      });
    } catch (e) {}
  }

  divideCourses(course) {
    for (var i = 0; i < course.length; i++) {
      if (course[i]["type"] == "interview") {
        interviewCourses.add(course[i]);
      } else {
        popularCourses.add(course[i]);
      }
    }
    courseLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) async {
          popularCourses = [];
          interviewCourses = [];
          List tempCourses = await sharedPrefs.read("courses");
          if (tempCourses.length == 0) {
            List courses = await getCourses();
            divideCourses(courses);
            StoreProvider.of<AppState>(context).dispatch(Courses(courses));
          } else {
            divideCourses(tempCourses);
            List courses = await getCourses();
            StoreProvider.of<AppState>(context).dispatch(Courses(courses));
          }
          courseLoaded = true;
          allCourses = store.state.courses;
          allCourse = store.state.courses;
        },
        builder: (context, state) {
          return Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: primaryColor),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Color(0xFF00A9B8),
                                Color(0xFF00A9B8),
                                Color(0xFF00A9B8),
                                Color(0xFF1CB2C3)
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          _auth.currentUser == null
                                              ? "Welcome,"
                                              : "Hi ${_auth.currentUser?.displayName?.split(" ")[0]}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      box5,
                                      Text("Let's start learning !",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.notifications,
                                          color: Colors.white))
                                ],
                              ),
                              box30,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.go,
                                        controller: query,
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 15,
                                                right: 15),
                                            hintText: "Search for a Course"),
                                        onFieldSubmitted: (e) {
                                          Navigator.push(
                                            context,
                                            FadeRoute(
                                                page: SearchCourses(
                                              allCourses: allCourses,
                                              keyword: query.text,
                                            )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: SearchCourses(
                                          allCourses: allCourses,
                                          keyword: query.text,
                                        )),
                                      );
                                    },
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (stories.length != 0)
                          GoFlexeStories(
                            stories: stories,
                          )
                        else
                          box20,
                        box10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Popular Courses 🔥",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                        page: SearchCourses(
                                      allCourses: allCourses,
                                    )),
                                  );
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
                        box20,
                        !courseLoaded
                            ? Loading()
                            : Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: popularCourses.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                FadeRoute(
                                                    page: CourseInfo(
                                                  course: popularCourses[index],
                                                )),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  primaryColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15))),
                                                          child: Image.network(
                                                            popularCourses[
                                                                index]["image"],
                                                            fit: BoxFit.fill,
                                                          )),
                                                      Positioned(
                                                        top: 10,
                                                        left: 10,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          7))),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      7),
                                                          child: Text(
                                                            "⭐ ${popularCourses[index]["rating"]}",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xFFf09ea3)),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      popularCourses[index]
                                                          ["name"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
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
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 14,
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                                  0xFFf09ea3)
                                                              .withOpacity(0.3),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3,
                                                              horizontal: 7),
                                                      child: Text(
                                                        "Best Seller",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFFd88e93)),
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
                              ),
                        box30,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Interview Courses",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        box20,
                        !courseLoaded
                            ? Loading()
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: interviewCourses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: CourseInfo(
                                                  course: interviewCourses[
                                                      index])));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: EdgeInsets.only(bottom: 16),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 100,
                                            child: Image.network(
                                              interviewCourses[index]["image"],
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    interviewCourses[index]
                                                        ["name"],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
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
                                                      EdgeInsets.symmetric(
                                                          horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate:
                                                      (double value) {},
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
                        buildSpinAndWin(context),
                        buildReferAndEarn(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
