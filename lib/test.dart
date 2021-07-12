import 'package:flutter/material.dart';

import 'app/Screens/Home/BottomNavBar.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
          ),
          Expanded(
              child: MaterialApp(
                  title: 'Aurask',
                  debugShowCheckedModeBanner: false,
                  home: BottomNavBar()))
        ],
      ),
    ));
  }
}
