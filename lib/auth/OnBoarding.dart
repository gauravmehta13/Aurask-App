import 'package:aurask/Home/BottomNavBar.dart';
import 'package:aurask/Home/HomePage.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/auth/UserDetails.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Constants.dart';

final List<String> topText = [
  "Learn the most In-Demand skills for Free",
  "Prepare and Crack your Dream Job",
  "Transform your Career with Live Semainars"
];

class OnboardingScreen extends StatefulWidget {
  final Widget? page;
  OnboardingScreen({this.page});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              box30,
              Text(
                'Aurask',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              box20,
              Spacer(),
              CarouselSlider(
                items: List<Widget>.generate(
                    3,
                    (i) => Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  topText[i],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                              Image.asset("assets/login/${i + 1}.png",
                                  fit: BoxFit.cover, width: double.maxFinite),
                            ],
                          ),
                        )),
                carouselController: _controller,
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: MediaQuery.of(context).size.height / 1.8,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: topText.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor
                              .withOpacity(_current == entry.key ? 0.9 : 0.1)),
                    ),
                  );
                }).toList(),
              ),
              Spacer(),
              loading
                  ? CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        googleLogin();
                      },
                      child: Card(
                        color: Color(0xFF186be5),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  height: 45,
                                  width: 45,
                                  child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png')),
                              Text(
                                'CONTINUE WITH GOOGLE',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text("")
                            ],
                          ),
                        ),
                      ),
                    ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future googleLogin() async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential).then((value) async {
          print(value.additionalUserInfo!.isNewUser);
          if (value.additionalUserInfo!.isNewUser) {
            Navigator.pushReplacement(
              context,
              FadeRoute(
                  page: UserDetails(
                page: widget.page,
              )),
            );
          } else {
            Navigator.pushReplacement(
              context,
              FadeRoute(page: widget.page ?? BottomNavBar()),
            );
          }
          setState(() {
            loading = false;
          });
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      displaySnackBar("Error, please try again later..!!", context);
    }
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }
}
