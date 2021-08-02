import '../../../../meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  String? email = auth.currentUser!.email;
  var subject = TextEditingController();
  var body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [Image.asset("assets/contactUs.jpg")],
                ),
                Column(
                  children: [
                    Spacer(),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Card(
                            elevation: 9,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.maxFinite,
                              child: Column(
                                children: [
                                  Text(
                                    "GET IN TOUCH!",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  box20,
                                  TextFormField(
                                    initialValue: auth.currentUser!.email,
                                    onChanged: (e) {
                                      email = e;
                                    },
                                    decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "E-mail",
                                        labelStyle:
                                            TextStyle(color: primaryColor)),
                                  ),
                                  box20,
                                  TextFormField(
                                    controller: subject,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Subject",
                                        labelStyle:
                                            TextStyle(color: primaryColor)),
                                  ),
                                  box20,
                                  TextFormField(
                                    controller: body,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Message",
                                        labelStyle:
                                            TextStyle(color: primaryColor)),
                                  ),
                                  box20,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await launch(
                                    "mailto:$email?subject=${subject.text}&body=${body.text}");
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  FontAwesomeIcons.telegram,
                                  size: 50,
                                  color: primaryColor,
                                ),
                              ),
                            ))
                      ],
                    ),
                    Spacer(),
                    Text("Follow Us on"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await launch(
                                  "https://www.facebook.com/auraskacademy/");
                            },
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Color(0xFF4267B2),
                            )),
                        IconButton(
                            onPressed: () async {
                              await launch(
                                  "https://www.instagram.com/aurask.academy/");
                            },
                            icon: Icon(
                              FontAwesomeIcons.instagram,
                              color: Color(0xFFfb3958),
                            )),
                        IconButton(
                            onPressed: () async {
                              await launch(
                                  "https://www.linkedin.com/company/aurask-academy/");
                            },
                            icon: Icon(
                              FontAwesomeIcons.linkedin,
                              color: Color(0xFF0077b5),
                            )),
                        IconButton(
                            onPressed: () async {
                              await launch(
                                  "https://www.youtube.com/channel/UCoCLrgqPW4hUkoiflYbt8cw");
                            },
                            icon: Icon(
                              FontAwesomeIcons.youtube,
                              color: Color(0xFFFF0000),
                            ))
                      ],
                    ),
                    box30,
                    box30,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
