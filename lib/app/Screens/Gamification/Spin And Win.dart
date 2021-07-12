import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../meta/Utility/Constants.dart';
import '../../../meta/Widgets/Bottom%20Navigation%20Button.dart';
import '../../../meta/Widgets/Loading.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SpinAndWin extends StatefulWidget {
  @override
  _SpinAndWinState createState() => _SpinAndWinState();
}

class _SpinAndWinState extends State<SpinAndWin> {
  StreamController<int> selected = StreamController<int>.broadcast();
  late ConfettiController _controllerCenter;
  final spinKey = new GlobalKey();

  late SharedPreferences prefs;
  bool spinLeft = false;
  bool error = false;
  DateTime now = new DateTime.now();
  bool loading = true;
  List rewardList = [];

  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      getRewards();
    });
    //checkLogin(SpinAndWin(), context);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    Stream stream = selected.stream;
    stream.listen((value) {
      print('Value from controller: $value');
      setState(() {
        reward = rewardList[value];
      });
    });
    //logEvent("Spin_And_Win");
  }

  List probability = [];

  getRewards() async {
    setState(() {
      error = false;
      loading = true;
    });
    try {
      var dio = Dio();
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=PAMREWARDS01&usecase=spinAndWin',
          data: {"userId": _auth.currentUser!.uid});
      print(response.data);
      var map = response.data["resp"];
      // spin and win based on probability
      for (var i = 0; i < map["rewardsList"].length; i++) {
        for (var j = 0; j < map["rewardsList"][i]["prob"]; j++) {
          probability.add("$i");
        }
      }
      setState(() {
        probability.shuffle();
        spinLeft = map["isValid"];
        rewardList = map["rewardsList"];
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = true;
        loading = false;
      });
      displaySnackBar(e.toString(), context);
    }
  }

  sendReward() async {
    try {
      var dio = Dio();
      final response = await dio.post(
          'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=PAMREWARDS01&usecase=rewardEarn&tenantUsecase=spinAndWin',
          data: {"userId": _auth.currentUser!.uid, "coupon": reward});
      print(response.data);

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = true;
        loading = false;
      });
      displaySnackBar(e.toString(), context);
    }
  }

  getProgress() async {
    prefs = await SharedPreferences.getInstance();
    try {
      int? date = prefs.getInt('SpinDate');
      if (date == now.day) {
        setState(() {
          spinLeft = true;
        });
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    selected.close();
    super.dispose();
  }

  Map reward = {};
  bool isAnimating = false;

  int roll(int itemCount) {
    int p = Random().nextInt(probability.length);
    return int.parse(probability[p]);
  }

  void handleRoll() {
    selected.add(
      roll(rewardList.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: loading || error
          ? Container(
              height: 0,
            )
          : BottomButton(
              text: !spinLeft
                  ? "Come back next week for more spins"
                  : isAnimating
                      ? "Please Wait"
                      : "Tap to Spin",
              onPressed: !spinLeft
                  ? null
                  : isAnimating
                      ? null
                      : () async {
                          Scrollable.ensureVisible(spinKey.currentContext!,
                              duration: Duration(milliseconds: 500));
                          handleRoll();
                        },
            ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  buildHeader(),
                  box30,
                  loading
                      ? Container(height: 300, child: Loading())
                      : error
                          ? Container()
                          // ? Error404(
                          //     onpressed: getRewards,
                          //   )
                          : Column(
                              children: [
                                //   buildRewards(),
                                box20,
                                Container(
                                  key: spinKey,
                                  height: 350,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 10,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: FortuneWheel(
                                    animateFirst: false,
                                    duration: Duration(seconds: 10),
                                    indicators: [
                                      const FortuneIndicator(
                                        alignment: Alignment.topCenter,
                                        child: const TriangleIndicator(
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ],
                                    onAnimationStart: () {
                                      setState(() {
                                        isAnimating = true;
                                      });
                                    },
                                    onAnimationEnd: () {
                                      setState(() {
                                        isAnimating = false;
                                        spinLeft = false;
                                      });
                                      if (reward.isNotEmpty) {
                                        reward["Name"].contains("Better Luck")
                                            ? showLostDialog()
                                            : showWinDialog();
                                      }
                                    },
                                    selected: selected.stream,
                                    items: [
                                      for (var i = 0;
                                          i < rewardList.length;
                                          i++)
                                        FortuneItem(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                rewardList[i]["Name"],
                                                style: TextStyle(
                                                    color: i % 2 != 0
                                                        ? Colors.white
                                                        : Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              rewardList[i]["value"] == "0"
                                                  ? Container(
                                                      height: 0,
                                                    )
                                                  : Text(
                                                      "₹ ${rewardList[i]["value"].toString()}",
                                                      style: TextStyle(
                                                          color: i % 2 != 0
                                                              ? Colors.white
                                                              : Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ],
                                          ),
                                          style: FortuneItemStyle(
                                            color: i % 2 == 0
                                                ? Colors.red
                                                : primaryColor,
                                            // colors[i],
                                            borderColor: secondaryColor,
                                            borderWidth:
                                                3, // <-- custom circle slice stroke width
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                box30,

                                if (rewardList.length != 0)
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      top: BorderSide(color: Colors.grey[400]!),
                                      bottom:
                                          BorderSide(color: Colors.grey[400]!),
                                    )),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(children: [
                                      FaIcon(
                                        FontAwesomeIcons.trophy,
                                        color: Colors.grey[700],
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Rewards you've won",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            //   viewRewards(context);
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ]),
                                  ),
                                box30,
                                buildReviews(),
                              ],
                            ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    false, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
          ],
        ),
      )),
    );
  }

  showWinDialog() {
    print("Won");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ),
                Center(
                    child: Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                )),
                box10,
                Text(
                  "You Won",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                box5,
                Text(
                  reward["Name"],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                box5,
                Text(
                  "₹ ${reward["value"]}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                box10,
                Text(
                    "You will get an Email or SMS with the voucher details after you share the app with friends.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
                box10,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        sendReward();
                        Share.share("m.goflexe.com");
                      },
                      child: Text(
                        "Share to Redeem",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    _controllerCenter.play();
  }

  showLostDialog() {
    sendReward();
    print("Lost");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ),
              Image.asset(
                "assets/sad.png",
                height: 80,
              ),
              box20,
              Center(
                  child: Text(
                'Sorry!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
              box10,
              Text(
                "Better Luck Next Time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              box10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      Share.share("m.goflexe.com");
                    },
                    child: Text(
                      "Share",
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildHeader() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Theme.of(context).hintColor),
        )),
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SPIN\nAND WIN",
                    style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: secondaryColor.withOpacity(0.7),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                  box5,
                  Text(
                    "Play & Win exciting\nprizes everyday",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Image.asset(
              "assets/gift.png",
              height: 120,
            ))
          ],
        ),
      ),
    );
  }

  Widget buildRewards() {
    final double runSpacing = 5;
    final double spacing = 5;

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get a chance to win:",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        box10,
        Wrap(
          runSpacing: runSpacing,
          spacing: spacing,
          alignment: WrapAlignment.center,
          children: List.generate(
            rewardList.length,
            (i) {
              return rewardList[i]["value"] == "0"
                  ? SizedBox.shrink()
                  : new Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        side: new BorderSide(color: primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 70,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              rewardList[i]["Name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "₹ ${rewardList[i]["value"].toString()}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        )
      ],
    ));
  }

  Widget buildReviews() {
    List reviews = [
      {
        "review":
            "It adds fun element in my life during these stressful pandemic days",
        "by": "Sudha"
      },
      {"review": "Good, I love to play Spin and Win", "by": "Vivek"},
      {
        "review":
            "It adds fun element in my life during these stressful pandemic days",
        "by": "Sudha"
      },
    ];

    final double runSpacing = 10;
    final double spacing = 10;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Here's what our happy winners have to say:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            box20,
            Wrap(
              runSpacing: runSpacing,
              spacing: spacing,
              alignment: WrapAlignment.center,
              children: List.generate(reviews.length, (i) {
                return Container(
                  height: 70,
                  width: (MediaQuery.of(context).size.width / 2) - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        reviews[i]["review"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "- ${reviews[i]["by"]}",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                );
              }),
            ),
            box20,
          ],
        ));
  }
}
