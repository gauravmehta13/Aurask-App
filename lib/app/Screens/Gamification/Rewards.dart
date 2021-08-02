import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../meta/Utility/Constants.dart';
import '../Home/Components/banners.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Referrals & Rewards',
          style:
              GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            box20,
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Your Aurask Coins',
                    style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white.withOpacity(0.7),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  auraskCoin(50),
                  wbox20,
                  Text(
                    '100',
                    style: GoogleFonts.ubuntu(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white.withOpacity(0.7),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildSpinAndWin(context),
            buildReferAndEarn(context),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                margin: EdgeInsets.all(10),
                //  height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0))),
                            child: Row(children: [
                              Icon(Icons.lock),
                              wbox10,
                              Text(
                                "Not Enough Coins",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                          ),
                          box10,
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: new TextSpan(
                                    text: 'Live Session at\n',
                                    style: GoogleFonts.montserrat(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.white.withOpacity(0.7),
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: '₹ 1500',
                                        style: GoogleFonts.montserrat(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                box10,
                                Text(
                                  "Choose any 1 live session worth ₹  at ₹ 1499",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                box5,
                                Row(
                                  children: [
                                    auraskCoin(30),
                                    wbox10,
                                    Text(
                                      "1000 Aurask Coins",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/offer.jpg",
                        height: 150,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
