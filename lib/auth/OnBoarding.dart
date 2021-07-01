import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants.dart';

class OnboardingScreen extends StatefulWidget {
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

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height / 7,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'FastMeds',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    box20,
                    box20,
                    loading
                        ? CircularProgressIndicator()
                        : MaterialButton(
                            color: Colors.white,
                            elevation: 10,
                            height: 45,
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              googleLogin();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Color(0xff3b5998))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png', scale: 3),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Get Started',
                                  style: TextStyle(color: Color(0xff3b5998)),
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
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
          // print(value.additionalUserInfo!.isNewUser);
          // if (value.additionalUserInfo!.isNewUser) {
          //   await DatabaseService(_auth.currentUser!.uid).updateUserData("");
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => SelectTenant()));
          // } else {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => SelectTenant()));
          // }
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

  // checkAuthentification() async {
  //   _auth.authStateChanges().listen((user) {
  //     if (user != null) {
  //       print(user);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     }
  //   });
  // }
}
