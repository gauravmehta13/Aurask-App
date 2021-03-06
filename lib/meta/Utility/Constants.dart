import 'dart:io';
import 'dart:math';

import 'package:aurask/core/resources/login_Provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../app/auth/Login.dart';
import '../../core/resources/SharedPrefs.dart';
import 'Fade Route.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

shareCourse(String url, String txt) async {
  File img = await urlToFile(url);
  Share.shareFiles([img.path], text: txt);
}

share(String text) {
  Share.share(text);
}

final googleSignIn = GoogleSignIn(
    // clientId:
    //     //  !kIsWeb
    //     //     ? '491094163637-cqtcavhfoji1tnpmo4giglh6elugujb9.apps.googleusercontent.com'
    //     //     :
    //     "491094163637-t71a5r3al2buos5rplo3itqb9a7nkl1h.apps.googleusercontent.com",
    // scopes: <String>[googleAPI.CalendarApi.calendarScope],
    );

final FirebaseAuth auth = FirebaseAuth.instance;
SharedPref sharedPrefs = SharedPref();

// logEvent(String text) {
//   if (kReleaseMode) FirebaseAnalytics().logEvent(name: text, parameters: null);
// }

authNavigate(Widget page, context) {
  AuthenticationProvider user =
      Provider.of<AuthenticationProvider>(context, listen: false);

  if (user.firebaseAuth.currentUser == null) {
    Navigator.push(context, FadeRoute(page: LoginScreen(page: page)));
  } else {
    Navigator.push(context, FadeRoute(page: page));
  }
}

checkLogin(Widget page, context) {
  AuthenticationProvider user =
      Provider.of<AuthenticationProvider>(context, listen: false);
  if (user.firebaseAuth.currentUser == null) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        FadeRoute(
            page: LoginScreen(
          page: page,
        )),
      );
    });
  }
}

comingSoon(context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Column(
              children: [
                Center(child: Text('Coming Soon')),
                box20,
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ),
          ));
}

displaySnackBar(text, ctx) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    ),
  );
}

InputDecoration dropdownDecoration = InputDecoration(
  fillColor: Colors.white,
  isDense: true,
  counterText: "",
  contentPadding: EdgeInsets.fromLTRB(20, 1, 0, 1),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF2821B5),
    ),
  ),
  border: new OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: new BorderSide(color: Colors.grey)),
);

textfieldDecoration(label, hint) {
  return InputDecoration(
      isDense: true,
      counterText: "",
      contentPadding: EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF2821B5),
        ),
      ),
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey)),
      labelText: label,
      hintText: hint);
}

launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+917995572853',
    text: "Hey! I'm inquiring about the courses provided by Aurask",
  );
  await launch('$link');
}

const EdgeInsets padding10 = EdgeInsets.all(10);
const SizedBox wbox5 = SizedBox(
  width: 5,
);
const SizedBox wbox10 = SizedBox(
  width: 10,
);
const SizedBox wbox20 = SizedBox(
  width: 20,
);
const SizedBox wbox30 = SizedBox(
  width: 30,
);
const SizedBox box5 = SizedBox(
  height: 5,
);
const SizedBox box10 = SizedBox(
  height: 10,
);
const SizedBox box20 = SizedBox(
  height: 20,
);
const SizedBox box30 = SizedBox(
  height: 30,
);
Color primaryColor = Color(0xFF00a9b6);

const Color secondaryColor = Color(0xFFf9a825);

Widget auraskCoin(double height) {
  return Image.network(
    "https://image.flaticon.com/icons/png/128/432/432630.png",
    height: height,
  );
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

installAppDialog(context) {
  return CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      title: "Sorry",
      text: 'Currently we are only accepting payments from Android App.',
      confirmBtnText: "Download App",
      onConfirmBtnTap: () async {
        await launch(
            "https://play.google.com/store/apps/details?id=com.aurask");
      });
}

toInt(data) {
  return int.parse(data.toString());
}

getTimeRange(a, b, [bool substring = true]) {
  if (substring) {
    return utcTo12HourFormat(a.toString().substring(11, 16)) +
        " - " +
        utcTo12HourFormat(b.toString().substring(11, 16));
  } else {
    return utcTo12HourFormat(a.toString()) +
        " - " +
        utcTo12HourFormat(b.toString());
  }
}

String getDateInFormat(data) {
  if (data == "") {
    return "Not Available";
  }
  var tempDate = data.toString().substring(0, 10).split("-");
  var date =
      DateTime(toInt(tempDate[0]), toInt(tempDate[1]), toInt(tempDate[2]));
  return formatter.format(date);
}

final DateFormat formatter = DateFormat('EEEE, MMM d  ');
String utcTo12HourFormat(String bigTime) {
  DateTime tempDate = DateFormat("hh:mm").parse(bigTime);
  var dateFormat = DateFormat("h:mm a"); // you can change the format here
  var utcDate = dateFormat.format(tempDate); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
  String createdDate = dateFormat.format(DateTime.parse(localDate));
  return createdDate;
}

errorDialog(context, text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.error,
    text: text,
  );
}

successDialog(context, text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    text: text,
  );
}

warningDialog(context, text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    text: text,
  );
}

infoDialog(context, text) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.info,
    text: text,
  );
}

Future<File> urlToFile(String imageUrl) async {
// generate random number.
  var rng = new Random();
// get temporary directory of device.
  Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
  String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
  File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
  http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
  await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
  return file;
}

Future<String> urlToFilePath(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}
