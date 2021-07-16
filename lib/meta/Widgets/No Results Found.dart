import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  final String? text;
  NoResult({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
            child: Text(
          text ?? "No Results Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )));
  }
}
