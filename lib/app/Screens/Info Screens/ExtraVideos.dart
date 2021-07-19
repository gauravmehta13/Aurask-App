import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExtraVideos extends StatefulWidget {
  final List videos;
  const ExtraVideos({Key? key, required this.videos}) : super(key: key);

  @override
  _ExtraVideosState createState() => _ExtraVideosState();
}

class _ExtraVideosState extends State<ExtraVideos> {
  List<YoutubePlayerController> controller = [];

  @override
  void initState() {
    super.initState();
    initialiseVideos(widget.videos);
  }

  initialiseVideos(List videos) {
    print(videos);
    for (var i = 0; i < videos.length; i++) {
      controller.add(YoutubePlayerController(
        initialVideoId: videos[i],
        params: YoutubePlayerParams(
          autoPlay: false,
          showVideoAnnotations: true,
          desktopMode: kIsWeb,
          strictRelatedVideos: true,
          showControls: true,
          showFullscreenButton: true,
        ),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  YoutubePlayerIFrame(
                    gestureRecognizers: {},
                    controller: controller[index],
                  ),
                  Divider(),
                ],
              );
            }));
  }
}
