import 'package:aurask/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumMembership extends StatefulWidget {
  const PremiumMembership({Key? key}) : super(key: key);

  @override
  _PremiumMembershipState createState() => _PremiumMembershipState();
}

class _PremiumMembershipState extends State<PremiumMembership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white])),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 15,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              box10,
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // radius of 10
                    color: primaryColor
                        .withOpacity(0.3) // green as background color
                    ),
                child: Icon(
                  Icons.celebration,
                  color: primaryColor,
                ),
              ),
              box20,
              Text("Unlock Aurask Pro",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 25)),
              box10,
              Text(
                  "Includes all self tutorial and interview sessions for all courses of Aurask for life. Also can join virtual QnA sessions and career guidance from industry experts once every month.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.grey[800], fontSize: 13)),
              box20,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor),
                child: Text("ONE TIME OFFER",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              box20,
              Text(
                  "If you choose Aurask Pro now, You'll get 50% discount on our most popular subscriptions.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.grey[800], fontSize: 13)),
              box20,
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor),
                    color: primaryColor.withOpacity(0.2)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: primaryColor,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 17,
                          ),
                          wbox10,
                          Text("MOST POPULAR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Text("LifeTime :  ₹ 14999",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                    fontSize: 15)),
                            box10,
                            Text("Instead of  ₹ 29999",
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey[700], fontSize: 12))
                          ],
                        ))
                  ],
                ),
              ),
              box20,
              Container(
                width: double.maxFinite,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor),
                    color: primaryColor.withOpacity(0.2)),
                child: Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Text("1 Year :  ₹ 3999",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                    fontSize: 15)),
                            box10,
                            Text("Instead of  ₹ 7999",
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey[700], fontSize: 12))
                          ],
                        ))
                  ],
                ),
              ),
              Spacer(),
              Text("Automatic Payment can be cancelled at anytime",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.grey[800], fontSize: 13)),
              box10,
              Text("Subscription starts immidiately",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.grey[800], fontSize: 13)),
              Spacer(),
              Card(
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
                      child: Text("Subscribe Now",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    )),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
