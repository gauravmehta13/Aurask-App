import 'package:aurask/app/Screens/Purchase/Booking%20Complete.dart';
import 'package:aurask/core/redux/actions.dart';
import 'package:aurask/core/redux/app_state.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import 'Coupon Screen.dart';

class PaymentPage extends StatefulWidget {
  final Map course;
  final int price;
  final String type;

  const PaymentPage(
      {Key? key, required this.course, required this.price, required this.type})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map coupon = {};
  bool loading = false;
  bool couponApplied = false;
  late ConfettiController _controllerCenter;
  int totalAmount = 0;
  int tempAmount = 0;
  var dio = Dio();

  ////////////////////////////////
  ///
  String mid = "lziDdZ71034278533888",
      orderId = "",
      txnToken = "9501786200754fa18cb97afc06e693781626683190864",
      result = "";
  bool isStaging = true;
  bool isApiCallInprogress = false;
  String callbackUrl = "https://securegw-stage.paytm.in/";
  bool restrictAppInvoke = true;

  ///
  ///////////////////////////////////
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 500));
    totalAmount = widget.price;
    tempAmount = widget.price;
  }

  Future bookSeminar() async {
    setState(() {
      loading = true;
    });
    try {
      var dio = Dio();
      print(auth.currentUser?.uid);
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=aurask&tenantUsecase=bookLiveSession",
          data: {
            "id": auth.currentUser?.uid,
            "email": auth.currentUser?.email,
            "liveSessionId": widget.course["id"],
          });
      print(response.data);
      Navigator.push(
          context,
          FadeRoute(
              page: BookingComplete(
                  name: widget.course["name"], type: widget.type)));
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
      if (e.toString().contains("Already Purchased"))
        errorDialog(context, "Course Already Purchased", 10);
      else
        errorDialog(context, "Please Try Again after some time", 10);
    }
  }

  Future buyCourse() async {
    setState(() {
      loading = true;
    });
    try {
      var dio = Dio();
      print(auth.currentUser?.uid);
      print(widget.course["id"]);
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=aurask&tenantUsecase=purchaseCourse",
          data: {
            "id": auth.currentUser?.uid,
            "courseId": widget.course["id"],
          });
      print(response.data);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingComplete(
                  name: widget.course["Name"],
                  type: widget.type,
                )),
      );
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
      if (e.toString().contains("Already Purchased"))
        errorDialog(context, "Course Already Purchased", 10);
    }
  }

  purchaseCourse() {
    ["Free Seminar", "Live Session"].contains(widget.type)
        ? bookSeminar()
        : buyCourse();
  }

  getRewards(Map data) async {
    try {
      final response = await dio.post(
          "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=COUPONS01&tenantUsecase=getCoupons&usecase=getCoupons",
          data: data);
      print(response.data);
      var map = response.data["resp"];
      StoreProvider.of<AppState>(context).dispatch(Coupons(map));
      setState(() {});
    } catch (e) {
      print(e);
      setState(() {});
      displaySnackBar("Error in generating Coupon", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Order Details",
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.w600)),
            box30,
            Container(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    child: CachedNetworkImage(
                      imageUrl: widget.course["image"],
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  wbox20,
                  Expanded(
                    child: Text(
                        ["Free Seminar", "Live Session"]
                                .contains(widget.course["type"])
                            ? widget.course["name"] +
                                " " +
                                widget.course["type"]
                            : widget.course["name"],
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
            box20,
            Divider(height: 20, thickness: 1, color: Colors.black54),
            Text("Summary",
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w600)),
            box20,
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Basic Charges",
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        "₹ ${widget.price}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  box10,
                  if (!couponApplied)
                    InkWell(
                      onTap: () async {
                        final Map result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CouponScreen(
                                    amount: "tempAmount",
                                    coupons: "state.coupons",
                                  )),
                        );
                        if (result.length != 0) {
                          _controllerCenter.play();
                          showCouponApplied(context, result);
                          setState(() {
                            // totalAmount = result["price"];
                            coupon = result;
                            couponApplied = true;
                          });
                        }

                        print(result);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                                "https://image.flaticon.com/icons/png/128/726/726476.png",
                                height: 18),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Apply Coupon"),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                        color: Colors.grey[300],
                      ),
                    )
                  else if (couponApplied)
                    InkWell(
                      onTap: () {
                        setState(() {
                          couponApplied = false;
                          totalAmount = tempAmount;
                          coupon = {};
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.close),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coupon Applied",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Text(
                                coupon["Name"],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Spacer(),
                          if (coupon["internalCoupon"] == "true")
                            Text(
                              "- ₹ ${coupon["value"]}",
                              style: TextStyle(fontSize: 15),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 40, thickness: 1, color: Colors.black54),
            Row(
              children: [
                Text(
                  "Order Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "₹ $totalAmount",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ])),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () async {
              if (totalAmount == 0) {
                purchaseCourse();
              } else if (!kIsWeb) {
                installAppDialog(context);
              } else {
                startTransaction();
              }
            },
            child: loading == true
                ? Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Color(0xFF3f51b5),
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xFFf9a825),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: totalAmount == 0
                        ? Row(
                            children: [
                              Text(
                                "Free",
                              ),
                              Spacer(),
                              Text(
                                "Book Now",
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "₹ $totalAmount ",
                              ),
                              Spacer(),
                              Text(
                                "Complete Payment",
                              ),
                            ],
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": totalAmount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
          mid,
          // orderId,
          "ORDERID_98765",
          totalAmount.toString(),
          txnToken,
          callbackUrl,
          isStaging,
          restrictAppInvoke);
      response.then((value) {
        print("no error");
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        print("error");
        print(onError.toString());
        if (onError is PlatformException) {
          setState(() {
            result = onError.message! + " \n  " + onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      print("errorC");
      result = err.toString();
    }
    print(result);
  }
}

Future<void> showCouponApplied(ctx, Map coupon) async {
  print(coupon);
  return showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${coupon["cid"].toString()} Applied",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      box10,
                      Text(
                        "₹ ${coupon["value"]}",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      box5,
                      Text("savings with this coupon"),
                      box20,
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("YAY!"))
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: Image.asset("assets/discount.png")),
                  ),
                ),
              ],
            ));
      });
}
