import 'package:flutter/material.dart';

class BottomButton extends StatefulWidget {
  final String? text;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  const BottomButton({Key? key, this.onPressed, this.text, this.padding})
      : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ?? EdgeInsets.fromLTRB(0, 1, 0, 0),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFf9a825), // background
              onPrimary: Colors.black, // foreground
            ),
            onPressed: widget.onPressed,
            child: Text(
              widget.text ?? "Done",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
  }
}
