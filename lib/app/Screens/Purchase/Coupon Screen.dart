import 'package:aurask/core/redux/app_state.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponScreen extends StatefulWidget {
  final amount;
  final coupons;
  const CouponScreen({Key? key, @required this.coupons, this.amount})
      : super(key: key);

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late TextEditingController couponCode;
  bool loading = false;

  void initState() {
    super.initState();

    couponCode = TextEditingController();
  }

  applyCoupon(coupon) async {
    setState(() {
      loading = true;
    });
    try {
      var dio = Dio();
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=COUPONS01&tenantUsecase=applyCoupon&usecase=applyCoupon",
          data: {"cid": coupon, "price": widget.amount});
      var map = response.data["resp"];
      setState(() {
        loading = false;
      });
      Navigator.pop(context, map);
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      displaySnackBar("Wrong Coupon Code", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Apply Coupons",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            body: Column(
              children: [
                if (loading)
                  LinearProgressIndicator(
                    backgroundColor: primaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      secondaryColor,
                    ),
                  ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: TextFormField(
                      controller: couponCode,
                      decoration: new InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Coupon Code',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: TextButton(
                          onPressed: () {
                            applyCoupon(couponCode.text);
                          },
                          child: Text(
                            "APPLY",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(0.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.grey[400]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  width: double.maxFinite,
                ),
                Container(
                  width: double.maxFinite,
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Available Coupons",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.coupons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  box10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                          color: Colors.amber[100],
                                          elevation: 2,
                                          // shape: CouponShapeBorder(
                                          //     dash: false,
                                          //     lineRate: 0.3,
                                          //     color: Colors.transparent),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8),
                                            height: 50,
                                            width: 150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                state.coupons[index]["imgUrl"]
                                                        .toString()
                                                        .isEmpty
                                                    ? Image.asset(
                                                        "assets/discount.png",
                                                        width: 30,
                                                      )
                                                    : Image.network(
                                                        state.coupons[index]
                                                            ["imgUrl"],
                                                        width: 30,
                                                      ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    state.coupons[index]["cid"],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                SizedBox.shrink()
                                              ],
                                            ),
                                          )),
                                      TextButton(
                                        onPressed: () {
                                          applyCoupon(
                                              state.coupons[index]["cid"]);
                                        },
                                        child: Text(
                                          "APPLY",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  box10,
                                  Text(
                                    " ${"GET"} ${state.coupons[index]["percent"] == "true" ? state.coupons[index]["value"] + " %" : "Rs. " + state.coupons[index]["value"]} OFF   ${state.coupons[index]["Name"]}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Divider(
                                    color: Colors.grey[400],
                                  ),
                                  Text(
                                    state.coupons[index]["description"],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              height: 30,
                              color: Colors.grey[400],
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
