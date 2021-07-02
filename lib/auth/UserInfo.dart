import 'package:aurask/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.question_answer,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(_auth.currentUser!.photoURL!),
            ),
            box20,
            Text(
              _auth.currentUser!.displayName!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            box20,
            Text(
              "Tell us a little\nabout you",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            Spacer(),
            Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + 50,
                width: double.maxFinite,
                color: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white54,
                    ),
                    Expanded(child: Text("")),
                    Expanded(
                      flex: 3,
                      child: Container(
                          child: Column(
                        children: [
                          Text(
                            "I am currently Studying / Recently passed out of College",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          box10,
                          Text("data")
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          child: Column(
                        children: [
                          Text(
                            "I am working in a Service Based company for 1-2 Years",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          box10,
                          Text("data")
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          child: Column(
                        children: [
                          Text(
                            "I am having 5-10 years of Job Experience",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          box10,
                          Text("data")
                        ],
                      )),
                    ),
                    Divider(
                      color: Colors.white54,
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
