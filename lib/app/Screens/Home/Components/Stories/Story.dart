import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';

import '../../../../../meta/Utility/Constants.dart';
import 'StoryView.dart';

class GoFlexeStories extends StatefulWidget {
  final List stories;
  GoFlexeStories({required this.stories});

  @override
  _GoFlexeStoriesState createState() => _GoFlexeStoriesState();
}

class _GoFlexeStoriesState extends State<GoFlexeStories>
    with SingleTickerProviderStateMixin {
  late Animation gap;
  late Animation<double> base;
  late Animation<double> reverse;
  late AnimationController controller;

  /// Init
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 4.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.stories.length,
          itemBuilder: (context, index) {
            return Container(
              width: 80,
              padding: EdgeInsets.only(right: 10, top: 0),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StoryPage(
                          initialPage: index,
                          stories: widget.stories,
                        );
                      },
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    box5,
                    Stack(
                      children: [
                        RotationTransition(
                          turns: base,
                          child: DashedCircle(
                            gapSize: gap.value,
                            dashes: 40,
                            color: primaryColor,
                            child: RotationTransition(
                              turns: reverse,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      widget.stories[index]["thumbnail"]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (index == 0)
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Live",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    box10,
                    Text(
                      widget.stories[index]["name"],
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
