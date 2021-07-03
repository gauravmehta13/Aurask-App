import 'package:aurask/Constants.dart';
import 'package:aurask/Home/BottomNavBar.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/Widgets/Loading.dart';
import 'package:aurask/model/supabase%20Manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final Widget? page;
  const UserDetails({Key? key, this.page}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List experience = [
    {
      "level": "Beginner",
      "title": "Currently Studying / Recently passed out of College",
      "subtitle": "Lorem Ipsum doler"
    },
    {
      "level": "Intermediate",
      "title": "Working in a Service Based company for 1-2 Years",
      "subtitle": "Lorem Ipsum doler"
    },
    {
      "level": "Advanced",
      "title": "Having 5-10 years of Job Experience",
      "subtitle": "Lorem Ipsum doler"
    },
  ];

  sendData(ex) async {
    setState(() {
      loading = true;
    });
    var resp = await client.from('user').insert([
      {
        'userId': _auth.currentUser?.uid,
        "name": _auth.currentUser?.displayName ?? "",
        "email": _auth.currentUser?.email ?? "",
        "experience": ex["level"],
      }
    ]).execute();
    print(resp.status);
    if (resp.status == 201) {
      Navigator.pushReplacement(
        context,
        FadeRoute(page: widget.page ?? BottomNavBar()),
      );
      setState(() {
        loading = false;
      });
    } else {
      displaySnackBar(resp.error!.message, context);
    }
  }

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
              backgroundImage: NetworkImage(_auth.currentUser?.photoURL ?? ""),
            ),
            box20,
            Text(
              "Welcome ${_auth.currentUser?.displayName?.split(" ")[0] ?? ""}",
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
                  alignment: Alignment.center,
                  child: loading
                      ? Loading(color: Colors.white)
                      : ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.white,
                              ),
                          shrinkWrap: true,
                          itemCount: experience.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                sendData(experience[index]);
                              },
                              child: Container(
                                  color: primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        experience[index]["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      box10,
                                      Text(
                                        experience[index]["subtitle"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white70,
                                            fontSize: 13),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                ))
          ],
        ),
      ),
    );
  }
}
