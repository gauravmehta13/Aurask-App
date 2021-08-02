import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../meta/Utility/Constants.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({Key? key}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: null,
              child: Text("1000 Coins Needed",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(20),
                      color: primaryColor,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/refer.png",
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                          Text("Live Session at ₹ 1500",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 26))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          auraskCoin(30),
                          wbox10,
                          Text("1000 GL Coins",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                        ],
                      ),
                      box20,
                      Text("Valid Till Dec 31, 11:59 PM",
                          style: GoogleFonts.montserrat(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                      box20,
                      Text("How To Use",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      box10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• Go to Home Page",
                                style: GoogleFonts.montserrat(fontSize: 13)),
                            box5,
                            Text("• Select Any Course and Proceed to buy",
                                style: GoogleFonts.montserrat(fontSize: 13)),
                            box5,
                            Text(
                                "• You will see an option to pay with Aurask Coins if you are eligible.",
                                style: GoogleFonts.montserrat(fontSize: 13)),
                          ],
                        ),
                      ),
                      box20,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
