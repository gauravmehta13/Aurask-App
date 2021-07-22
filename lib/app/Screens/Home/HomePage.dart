import 'package:aurask/app/Screens/Info%20Screens/SeminarInfo.dart';
import 'package:aurask/meta/Utility/responsive.dart';
import 'package:aurask/meta/Widgets/WhatsappFab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/redux/actions.dart';
import '../../../core/redux/app_state.dart';
import '../../../core/resources/api_provider.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/Loading.dart';
import '../Info%20Screens/CourseInfo.dart';
import '../Other/SearchCourses.dart';
import 'Components/Stories/Story.dart';
import 'Components/banners.dart';
import 'Components/courses.dart';

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
    for (var i = 0; i < course["courses"].length; i++) {
      if (course["courses"][i]["type"] == "interview") {
        interviewCourses.add(course["courses"][i]);
      } else if (course["courses"][i]["type"] == "popular") {
        popularCourses.add(course["courses"][i]);
      }
    }
    for (var i = 0; i < course["sessions"].length; i++) {
      if (course["sessions"][i]["type"] == "Live Session") {
        freeSessions.add(course["sessions"][i]);
      } else if (course["sessions"][i]["type"] == "Free Seminar") {
        paidSessions.add(course["sessions"][i]);
      }
    }
    print(freeSessions.length);
    courseLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) async {
          popularCourses = [];
          interviewCourses = [];
          Map tempCourses = await sharedPrefs.read("courses");
          if (tempCourses.length == 0) {
            Map courses = await getCourses();
            divideCourses(courses);
            StoreProvider.of<AppState>(context)
                .dispatch(Courses(courses["courses"]));
            StoreProvider.of<AppState>(context)
                .dispatch(Seminars(courses["sessions"]));
          } else {
            print(tempCourses);
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
                                            Navigator.push(
                                              context,
                                              FadeRoute(
                                                  page: SearchCourses(
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
                            box10,
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 9,
                              viewportFraction:
                                  Responsive.isDesktop(context) ? 0.5 : 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: paidSessions.map((session) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: SeminarInfo(
                                          id: session["id"],
                                          seminar: session,
                                        )),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Card(
                                        clipBehavior: Clip.hardEdge,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: CachedNetworkImage(
                                                imageUrl: session["image"],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  width: double.maxFinite,
                                                  color: Colors.grey,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                            ),
                                            Positioned(
                                              bottom: 15,
                                              left: 15,
                                              child: Text(
                                                session["name"],
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          upcomingFreeSessions(freeSessions),
                          box20,
                          buildSpinAndWin(context),
                          buildReferAndEarn(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: WhatsappFAB());
        });
  }

  Widget upcomingFreeSessions(sessions) {
    print(sessions.length);
    return Column(
      children: [
        box10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upcoming Free Sessions",
                  style: GoogleFonts.montserrat(
                      fontSize: 17, fontWeight: FontWeight.w600)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRoute(page: SearchCourses()),
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
                        Navigator.push(
                          context,
                          FadeRoute(
                              page: SeminarInfo(
                            id: sessions[index]["id"],
                            seminar: sessions[index],
                          )),
                        );
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
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
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
                              child: Text(
                                  session["name"] + " " + session["type"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
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
}
