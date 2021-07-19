import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/Screens/Home/BottomNavBar.dart';
import 'core/notifications/importNoti.dart';
import 'core/notifications/notis/ab/abNoti.dart';
import 'core/redux/app_state.dart';
import 'core/redux/reducers.dart';
import 'core/resources/theme/app_theme.dart';
import 'core/resources/theme/theme_notifier.dart';
import 'meta/Utility/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _initialState = AppState(courses: [], seminars: [], coupons: []);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  await Firebase.initializeApp();
  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String? theme = value.getString("Theme");
          primaryColor = Color(value.getInt('color') ?? primaryColor.value);
          if (theme == null || theme == "" || theme == "Light") {
            value.setString("Theme", "Light");
            return ThemeNotifier(ThemeMode.light);
          }
          return ThemeNotifier(
              theme == "Dark" ? ThemeMode.dark : ThemeMode.light);
        },
        child: MyApp(store: _store),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final Store<AppState>? store;
  MyApp({this.store});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Noti noti = AppNoti();
  late bool seen;

  Widget home = BottomNavBar();
  @override
  void initState() {
    super.initState();
    Future(noti.init);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return StoreProvider<AppState>(
      store: widget.store!,
      child: MaterialApp(
          title: 'Freeflix',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: themeNotifier.getThemeMode(),
          home: home),
    );
  }
}
