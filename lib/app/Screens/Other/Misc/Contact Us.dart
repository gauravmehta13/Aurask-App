import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        child: Card(
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
                                TextFormField(
                                  decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "Name",
                                      labelStyle:
                                          TextStyle(color: primaryColor)),
                                ),
                                box20,
                                TextFormField(
                                  decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "E-mail",
                                      labelStyle:
                                          TextStyle(color: primaryColor)),
                                ),
                                box20,
                                TextFormField(
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
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              FontAwesomeIcons.telegram,
                              size: 50,
                              color: primaryColor,
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
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Color(0xFF4267B2),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Color(0xFFfb3958),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.linkedin,
                            color: Color(0xFF0077b5),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.youtube,
                            color: Color(0xFFFF0000),
                          ))
                    ],
                  ),
                  box30,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
