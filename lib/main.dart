import 'package:aurask/core/resources/login_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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

//! Backend
//TODO: Meet Scheduling Lambda
//TODO: Changes in Payment API and purchase course API
//TODO: User profile API (will show aurask money and rewards)
//TODO: Proper template for Email sent to users after purchase
//TODO: Changing Email from 269mehta to Aurask
//TODO: Adding Email in GoFlexe Order process as well

//! Frontend
//TODO: Add Proper images on HomePage Carousel
//? Done: Add share course button with course image from app
//? Done: Add About Us Page and Contact Us Page
//? Done: Add Gamification features
//? Done: Users can purchase courses from Aurask money too

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

  late String _linkMessage;
  bool _isCreatingLink = false;
  String _testString =
      "To test: long press link and then copy and click from a non-browser "
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      "is properly setup. Look at firebase_dynamic_links/README.md for more "
      "details.";

  @override
  void initState() {
    super.initState();
    Future(noti.init);
    initDynamicLinks();
    createDynamicLink(true);
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    final Uri? deepLink = data?.link;
    if (data != null) {
      Navigator.pushNamed(context, "/tnc");
    }
    print(deepLink);
    print("deepLink");

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        //Navigator.pushNamed(context, "/tnc");
        Navigator.pushNamed(context, deepLink.path);
      }
      print(deepLink);
      print("deepLink");
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  Future<void> createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://flutterdevs.page.link',
      link: Uri.parse('https://www.google.com'),
      androidParameters: AndroidParameters(
        packageName: 'io.flutter.plugins.firebasedynamiclinksexample',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    //! Works with modular
    //  Navigator.of(context)
    //         .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
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
