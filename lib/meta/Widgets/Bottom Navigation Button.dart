import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomButton extends StatefulWidget {
  final String? text;

  final Function()? onPressed;
  const BottomButton({
    Key? key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor, // background
                onPrimary: Colors.white // foreground
                ),
            onPressed: widget.onPressed,
            child: Text(widget.text ?? "Done",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
        ));
  }
}
