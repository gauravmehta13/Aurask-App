import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class PegaCourses extends StatelessWidget {
  final List courses;
  const PegaCourses({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF192155),
      ),
      clipBehavior: Clip.hardEdge,
      child: Banner(
        location: BannerLocation.topEnd,
        color: Colors.red,
        message: "NEW",
        child: Column(
          children: [
            box20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Image.asset("assets/Pega.png", scale: 5),
            ),
            box10,
            Text("Get PEGA Trained with Aurask",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
            box20,
            Container(
              height: 160,
              width: double.maxFinite,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Modular.to
                              .pushNamed('/course', arguments: courses[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: MediaQuery.of(context).size.width / 3 - 13,
                          child: InkWell(
                            onTap: () {
                              Modular.to.pushNamed('/course',
                                  arguments: courses[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 180,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Image.network(
                                        courses[index]["image"],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(courses[index]["name"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
            ),
            box20,
          ],
        ),
      ),
    );
  }
}
