import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

Future<void> showDailyAtTime() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));

  List dates = List.generate(30, (index) => index);
  final String imgPath = await urlToFilePath(
      'https://raw.githubusercontent.com/gauravmehta13/Aurask-App/master/assets/quizAndWin.jpg',
      'img');
  final String largeIconPath = await urlToFilePath(
      'https://raw.githubusercontent.com/gauravmehta13/Aurask-App/master/android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
      'largeIcon');

  dates.forEach((id) async {
    await scheduleNotification(id, largeIconPath, imgPath);
  });
  print("Notifications Scheduled Successfully");
}

scheduleNotification(int id, iconPath, imgPath) async {
  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(FilePathAndroidBitmap(imgPath),
          largeIcon: FilePathAndroidBitmap(iconPath),
          contentTitle: 'Quiz And Win Live Now',
          htmlFormatContentTitle: true,
          summaryText: '<i>Answer the Questions and win exciting prizes</i>',
          htmlFormatSummaryText: true);
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('big text channel id', 'big text channel name',
          'big text channel description',
          styleInformation: bigPictureStyleInformation);
  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  var today = tz.TZDateTime.now(tz.local);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Quiz And Win Live Now',
      'Answer the Questions and win exciting prizes',
      tz.TZDateTime.local(
        today.year,
        today.month,
        today.day,
        18,
        00,
      ).add(Duration(days: id)),
      platformChannelSpecifics,
      payload: "Quiz",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
