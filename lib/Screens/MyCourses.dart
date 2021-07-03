import 'package:aurask/model/supabase%20Manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  List myCourses = [];
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
        // .match({"userId": _auth.currentUser?.uid})
        .eq("userId", _auth.currentUser?.uid)
        .execute();
    print(resp.data);
    setState(() {
      myCourses = resp.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Courses"),
        ),
        body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: myCourses.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     FadeRoute(page: PremiumMembership()));
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.only(bottom: 16),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 100,
                        child: Image.network(
                          myCourses[index]["courses"]["image"],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(myCourses[index]["courses"]["name"],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                Spacer(),
                                Text(myCourses[index]["courseType"]["title"],
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
            }));
  }
}
