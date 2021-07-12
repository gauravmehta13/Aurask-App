import '../../../../../meta/Utility/Constants.dart';
import '../../../../../meta/Widgets/Loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view/story_page_view.dart';

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}

class StoryPage extends StatelessWidget {
  final initialPage;
  final stories;
  StoryPage({Key? key, this.initialPage, this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            final user = stories[pageIndex];
            final story = user["stories"][storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: story,
                    fit: BoxFit.contain,
                    colorBlendMode: BlendMode.modulate,
                    placeholder: (context, url) => Loading(
                      color: secondaryColor,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44, left: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user["thumbnail"]),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        user["name"] ?? "",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 20,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          user["text"] ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          initialPage: initialPage ?? 0,
          initialStoryIndex: (pageIndex) {
            // if (pageIndex == 0) {
            //   return 1;
            // }
            return 0;
          },
          pageLength: stories.length,
          storyLength: (int pageIndex) {
            return stories[pageIndex]["stories"].length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
