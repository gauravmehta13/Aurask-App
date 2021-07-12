import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Utility/Constants.dart';

class Loading extends StatelessWidget {
  final color;
  Loading({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitFadingCube(color: color ?? primaryColor),
      ),
    );
  }
}
