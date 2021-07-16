import 'package:aurask/app/Screens/Info%20Screens/SeminarInfo.dart';
import 'package:aurask/core/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../core/model/supabase%20Manager.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/Loading.dart';
import '../../../meta/Widgets/No%20Results%20Found.dart';
import '../Info Screens/CourseInfo.dart';

class SearchCourses extends StatefulWidget {
  final String keyword;
  const SearchCourses({
    Key? key,
    this.keyword = "",
  }) : super(key: key);

  @override
  _SearchCoursesState createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  bool loading = true;
  List allCourses = [];
  List filteredCourses = [];
  TextEditingController query = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  filterCourse() {
    setState(() {
      filteredCourses = (allCourses)
          .where((u) =>
              (u["name"].toLowerCase().contains(query.text.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {
          query.text = widget.keyword;
          allCourses = store.state.courses + store.state.seminars;
          filteredCourses = (allCourses)
              .where((u) =>
                  (u["name"].toLowerCase().contains(query.text.toLowerCase())))
              .toList();
          loading = false;
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: primaryColor,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      wbox10,
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: query,
                            onChanged: (e) {
                              filterCourse();
                            },
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 15, right: 15),
                                hintText: "Search for a Course"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(100.0),
              ),
              body: loading
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Loading())
                  : filteredCourses.length == 0
                      ? NoResult()
                      : GroupedListView<dynamic, String>(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          physics: BouncingScrollPhysics(),
                          elements: filteredCourses,
                          groupBy: (element) => element['type'],
                          groupComparator: (value1, value2) =>
                              value1.compareTo(value2),
                          itemComparator: (item1, item2) =>
                              item2['type'].compareTo(item1['type']),
                          // optional
                          useStickyGroupSeparators: true, // optional
                          // floatingHeader: true, // optional
                          order: GroupedListOrder.DESC,
                          groupSeparatorBuilder: (String value) => Container(
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.all(8.0),
                                    color: primaryColor.withOpacity(0.2),
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                          itemBuilder: (c, element) {
                            return InkWell(
                              onTap: () {
                                ["Live Session", "Free Seminar"]
                                        .contains(element["type"])
                                    ? Navigator.push(
                                        context,
                                        FadeRoute(
                                            page:
                                                SeminarInfo(seminar: element)))
                                    : Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: CourseInfo(course: element)));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.only(bottom: 16),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 100,
                                      child: Image.network(
                                        element["image"],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(element["name"],
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700)),
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
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
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
            ),
          );
        });
  }
}
