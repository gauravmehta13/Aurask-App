import 'package:flutter/material.dart';

import '../../meta/Utility/Constants.dart';
import '../../meta/Utility/Fade%20Route.dart';
import '../../meta/Widgets/Loading.dart';
import '../Screens/Home/BottomNavBar.dart';

class UserDetails extends StatefulWidget {
  final Widget? page;
  const UserDetails({Key? key, this.page}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool loading = false;

  List experience = [
    {
      "level": "Student",
      "img": "https://image.flaticon.com/icons/png/512/3135/3135755.png",
      "title": "Currently Studying / Recently passed out of College",
    },
    {
      "level": "Working Professional",
      "img": "https://image.flaticon.com/icons/png/512/4961/4961532.png",
      "title": "Working in a Service Based company for 1-2 Years",
    },
    {
      "level": "Leader",
      "img": "https://image.flaticon.com/icons/png/512/2552/2552801.png",
      "title": "Having 5-10 years of Job Experience",
    },
  ];

  sendData(ex) async {
    setState(() {
      loading = true;
    });
    // var resp = await client.from('user').insert([
    //   {
    //     'userId': _auth.currentUser?.uid,
    //     "name": _auth.currentUser?.displayName ?? "",
    //     "email": _auth.currentUser?.email ?? "",
    //     "experience": ex["level"],
    //   }
    // ]).execute();

    //await postUserDetails(auth.currentUser?.uid, ex["level"]);

    Navigator.pushReplacement(
        context, FadeRoute(page: widget.page ?? BottomNavBar()));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(auth.currentUser?.photoURL ?? ""),
            ),
            box20,
            Text(
              "Welcome ${auth.currentUser?.displayName?.split(" ")[0] ?? ""}",
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
                                height: 40,
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
                                  child: Column(
                                    children: [
                                      Image.network(
                                        experience[index]["img"],
                                        height: 30,
                                      ),
                                      box10,
                                      Text(
                                        experience[index]["level"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      box10,
                                      Text(
                                        experience[index]["title"],
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
