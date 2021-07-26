import 'package:aurask/core/resources/login_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/Routing/router.dart';
import 'core/notifications/importNoti.dart';
import 'core/notifications/notis/ab/abNoti.dart';
import 'core/redux/app_state.dart';
import 'core/redux/reducers.dart';
import 'core/resources/theme/app_theme.dart';
import 'core/resources/theme/theme_notifier.dart';
import 'meta/Utility/Constants.dart';

//TODO: Backend
//TODO: Meet Scheduling Lambda
//TODO: Changes in Payment API and purchase course API
//TODO: User profile API (will show aurask money and rewards)
//TODO: Proper template for Email sent to users after purchase
//TODO: Changing Email from 269mehta to Aurask
//TODO: Adding Email in GoFlexe Order process as well

//TODO: Frontend
//TODO: Add share course button with course image from app
//TODO: Add About Us Page and Contact Us Page
//TODO: Add Proper images on HomePage Carousel
//TODO: Add Gamification features
//TODO: Give Aurask Money and users can purchase courses from this money too

//? Vinay Sir
//TODO: Add Curated Videos from Instructor on Some Topics( like scalar)
//TODO: Add proper syllabus for Free Session and Live Session

String home = "/";
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
          var seen = (value.getBool('seen') ?? false);
          home = seen ? "/" : "/welcome";
          String? theme = value.getString("Theme");
          primaryColor = Color(value.getInt('color') ?? primaryColor.value);
          if (theme == null || theme == "" || theme == "Light") {
            value.setString("Theme", "Light");
            return ThemeNotifier(ThemeMode.light);
          }
          return ThemeNotifier(
              theme == "Dark" ? ThemeMode.dark : ThemeMode.light);
        },
        child: ModularApp(module: AppModule(), child: MyApp(store: _store)),
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
  @override
  void initState() {
    super.initState();
    Future(noti.init);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        // StreamProvider(
        //   create: (context) => context.read<AuthenticationProvider>().authState,
        //   initialData: FirebaseAuth.instance,
        // )
      ],
      child: StoreProvider<AppState>(
        store: widget.store!,
        child: MaterialApp(
          title: 'Aurask',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: themeNotifier.getThemeMode(),
          initialRoute: home,
        ).modular(),
      ),
    );
  }
}
