import 'package:aurask/app/Screens/Home/BottomNavBar.dart';
import 'package:aurask/app/Screens/Home/HomePage.dart';
import 'package:aurask/app/Screens/Other/CourseInfo.dart';
import 'package:aurask/core/model/supabase%20Manager.dart';
import 'package:aurask/core/redux/app_state.dart';
import 'package:aurask/core/resources/api_provider.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserDetails.dart';

class Onboarding extends StatefulWidget {
  final id;
  const Onboarding({Key? key, this.id}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool loading = false;

  void initState() {
    super.initState();
    setProgress();
    getCourses();
  }

  setProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }

  getCourses() async {
    final response = await client
        .from('courses')
        .select()
        .order('inserted_at', ascending: true)
        .execute();

    var map = response.data;
    print(map);
    setState(() {
      allCourse = map;
    });
  }

  List skillsGrid = [
    {
      "title": "Gain expertise in the latest skills",
      "subtitle":
          "with courses and Specializations in computer science, humanities, and more",
      "icon": "https://image.flaticon.com/icons/png/128/4185/4185510.png"
    },
    {
      "title": "Learn job-ready career skills",
      "subtitle":
          "in artificial intelligence, machine learning, data science, cloud engineering, and more",
      "icon": "https://image.flaticon.com/icons/png/128/3281/3281289.png"
    },
    {
      "title": "Earn a Certificate",
      "subtitle":
          "from the world's leading universities in business, computer science, and more",
      "icon": "https://image.flaticon.com/icons/png/128/2303/2303934.png"
    },
    {
      "title": "Upskill your organization",
      "subtitle": "with on-demand training and development programs",
      "icon": "https://image.flaticon.com/icons/png/128/3214/3214721.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Aurask",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2 - 40,
                        width: double.maxFinite,
                        child: Image.network(
                          "https://images.pexels.com/photos/3483968/pexels-photo-3483968.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2 - 40,
                        padding: EdgeInsets.all(20),
                        color: Colors.white.withOpacity(0.6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            box10,
                            Text("Unleash\nExcellence",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 50, fontWeight: FontWeight.w600)),
                            Text(
                                "Take the next step in your career with a world class learning experience.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 17, fontWeight: FontWeight.w500)),
                            loginButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 50,
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "We collaborate with ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              TextSpan(
                                text: '200+ leading universities and companies',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              "https://www.pngplay.com/wp-content/uploads/3/Bank-Of-America-Logo-Background-PNG-Image.png",
                              height: 60,
                            ),
                            Image.network(
                              "http://assets.stickpng.com/thumbs/58480a96cef1014c0b5e491d.png",
                              height: 60,
                            ),
                            Image.network(
                              "https://www.mulesoft.com/sites/default/files/2018-10/wells_fargo.png",
                              height: 60,
                            ),
                            Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Bank-of-New-York-Mellon-Logo.svg/1200px-Bank-of-New-York-Mellon-Logo.svg.png",
                              height: 60,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              "https://1000logos.net/wp-content/uploads/2020/06/BNP-Paribas-Logo.png",
                              height: 60,
                            ),
                            Image.network(
                              "https://www.wipro.com/content/dam/nexus/en/brand/images/wipro-primary-logo-color-rbg.png",
                              height: 60,
                            ),
                            Image.network(
                              "https://cdn.freebiesupply.com/logos/large/2x/inautix-technologies-logo-png-transparent.png",
                              height: 60,
                              scale: 6,
                            ),
                            Image.network(
                              "https://download.logo.wine/logo/HCL_Technologies/HCL_Technologies-Logo.wine.png",
                              height: 60,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              "https://commercetools.com/wp-content/uploads/2018/06/zensar_technologies_logo.png",
                              height: 60,
                            ),
                            Image.network(
                              "https://png2.cleanpng.com/sh/4106dde0c0fd364b60fbad0626c4b26c/L0KzQYm3VsE6N6J1fZH0aYP2gLBuTf1qdpV5itduLXbyhbBrggRqd58yhNHwbz35db20lPVkcF56httBZYL2ecXCTfJ2e5pzReJ8eXPrf732hCkudJDsh58AYkK7SbbsUMAyaZc4TZCEMkC8SIG8VsE2Omo4UKoCNkizQIeCTwBvbz==/kisspng-mindtree-foundation-logo-vel-tech-university-busin-psychology-logo-5b289ee001af35.9209805615293887680069.png",
                              height: 60,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  box20,
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("Find your path to success",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 25, fontWeight: FontWeight.w600)),
                          box20,
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: skillsGrid.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return new Card(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(
                                        skillsGrid[index]["icon"],
                                        height: 40,
                                      ),
                                      Text(skillsGrid[index]["title"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                      Text(skillsGrid[index]["subtitle"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                  box20,
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/courses.png"),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(20),
                          color: primaryColor.withOpacity(0.15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              box30,
                              Text("World-class\nlearning for you",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600)),
                              box30,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Pursue ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextSpan(
                                      text:
                                          'a promotion, a raise, or switch careers. 89% of learners',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " who have taken a course ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: 'report career benefits.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              box30,
                              box20,
                              loginButton(),
                              box20,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  box20,
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("From the Aurask community",
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                        box10,
                        Text("1000+ people are already learning on Aurask",
                            style: GoogleFonts.montserrat(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: 400,
                            autoPlay: true,
                          ),
                          items: List<Widget>.generate(
                              3, (i) => buildReview("review")),
                        ),
                      ],
                    ),
                  ),
                  box20,
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Get job-ready for an in-demand career",
                              style: GoogleFonts.montserrat(
                                  fontSize: 25, fontWeight: FontWeight.w500)),
                        ),
                        box20,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              "Break into a new field like Design Thinking or Architect Mindset. No prior experience necessary to get started.",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500)),
                        ),
                        box30,
                        Container(
                          height: 200,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 20),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: allCourse.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      FadeRoute(
                                          page: CourseInfo(
                                        course: allCourse[index],
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
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                width: MediaQuery.of(context)
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
                                                  allCourse[index]["image"],
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 7),
                                                child: Text(
                                                  "⭐ ${allCourse[index]["rating"]}",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFFf09ea3)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(allCourse[index]["name"],
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
                        box10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(page: HomePage()),
                                  );
                                },
                                child: Text(
                                  "Explore All Courses",
                                  style: TextStyle(color: primaryColor),
                                )),
                            wbox5,
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: primaryColor,
                            )
                          ],
                        ),
                        box30,
                      ],
                    ),
                  ),
                  box20,
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Image.network(
                                  "https://images.pexels.com/photos/3184405/pexels-photo-3184405.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                            ),
                            box20,
                            Text(
                                "Take the next step toward your personal and professional goals with Aurask.",
                                style: GoogleFonts.montserrat(
                                    fontSize: 25, fontWeight: FontWeight.w600)),
                            box20,
                            Text(
                                "Join now to receive personalized recommendations from the full Aurask catalog.",
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600)),
                            box30,
                            loginButton(),
                            box20,
                          ])),
                ],
              ),
            ),
          );
        });
  }

  Widget buildReview(review) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  "https://lh3.googleusercontent.com/a-/AOh14Ghe4tFlInoDofkTw5ftNmFEyHDFRFiFQYJSoqfHPA=s128-c0x00000000-cc-rp-mo-ba2")),
          box10,
          Text("E Naveen",
              style: GoogleFonts.montserrat(
                  fontSize: 17, fontWeight: FontWeight.w500)),
          box5,
          Text("Design Thinking Student",
              style: GoogleFonts.montserrat(
                  fontSize: 13, fontWeight: FontWeight.w500)),
          box5,
          Text("Telangana",
              style: GoogleFonts.montserrat(
                fontSize: 13,
              )),
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: MediaQuery.of(context).size.width / 3),
              height: 2,
              color: Colors.black),
          Text(
              "' The Knowledge I gained through design thinking course helped me change my mindset and land a job in Netflix. '",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 15, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        googleLogin();
      },
      child: Center(
        child: Container(
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(loading ? 60 : 5))),
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text("Join for Free",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  )),
      ),
    );
  }

  Future googleLogin() async {
    setState(() {
      loading = true;
    });
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential).then((value) async {
          print("User is New = ${value.additionalUserInfo!.isNewUser}");
          if (value.additionalUserInfo!.isNewUser) {
            await login(_auth.currentUser!.uid, _auth.currentUser!.email,
                _auth.currentUser!.displayName, widget.id);
            Navigator.pushReplacement(
              context,
              FadeRoute(page: UserDetails()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              FadeRoute(page: BottomNavBar()),
            );
          }
          setState(() {
            loading = false;
          });
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      displaySnackBar("Error, please try again later..!!", context);
    }
  }
}
