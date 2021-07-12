import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../meta/Utility/Constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      color: primaryColor,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/refer.png",
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                          Text(
                              "Refer and Earn 200 Aurask Coins on Each Successful referal",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16))
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
                    children: [
                      Text(
                          "Gift 100 Aurask Coins to your friends once they signup to Aurask App",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                      box10,
                      Text(
                          "Share code with your friends to earn Aurask Coins. Coins will be credited after each successfull signup.",
                          style: GoogleFonts.montserrat(fontSize: 13)),
                      box20,
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: "")).then(
                              (value) => displaySnackBar(
                                  'Copied to Clipboard', context));
                        },
                        child: DottedBorder(
                          color: primaryColor, //color of dotted/dash line
                          strokeWidth: 2, //thickness of dash/dots
                          radius: Radius.circular(30),

                          dashPattern: [7, 4],
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              _auth.currentUser!.uid,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      box20,
                      SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () async {
                                Share.share(_auth.currentUser!.uid);
                              },
                              child: Text("SHARE WITH FRIENDS"))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("How it Works",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w900, fontSize: 16)),
                      box20,
                      Text("Share your unique code",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      box10,
                      Text(
                          "Share your referral code with someone you know who wishes to learn exciting courses.",
                          style: GoogleFonts.montserrat(fontSize: 13)),
                      box20,
                      Text("Apply code",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      box10,
                      Text(
                          "Your friend can signup to Aurask App using your referral code.",
                          style: GoogleFonts.montserrat(fontSize: 13)),
                      box20,
                      Text("Get Referral benefits",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      box10,
                      Text(
                          "You will earn 200 Aurask Coins when your friend signup to Aurask App and your friend will earn 100 Aurask Coins to earn exciting rewards.",
                          style: GoogleFonts.montserrat(fontSize: 13)),
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
