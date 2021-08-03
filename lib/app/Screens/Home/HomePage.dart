import 'package:flutter/foundation.dart';

import '../../../meta/Utility/responsive.dart';
import '../../../meta/Widgets/Loading.dart';
import '../../../meta/Widgets/WhatsappFab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/redux/actions.dart';
import '../../../core/redux/app_state.dart';
import '../../../core/resources/api_provider.dart';
import '../../../meta/Utility/Constants.dart';
import 'Components/Stories/Story.dart';
import 'Components/banners.dart';
import 'Components/courses.dart';
import 'Components/home init.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List popularCourses = [];
  List stories = [];
  List interviewCourses = [];
  List freeSessions = [];
  List paidSessions = [];
  List allCourses = [];
  bool courseLoaded = false;
  TextEditingController query = TextEditingController();
  var today = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (stories.length == 0) getStories();
    if (!kIsWeb) showDailyAtTime();
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
    for (var i = 0; i < course["courses"].length; i++) {
      if (course["courses"][i]["type"] == "interview") {
        interviewCourses.add(course["courses"][i]);
      } else if (course["courses"][i]["type"] == "popular") {
        popularCourses.add(course["courses"][i]);
      }
    }
    for (var i = 0; i < course["sessions"].length; i++) {
      if (course["sessions"][i]["type"] == "Live Session") {
        paidSessions.add(course["sessions"][i]);
      } else if (course["sessions"][i]["type"] == "Free Seminar") {
        freeSessions.add(course["sessions"][i]);
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
          Map tempCourses = await sharedPrefs.readMap("courses");
          if (tempCourses.length == 0) {
            Map courses = await getCourses();
            divideCourses(courses);
            StoreProvider.of<AppState>(context)
                .dispatch(Courses(courses["courses"]));
            StoreProvider.of<AppState>(context)
                .dispatch(Seminars(courses["sessions"]));
          } else {
            divideCourses(tempCourses);
            Map courses = await getCourses();
            StoreProvider.of<AppState>(context)
                .dispatch(Courses(courses["courses"]));
            StoreProvider.of<AppState>(context)
                .dispatch(Seminars(courses["sessions"]));
          }
          courseLoaded = true;
          allCourses = store.state.courses + store.state.seminars;
        },
        builder: (context, state) {
          return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light
                    .copyWith(statusBarColor: Theme.of(context).primaryColor),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            auth.currentUser == null
                                                ? "Welcome,"
                                                : "Hi ${auth.currentUser?.displayName?.split(" ")[0]}",
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
                                box10,
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
                                            Modular.to.pushNamed(
                                                '/search/${query.text}');
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Modular.to
                                            .pushNamed('/search/${query.text}');
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
                            box10,
                          !courseLoaded
                              ? Container(
                                  height: 400, child: Center(child: Loading()))
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 16 / 9,
                                    viewportFraction:
                                        Responsive.isDesktop(context) ? 0.5 : 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: freeSessions.map((session) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Modular.to.pushNamed('/liveSession',
                                                arguments: session);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Card(
                                              clipBehavior: Clip.hardEdge,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                begin: Alignment
                                                                    .bottomLeft,
                                                                end: Alignment
                                                                    .topRight,
                                                                colors: [
                                                          Colors.red,
                                                          Colors.yellow,
                                                          Colors.blue,
                                                          Colors.purple
                                                        ])),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          session["image"],
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        width: double.maxFinite,
                                                        color: Colors.grey[200],
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                  Banner(
                                                    message: "FREE",
                                                    color: Color(0xFFEB102F),
                                                    location:
                                                        BannerLocation.topEnd,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                            Colors.black
                                                                .withOpacity(0),
                                                            // Colors.black
                                                            //     .withOpacity(0.4),
                                                            // Colors.black
                                                            //     .withOpacity(0.6),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ])),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 10,
                                                    left: 10,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Upcoming Session",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        box5,
                                                        Text(
                                                          session["date"],
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        box10,
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              session["name"],
                                                              style: GoogleFonts.montserrat(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            wbox10,
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                          box10,
                          if (popularCourses.length != 0)
                            buildPopularCourses(popularCourses, context),
                          box20,
                          if (interviewCourses.length != 0)
                            buildInterviewCourses(interviewCourses, context),
                          if (freeSessions.length != 0)
                            upcomingLiveSessions(paidSessions, context),
                          box20,
                          buildQuiz(context, today.hour),
                          buildReferAndEarn(context),
                          buildSpinAndWin(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: WhatsappFAB());
        });
  }
}
