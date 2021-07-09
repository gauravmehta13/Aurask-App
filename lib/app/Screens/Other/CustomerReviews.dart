import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../meta/Utility/Constants.dart';

class CustomerReviews extends StatelessWidget {
  final reviews;
  const CustomerReviews({Key? key, this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student feedback",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87.withOpacity(0.8)),
              ),
              Text(
                "What students are saying about our courses",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ],
          ),
          box10,
          Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  return reviews[index].text.isEmpty
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width - 100,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            border: Border.all(
                                width: 3, color: primaryColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Image.network(
                                        reviews[index].profilePhotoUrl),
                                    backgroundColor: Colors.grey[400],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reviews[index].authorName,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF0d5371)),
                                        ),
                                        box5,
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: double.tryParse(
                                              reviews[index]
                                                  .rating
                                                  .toString())!,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          itemSize: 13,
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              box10,
                              Flexible(
                                child: Text(
                                  reviews[index].text,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              box5,
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  reviews[index].relativeTimeDescription,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: Color(0xFF01acf3),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                }),
          ),
          box10,
        ],
      ),
    );
  }
}
