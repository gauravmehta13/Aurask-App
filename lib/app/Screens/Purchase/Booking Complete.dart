import 'package:aurask/app/Screens/My%20Courses/MyCourses%20TabBar.dart';
import 'package:aurask/meta/Widgets/Bottom%20Navigation%20Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/redux/app_state.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../Home/BottomNavBar.dart';
import '../Info%20Screens/CourseInfo.dart';

class BookingComplete extends StatelessWidget {
  final String? name;
  final String type;
  final String? link;
  const BookingComplete({Key? key, this.name, this.link, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {},
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomButton(
              onPressed: () {
                Navigator.push(context, FadeRoute(page: MyCoursesTabbar()));
              },
              text: "View Your Tickets",
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, FadeRoute(page: BottomNavBar()));
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    box30,
                    Image.network(
                      "https://image.flaticon.com/icons/png/128/214/214353.png",
                      height: 150,
                    ),
                    box10,
                    Text(
                      "Booking Confirmed",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    box10,
                    Text("See you at the event"),
                    box20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Share.share("I am attending ${[
                              "Free Seminar",
                              "Live Session"
                            ].contains(name) ? name ?? "" + " " + type : name} from Aurask, You can also join by visiting aurask.net");
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.share,
                              color: Colors.grey[850],
                              size: 20,
                            ),
                          ),
                        ),
                        wbox30,
                        GestureDetector(
                          onTap: () async {
                            await launch(
                                "https://calendar.google.com/calendar/u/0/r/eventedit?dates=20210226T033000/20210226T040000&ctz=Asia/Calcutta&location&text=Blawsome:+A+Crystal+Alchemy+Healing+Meditation&details=Parth+Pitroda");
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: Colors.grey[850],
                            ),
                          ),
                        )
                      ],
                    ),
                    box30,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Suggestions for you",
                            style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800])),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 20),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.courses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  FadeRoute(
                                      page: CourseInfo(
                                    course: state.courses[index],
                                  )),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 200,
                                            clipBehavior: Clip.hardEdge,
                                            margin: EdgeInsets.only(right: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Image.network(
                                              state.courses[index]["image"],
                                              fit: BoxFit.cover,
                                            )),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 7),
                                            child: Text(
                                              "⭐ ${state.courses[index]["rating"]}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFf09ea3)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(state.courses[index]["name"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.grey[400],
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Vinay Yadav",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFf09ea3)
                                                .withOpacity(0.3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 7),
                                        child: Text(
                                          "Best Seller",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFd88e93)),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    box30,
                    box30,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
