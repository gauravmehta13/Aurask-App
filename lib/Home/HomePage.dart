import 'dart:convert';

import 'package:aurask/Constants.dart';
import 'package:aurask/Home/Components/Stories/Story.dart';
import 'package:aurask/Screens/CoursePage.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List stories = [];
  bool storiesLoaded = false;

  void initState() {
    super.initState();
    getStories();
  }

  getStories() async {
    var dio = Dio();
    try {
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/price-calculator',
          data: {
            "tenantSet_id": "PAM01",
            "tenantUsecase": "pam",
            "useCase": "tip",
            "type": "stories",
          });
      print(response);
      Map<String, dynamic> map = json.decode(response.toString());
      print(map);
      setState(() {
        stories = map["resp"];
        storiesLoaded = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        storiesLoaded = false;
      });
    }
  }

  List courses = [
    {
      "name": "Design Thinking",
      "image": "https://img-c.udemycdn.com/course/480x270/3938952_2445_2.jpg",
      "instructor": "Vinay Yadav",
      "rating": "4.9",
      "description":
          "Come and learn problem solving even if you have no experience in technology. This course will help you build a strong base on the fundamentals of designing an architecture. Be the creator of new technologies with limits as far as your imagination goes! All beginners are welcome here!",
      "overview":
          "At Aurask we help you identify the core problems and build a mindset of ambiguity solving. We have personalized learning for the final year students, freshers and working professionals. You'll learn foundation skills while attaining niche technology learning of solving Business Process Management.",
      "syllabus": [
        {
          "title": "Enterprise Design",
          "session": 1,
          "content": [
            "Availability, Cluster Topologies",
            "Micro problems identification",
            "Lego based bottoms up design pattern"
          ]
        },
        {
          "title": "Designing for Specialization",
          "session": 2,
          "content": [
            "Asset Design and Re-use",
            "Object oriented Pega development",
            "Choosing right Application structure",
            "Specialization Design Considerations"
          ]
        },
        {
          "title": "Process oriented mindset",
          "session": 3,
          "content": [
            "Process design patterns",
            "Involved Parties and work items",
            "Automated routing : Push and Pull Routing",
            "Alternate ways to execute business process"
          ]
        },
        {
          "title": "Release Management",
          "session": 4,
          "content": [
            "Define release management approach",
            "Devops release pipeline : Continuous integration and Delivery",
            "Modular Testing strategy"
          ]
        },
      ]
    },
    {
      "name": "Architecture Mindset",
      "image": "https://img-c.udemycdn.com/course/480x270/1183372_43f5.jpg",
      "instructor": "",
      "rating": "4.8",
      "description":
          "Come and learn problem solving even if you have no experience in technology. This course will help you build a strong base on the fundamentals of designing an architecture. Be the creator of new technologies with limits as far as your imagination goes! All beginners are welcome here!",
      "overview":
          "At Aurask we help you identify the core problems and build a mindset of ambiguity solving. We have personalized learning for the final year students, freshers and working professionals. You'll learn foundation skills while attaining niche technology learning of solving Business Process Management.",
      "syllabus": [
        {
          "title": "Enterprise Design",
          "session": 1,
          "content": [
            "Availability, Cluster Topologies",
            "Micro problems identification",
            "Lego based bottoms up design pattern"
          ]
        },
        {
          "title": "Designing for Specialization",
          "session": 2,
          "content": [
            "Asset Design and Re-use",
            "Object oriented Pega development",
            "Choosing right Application structure",
            "Specialization Design Considerations"
          ]
        },
        {
          "title": "Process oriented mindset",
          "session": 3,
          "content": [
            "Process design patterns",
            "Involved Parties and work items",
            "Automated routing : Push and Pull Routing",
            "Alternate ways to execute business process"
          ]
        },
        {
          "title": "Release Management",
          "session": 4,
          "content": [
            "Define release management approach",
            "Devops release pipeline : Continuous integration and Delivery",
            "Modular Testing strategy"
          ]
        },
      ]
    },
    {
      "name": "Product Evolution",
      "image": "https://img-c.udemycdn.com/course/480x270/1647046_c11d.jpg",
      "instructor": "Vinay Yadav",
      "rating": "4.5",
      "description":
          "Come and learn problem solving even if you have no experience in technology. This course will help you build a strong base on the fundamentals of designing an architecture. Be the creator of new technologies with limits as far as your imagination goes! All beginners are welcome here!",
      "overview":
          "At Aurask we help you identify the core problems and build a mindset of ambiguity solving. We have personalized learning for the final year students, freshers and working professionals. You'll learn foundation skills while attaining niche technology learning of solving Business Process Management.",
      "syllabus": [
        {
          "title": "Enterprise Design",
          "session": 1,
          "content": [
            "Availability, Cluster Topologies",
            "Micro problems identification",
            "Lego based bottoms up design pattern"
          ]
        },
        {
          "title": "Designing for Specialization",
          "session": 2,
          "content": [
            "Asset Design and Re-use",
            "Object oriented Pega development",
            "Choosing right Application structure",
            "Specialization Design Considerations"
          ]
        },
        {
          "title": "Process oriented mindset",
          "session": 3,
          "content": [
            "Process design patterns",
            "Involved Parties and work items",
            "Automated routing : Push and Pull Routing",
            "Alternate ways to execute business process"
          ]
        },
        {
          "title": "Release Management",
          "session": 4,
          "content": [
            "Define release management approach",
            "Devops release pipeline : Continuous integration and Delivery",
            "Modular Testing strategy"
          ]
        },
      ]
    },
    {
      "name": "Leadership Journey",
      "image": "https://img-c.udemycdn.com/course/480x270/80938_4fd4_9.jpg",
      "instructor": "Vinay Yadav",
      "rating": "4.0",
      "description":
          "Come and learn problem solving even if you have no experience in technology. This course will help you build a strong base on the fundamentals of designing an architecture. Be the creator of new technologies with limits as far as your imagination goes! All beginners are welcome here!",
      "overview":
          "At Aurask we help you identify the core problems and build a mindset of ambiguity solving. We have personalized learning for the final year students, freshers and working professionals. You'll learn foundation skills while attaining niche technology learning of solving Business Process Management.",
      "syllabus": [
        {
          "title": "Enterprise Design",
          "session": 1,
          "content": [
            "Availability, Cluster Topologies",
            "Micro problems identification",
            "Lego based bottoms up design pattern"
          ]
        },
        {
          "title": "Designing for Specialization",
          "session": 2,
          "content": [
            "Asset Design and Re-use",
            "Object oriented Pega development",
            "Choosing right Application structure",
            "Specialization Design Considerations"
          ]
        },
        {
          "title": "Process oriented mindset",
          "session": 3,
          "content": [
            "Process design patterns",
            "Involved Parties and work items",
            "Automated routing : Push and Pull Routing",
            "Alternate ways to execute business process"
          ]
        },
        {
          "title": "Release Management",
          "session": 4,
          "content": [
            "Define release management approach",
            "Devops release pipeline : Continuous integration and Delivery",
            "Modular Testing strategy"
          ]
        },
      ]
    },
  ];

  List interviewCourses = [
    {
      "name": "Interview Ready - Engineers",
      "image": "https://img-c.udemycdn.com/course/480x270/3938952_2445_2.jpg",
      "subtitle":
          "Live interview-centric course to prepare engineers for interviews for companies like Google, Amazon, Adobe, Uber, etc",
      "rating": "4.9"
    },
    {
      "name": "Interview Ready - Product Managers",
      "image": "https://img-c.udemycdn.com/course/480x270/1183372_43f5.jpg",
      "subtitle":
          "Live interview-centric course to prepare engineers for interviews for companies like Google, Amazon, Adobe, Uber, etc",
      "rating": "4.9"
    },
  ];

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
                                Text("Hi Gaurav",
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
                  Container(
                    height: 200,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                          clipBehavior: Clip.hardEdge,
                                          margin: EdgeInsets.only(right: 20),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 7),
                                          child: Text(
                                            "⭐ ${courses[index]["rating"]}",
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
                                  child: Text(courses[index]["name"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 7),
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
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: interviewCourses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.only(bottom: 16),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
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
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
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
                                      box10,
                                      Text(
                                          interviewCourses[index]["subtitle"] ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
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
