import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paytm/paytm.dart';

import '../../../core/redux/actions.dart';
import '../../../core/redux/app_state.dart';
import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import 'Booking%20Complete.dart';
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

  bool testing = false;
  String testMid = "lziDdZ71034278533888";
  String testKey = "lyftLWyqKL6PKY%J";
  String testWebsite = "WEBSTAGING";

  String mid = "QdSUOS80610481329332";
  String merchantKey = "NoxrQy3YCMHna_ts";
  String website = "DEFAULT";
  String paymentResponse = "";
  Map paymentResponseMap = {};
  int test = 0;

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
            "payment": paymentResponseMap
          });
      print(response.data);
      Navigator.of(context).pop();
      Navigator.push(
          context,
          FadeRoute(
              page: BookingComplete(
            data: widget.course,
          )));
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
      if (e.toString().contains("Already Purchased"))
        errorDialog(context, "Course Already Purchased");
      else
        errorDialog(context, "Please Try Again after some time");
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
            "email": auth.currentUser?.email,
            "courseId": widget.course["id"],
            "payment": paymentResponseMap
          });
      print(response.data);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingComplete()),
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
        errorDialog(context, "Course Already Purchased");
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
            GestureDetector(
              onTap: () {
                setState(() {
                  test = test + 1;
                  if (test == 5) {
                    totalAmount = 1;
                  }
                });
              },
              child: Row(
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
              ),
            ),
            // CheckboxListTile(
            //   dense: true,
            //   title: const Text('Testing'),
            //   subtitle: const Text("Phone : 77777 77777 \nOTP : 489871"),
            //   secondary: const Icon(Icons.code),
            //   autofocus: false,
            //   selected: testing,
            //   value: testing,
            //   onChanged: (bool? value) {
            //     setState(() {
            //       testing = value!;
            //     });
            //   },
            // ),
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
              } else if (kIsWeb) {
                installAppDialog(context);
              } else {
                generateTxnToken(0);
              }
            },
            child: loading
                ? Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation(
                        primaryColor,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Spacer(),
                              Text(
                                "Book Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
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

  void generateTxnToken(int mode) async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://paytmpaymentsaurask.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": testing ? testMid : mid,
      "key_secret": testing ? testKey : merchantKey,
      "website": testing ? testWebsite : website,
      "orderId": orderId,
      "amount": totalAmount.toString(),
      "callbackUrl": callBackUrl,
      "custId": auth.currentUser!.uid,
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        paymentResponse = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(testing ? testMid : mid, orderId,
          txnToken, totalAmount.toString(), callBackUrl, testing);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          if (value["response"] != null) paymentResponseMap = value["response"];
          loading = false;
          print("Value is ");
          print(value);
          if (value["response"]?["STATUS"] != null &&
              value["response"]["STATUS"] == "TXN_SUCCESS") {
            purchaseCourse();
          } else if (value['error']) {
            errorDialog(context, value['errorMessage']);
            paymentResponse = value['errorMessage'];
          } else {
            errorDialog(context, value['errorMessage']);
            if (value['response'] != null) {
              paymentResponse = value['response']['STATUS'];
            }
          }
          paymentResponse += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      errorDialog(context, e);
    }
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
