import '../../Gamification/ReferAndEarn.dart';
import '../../Gamification/Spin%20And%20Win.dart';
import '../../../../meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSpinAndWin(context) {
  return InkWell(
    onTap: () {
      authNavigate(SpinAndWin(), context);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 3,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      ),
      margin: EdgeInsets.all(10),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/fortuneWheel.jpg",
            cacheWidth: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SPIN\nAND WIN",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: secondaryColor.withOpacity(0.7),
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              box10,
              Text(
                "Chance to win\n₹5000 & more*",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    ),
  );
}

Widget buildReferAndEarn(context) {
  return InkWell(
    onTap: () {
      authNavigate(ReferAndEarn(), context);
    },
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        color: Color(0xFFaadbd5),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      ),
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      margin: EdgeInsets.all(10),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Refer & Earn",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 17,
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '100',
                      style: GoogleFonts.montserrat(
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.white.withOpacity(0.7),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    wbox5,
                    Text(
                      'Aurask Coins',
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
                  ],
                ),
                box10,
                Text(
                  "Also help your friend get 5% discount on their first course.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              "assets/refer.jpg",
              height: 150,
            ),
          ),
        ],
      ),
    ),
  );
}
