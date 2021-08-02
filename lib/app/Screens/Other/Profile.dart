import 'package:aurask/app/Screens/Gamification/Rewards.dart';
import 'package:aurask/app/Screens/Other/Misc/Contact%20Us.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../meta/Utility/Constants.dart';
import '../../../meta/Utility/Fade%20Route.dart';
import '../Gamification/ReferAndEarn.dart';
import '../Home/BottomNavBar.dart';
import 'Settings.dart';

class ProfilePage extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final IconData? icon;

  const ProfilePage({
    Key? key,
    this.title,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProfilePage> categories = [
      ProfilePage(
        title: "Certificates",
        icon: FontAwesomeIcons.certificate,
        onTap: () {
          comingSoon(context);
        },
      ),
      ProfilePage(
        title: "Edit Profile",
        icon: Icons.edit,
        onTap: () {
          comingSoon(context);
        },
      ),
      ProfilePage(
        title: "Support",
        icon: Icons.support_agent,
        onTap: () {
          Navigator.push(context, FadeRoute(page: ContactUs()));
        },
      ),
      ProfilePage(
        title: "Feedback",
        icon: Icons.feedback,
        onTap: () async {
          await launch(
              "https://play.google.com/store/apps/details?id=com.aurask");
        },
      ),
      ProfilePage(
        title: "Rewards",
        icon: Icons.celebration,
        onTap: () {
          Navigator.push(context, FadeRoute(page: Rewards()));
        },
      ),
      ProfilePage(
        title: "Logout",
        icon: Icons.logout,
        onTap: () {
          auth.signOut().then((value) => Navigator.push(
                context,
                FadeRoute(page: BottomNavBar()),
              ));
        },
      )
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.settings, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, FadeRoute(page: SettingsScreen()));
                })
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.2),
                radius: 35,
                backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
              ),
              box20,
              Text(
                auth.currentUser!.displayName!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              box10,
              Text(
                auth.currentUser!.email!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: new ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                        dense: true,
                        onTap: categories[i].onTap,
                        leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 20,
                          child: Icon(categories[i].icon, color: Colors.white),
                        ),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            categories[i].title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ));
  }

  navigateTo(page, context) {
    Navigator.push(context, FadeRoute(page: page));
  }
}
