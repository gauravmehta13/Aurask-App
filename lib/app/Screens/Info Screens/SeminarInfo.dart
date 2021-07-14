import 'package:aurask/meta/Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/redux/actions.dart';
import '../../../core/redux/app_state.dart';
import '../../../core/resources/api_provider.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../Other/Booking Complete.dart';
import 'CourseInfo.dart';

class SeminarInfo extends StatefulWidget {
  final bool forwarded;
  final id;
  const SeminarInfo({Key? key, this.id, this.forwarded = false})
      : super(key: key);

  @override
  _SeminarInfoState createState() => _SeminarInfoState();
}

class _SeminarInfoState extends State<SeminarInfo> {
  @override
  void initState() {
    super.initState();
    loading = widget.forwarded ? true : false;
    if (widget.forwarded) getSession();
  }

  bool loading = true;
  Map seminar = {};

  getSession() async {
    var map = await getSeminarDetails(widget.id);
    print(map);
    setState(() {
      seminar = map;
      loading = false;
    });
  }

  Future bookSession() async {
    // setState(() {
    //   buyingCourse = true;
    // });
    try {
      var dio = Dio();
      print(auth.currentUser?.uid);
      print(widget.id);
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=aurask&tenantUsecase=bookLiveSession",
          data: {
            "id": auth.currentUser?.uid,
            "email": auth.currentUser?.email,
            "liveSessionId": widget.id,
          });
      print(response.data);
      successDialog(context, response.data["resp"], 10);
      //  Navigator.push(context, FadeRoute(page: BookingComplete()));
      // setState(() {
      //   buyingCourse = false;
      // });
    } catch (e) {
      // setState(() {
      //   buyingCourse = false;
      // });
      print(e);
      if (e.toString().contains("Already Purchased"))
        errorDialog(context, "Course Already Purchased", 10);
      else
        errorDialog(context, "Please Try Again after some time", 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) async {
          if (store.state.courses.length == 0) {
            Map courses = await getCourses();
            StoreProvider.of<AppState>(context)
                .dispatch(Courses(courses["courses"]));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: InkWell(
                onTap: () {
                  bookSession();
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4,
                  child: Container(
                      width: double.maxFinite,
                      height: 60,
                      color: primaryColor,
                      child: Center(
                        child: Text("Book Tickets",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600)),
                      )),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height / 3,
                            child: Image.network(
                              seminar["image"] ??
                                  "https://miro.medium.com/max/1954/1*kb1bu3bHdyKPskfGz-efgg.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Icon(Icons.arrow_back)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          loading
                              ? Loading()
                              : Text(seminar["name"] + " " + seminar["type"],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                          box20,
                          loading
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Center(child: Loading()))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      dense: true,
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.calendar_today,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      title: Text(seminar["date"]),
                                      subtitle: Text(seminar["time"]),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      dense: true,
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_pin,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      title: Text(seminar["mode"]),
                                      subtitle: Text(seminar["venue"]),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      dense: true,
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.ticketAlt,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      title: Text(seminar["type"]),
                                      subtitle:
                                          Text(seminar["price"].toString()),
                                    ),
                                    Divider(color: Colors.grey),
                                    box20,
                                    Text("About",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800])),
                                    box10,
                                    Text(seminar["description"],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])),
                                    box20,
                                    Divider(color: Colors.grey),
                                    box10,
                                    Text("More like this",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800])),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    box10,
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
                                              fit: BoxFit.fill,
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
                    box30,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
