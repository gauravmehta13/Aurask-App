import 'package:aurask/Constants.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
            Container(
              height: MediaQuery.of(context).size.height / 2 - 50,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  box10,
                  Text("Learn Without\nLimits",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 40, fontWeight: FontWeight.w600)),
                  Text(
                      "Take the next step in your career with a world class learning experience.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  loginButton()
                ],
              ),
            ),
            box20,
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                fontSize: 30, fontWeight: FontWeight.w600)),
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
            // SizedBox(
            //   height: 2000,
            // )
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          FadeRoute(page: LoginScreen()),
        );
      },
      child: Container(
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          width: double.maxFinite,
          height: 55,
          child: Center(
            child: Text("Join for Free",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          )),
    );
  }
}
