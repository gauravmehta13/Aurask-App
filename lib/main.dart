import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app/Screens/Home/BottomNavBar.dart';
import 'core/notifications/importNoti.dart';
import 'core/notifications/notis/ab/abNoti.dart';
import 'core/redux/app_state.dart';
import 'core/redux/reducers.dart';
import 'meta/Utility/Constants.dart';
import 'meta/Utility/responsive.dart';
import 'test.dart';

Future<void> main() async {
  final _initialState = AppState(courses: []);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  final Store<AppState>? store;
  MyApp({this.store});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Noti noti = AppNoti();
  late bool seen;
  bool loading = false;
  Widget home = BottomNavBar();
  @override
  void initState() {
    super.initState();
    Future(noti.init);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(child: Center(child: CircularProgressIndicator()))
        : StoreProvider<AppState>(
            store: widget.store!,
            child: MaterialApp(
                title: 'Aurask',
                theme: themeData(context),
                debugShowCheckedModeBanner: false,
                home: home));
  }
}
