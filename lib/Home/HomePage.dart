import 'dart:convert';
import 'package:aurask/model/supabase%20Manager.dart';
import 'package:supabase/supabase.dart' as sb;
import 'package:aurask/Constants.dart';
import 'package:aurask/Home/Components/Stories/Story.dart';
import 'package:aurask/Screens/CoursePage.dart';
import 'package:aurask/Screens/Premium%20Membership.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List stories = [];
  List courses = [];
  List interviewCourses = [];
  bool storiesLoaded = false;
  bool courseLoaded = false;

  void initState() {
    super.initState();
    getStories();
    getCourses();
  }

  getCourses() async {
    // String data =
    //     await DefaultAssetBundle.of(context).loadString("assets/courses.json");

    // Select from table `countries` ordering by `name`
    final response = await client
        .from('courses')
        .select()
        .order('id', ascending: true)
        .execute();
    //print(response.data);

    //var map = json.decode(response.data);
    // print(map);
    // for (var i = 0; i < map["courses"].length; i++) {
    //   if (map["courses"][i]["type"] == "popular") {
    //     courses.add(map["courses"][i]);
    //   } else {
    //     interviewCourses.add(map["courses"][i]);
    //   }
    // }
    setState(() {
      courses = response.data;
      courseLoaded = true;
    });
  }

  getStories() async {
    var dio = Dio();
    try {
      final response = await dio.get(
          "https://my-json-server.typicode.com/gauravmehta13/Aurask-App/stories");
      print(response);
      setState(() {
        stories = response.data;
        storiesLoaded = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        storiesLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: primaryColor),
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
                          // topRight: Radius.circular(20),
                          bottomRight: Radius.circular(25),
                          // topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(25)),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                icon: Icon(
                                  FontAwesomeIcons.cartPlus,
                                  color: Colors.white,
                                  size: 20,
                                )),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextFormField(
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
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(
                                Icons.sort,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (storiesLoaded)
                    GoFlexeStories(
                      stories: stories,
                    )
                  else
                    box20,
                  box10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Popular Courses 🔥",
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        Text("See all",
                            style: GoogleFonts.montserrat(
                                decoration: TextDecoration.underline,
                                color: primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: courses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                              page: CoursePage(
                                            course: courses[index],
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
                                                    clipBehavior: Clip.hardEdge,
                                                    margin: EdgeInsets.only(
                                                        right: 20),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                    child: Image.network(
                                                      courses[index]["image"],
                                                      fit: BoxFit.fill,
                                                    )),
                                                Positioned(
                                                  top: 10,
                                                  left: 10,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7))),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 7),
                                                    child: Text(
                                                      "⭐ ${courses[index]["rating"]}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(courses[index]["name"],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
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
                                                    color: Color(0xFFf09ea3)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 7),
                                                child: Text(
                                                  "Best Seller",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                        ),
                  box30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Interview Courses",
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  box20,
                  !courseLoaded
                      ? Loading()
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: interviewCourses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    FadeRoute(page: PremiumMembership()));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.only(bottom: 16),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
                                          Text(interviewCourses[index]["name"],
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700)),
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
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
