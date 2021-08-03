import 'package:aurask/app/Screens/Quiz/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../meta/Utility/Constants.dart';
import '../../Gamification/ReferAndEarn.dart';
import '../../Gamification/Spin%20And%20Win.dart';

Widget buildQuiz(context, int hour) {
  return InkWell(
    onTap: () {
      if (hour > 18) {
        displaySnackBar("Come Back at 6PM", context);
        return;
      }
      authNavigate(QuizHome(), context);
    },
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
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
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/quiz.jpg",
                cacheWidth: 200,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "QUIZ\nAND WIN",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.pink.withOpacity(0.7),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                    box10,
                    Text(
                      "Answer the questions and win exciting prizes Every Night",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Daily 6 PM - 12 AM",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  )))
        ],
      ),
    ),
  );
}

Widget buildSpinAndWin(context) {
  return InkWell(
    onTap: () {
      authNavigate(SpinAndWin(), context);
    },
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
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
                "Chance to win\n₹ 5000 & more*",
                style: GoogleFonts.ubuntu(
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
