import 'package:aurask/Constants.dart';
import 'package:aurask/Home/BottomNavBar.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/Widgets/Loading.dart';
import 'package:aurask/model/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

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
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                DatabaseService(_auth.currentUser!.uid)
                                    .updateUserData(experience[index]["title"],
                                        experience[index]["level"]);
                                Navigator.pushReplacement(
                                  context,
                                  FadeRoute(page: BottomNavBar()),
                                );
                                setState(() {
                                  loading = false;
                                });
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

                  //   Column(
                  //     children: [
                  //       Divider(
                  //         height: 1,
                  //         color: Colors.white54,
                  //       ),
                  //       box30,
                  //       Expanded(
                  //         flex: 3,
                  //         child: InkWell(
                  //           onTap: () {
                  //             Navigator.pushReplacement(
                  //               context,
                  //               FadeRoute(page: BottomNavBar()),
                  //             );
                  //           },
                  //           child: Container(
                  //               child: Column(
                  //             children: [
                  //               Text(
                  //                 "Currently Studying / Recently passed out of College",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.white,
                  //                     fontSize: 20),
                  //               ),
                  //               box10,
                  //               Text(
                  //                 "data",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.white70,
                  //                     fontSize: 13),
                  //               ),
                  //               Divider()
                  //             ],
                  //           )),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 3,
                  //         child: Container(
                  //             child: Column(
                  //           children: [
                  //             Text(
                  //               "Working in a Service Based company for 1-2 Years",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   color: Colors.white,
                  //                   fontSize: 20),
                  //             ),
                  //             box10,
                  //             Text(
                  //               "data",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   color: Colors.white70,
                  //                   fontSize: 13),
                  //             ),
                  //             Divider()
                  //           ],
                  //         )),
                  //       ),
                  //       Expanded(
                  //         flex: 3,
                  //         child: Container(
                  //             child: Column(
                  //           children: [
                  //             Text(
                  //               "Having 5-10 years of Job Experience",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   color: Colors.white,
                  //                   fontSize: 20),
                  //             ),
                  //             box10,
                  //             Text(
                  //               "data",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   color: Colors.white70,
                  //                   fontSize: 13),
                  //             ),
                  //           ],
                  //         )),
                  //       ),
                  //       Divider(
                  //         height: 1,
                  //         color: Colors.white54,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ))
          ],
        ),
      ),
    );
  }
}
