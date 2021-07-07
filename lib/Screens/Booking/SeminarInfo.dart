import 'package:aurask/Constants.dart';
import 'package:aurask/Home/HomePage.dart';
import 'package:aurask/Screens/Booking/Booking%20Complete.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CourseInfo.dart';

class SeminarInfo extends StatefulWidget {
  final id;
  const SeminarInfo({Key? key, this.id}) : super(key: key);

  @override
  _SeminarInfoState createState() => _SeminarInfoState();
}

class _SeminarInfoState extends State<SeminarInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor.withOpacity(0.2),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context, FadeRoute(page: BookingComplete()));
        },
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4,
          child: Container(
              width: double.maxFinite,
              height: 60,
              color: primaryColor,
              child: Center(
                child: Text("Book Tickets",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.network(
                "https://miro.medium.com/max/1954/1*kb1bu3bHdyKPskfGz-efgg.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Design Thinking Live Seminar",
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontWeight: FontWeight.w600)),
                  box20,
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    dense: true,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                        ),
                      ],
                    ),
                    title: Text("Saturday, July 10"),
                    subtitle: Text("10.30 AM - 1.30 PM IST"),
                  ),
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    dense: true,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          size: 20,
                        ),
                      ],
                    ),
                    title: Text("Online - Anywhere"),
                    subtitle: Text("Google Meet"),
                  ),
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    dense: true,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.ticketAlt,
                          size: 20,
                        ),
                      ],
                    ),
                    title: Text("Free"),
                    subtitle: Text("On Aurask"),
                  ),
                  Divider(color: Colors.grey),
                  box20,
                  Text("About",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800])),
                  box10,
                  Text(
                      "Some of the world’s leading brands such as Google and Samsung have incorporated the design thinking approach and design thinking is being taught at some of the top universities in the world. It has found a place in most of the economic sectors and many firms have found new revenue streams through this very concept. But, at its core, what is Design Thinking? And why is it so popular? Join us as we demystify Design Thinking with Vinay Yadav",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800])),
                  box20,
                  Divider(color: Colors.grey),
                  box10,
                  Text("More like this",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800])),
                ],
              ),
            ),
            box10,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    clipBehavior: Clip.hardEdge,
                                    margin: EdgeInsets.only(right: 20),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 7),
                                    child: Text(
                                      "⭐ ${allCourse[index]["rating"]}",
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
                            child: Text(allCourse[index]["name"],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
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
                                    color: Color(0xFFf09ea3).withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
            box30,
            box30,
          ],
        ),
      ),
    );
  }
}
