import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../meta/Utility/Constants.dart';

class Resources extends StatelessWidget {
  final course;
  const Resources({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Resources",
                style: GoogleFonts.montserrat(
                    fontSize: 17, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 10,
                        thickness: 1,
                      ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        "Session ${index + 1} Lecture Notes",
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.read_more,
                            color: primaryColor,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
