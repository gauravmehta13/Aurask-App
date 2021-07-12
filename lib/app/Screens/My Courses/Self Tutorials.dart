import '../Course/CourseTabs.dart';
import '../../../core/model/supabase%20Manager.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SelfTutorials extends StatefulWidget {
  @override
  _SelfTutorialsState createState() => _SelfTutorialsState();
}

class _SelfTutorialsState extends State<SelfTutorials> {
  bool loading = true;
  List myCourses = [];
  List filteredCourses = [];
  @override
  void initState() {
    super.initState();
    getMyCourses();
  }

  getMyCourses() async {
    final resp = await client
        .from('purchasedCourses')
        .select(
          'courseType,courses(*)',
        )
        //.contains(column, value)
        // .match({"userId": _auth.currentUser?.uid})
        .eq("userId", _auth.currentUser?.uid)
        .execute();
    print(resp.data);
    myCourses = resp.data;
    filteredCourses = myCourses;
    filter(1);
    setState(() {
      loading = false;
    });
  }

  filter(condition) {
    filteredCourses =
        (myCourses).where((u) => u["courseType"]["id"] == condition).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          loading
              ? Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Loading())
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredCourses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            FadeRoute(
                                page: CourseTabs(
                              course: filteredCourses[index],
                            )));
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.only(bottom: 16),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 100,
                              child: Image.network(
                                filteredCourses[index]["courses"]["image"],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          filteredCourses[index]["courses"]
                                              ["name"],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700)),
                                      Spacer(),
                                      Text(
                                          filteredCourses[index]["courseType"]
                                              ["title"],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: 4.3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemSize: 15,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (double value) {},
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "Get trained for comapnies like google , amazon , netflix etc.",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}
