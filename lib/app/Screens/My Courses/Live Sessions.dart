import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../../../meta/Widgets/No%20Results%20Found.dart';
import '../Live%20Session/SessionTabs.dart';

class LiveSessions extends StatelessWidget {
  final List liveSessions;
  LiveSessions({required this.liveSessions});
  @override
  Widget build(BuildContext context) {
    return liveSessions.length == 0
        ? NoResult(
            text: "No Live Sessions Available",
          )
        : ListView.builder(
            itemCount: liveSessions.length,
            padding: EdgeInsets.only(top: 0, bottom: 8),
            itemBuilder: (context, index) {
              Map session = liveSessions[index];
              return TicketView(session: session);
            });
  }
}

class TicketView extends StatelessWidget {
  final session;
  TicketView({this.session});

  @override
  Widget build(BuildContext context) {
    final meetData = session["meetData"];
    final data = session["data"];
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            FadeRoute(
                page: SessionTabs(
              course: session,
            )));
        // await launch(
        //     "https://calendar.google.com/calendar/u/0/r/eventedit?dates=20210226T033000/20210226T040000&ctz=Asia/Calcutta&location&text=Blawsome:+A+Crystal+Alchemy+Healing+Meditation&details=Parth+Pitroda");
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data["name"] + " " + data["type"],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        getDateInFormat(meetData["startTime"]),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        getTimeRange(
                            meetData["startTime"], meetData["endTime"]),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data["mode"],
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            data["venue"],
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: primaryColor.withOpacity(0.2),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Flex(
                            children: List.generate(
                                (constraints.constrainWidth() / 10).floor(),
                                (index) => SizedBox(
                                      height: 1,
                                      width: 5,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade400),
                                      ),
                                    )),
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                children: <Widget>[
                  Text(data["instructor"]["title"],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  Expanded(
                      child: Text("??? ${data["price"]}",
                          textAlign: TextAlign.end,
                          style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
