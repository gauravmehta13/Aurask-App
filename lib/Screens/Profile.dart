import 'package:aurask/Screens/Gamification/ReferAndEarn.dart';
import 'package:aurask/Widgets/Fade%20Route.dart';
import 'package:aurask/auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
          comingSoon(context);
        },
      ),
      ProfilePage(
        title: "Feedback",
        icon: Icons.feedback,
        onTap: () {
          comingSoon(context);
        },
      ),
      ProfilePage(
        title: "Rewards",
        icon: Icons.celebration,
        onTap: () {
          Navigator.push(context, FadeRoute(page: ReferAndEarn()));
        },
      ),
      ProfilePage(
        title: "Logout",
        icon: Icons.logout,
        onTap: () {
          _auth.signOut().then((value) => Navigator.pushReplacement(
                context,
                FadeRoute(page: LoginScreen()),
              ));
        },
      )
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(_auth.currentUser!.photoURL!),
          ),
          box20,
          Text(
            _auth.currentUser!.displayName!,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          box10,
          Text(
            _auth.currentUser!.email!,
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
    );
  }

  navigateTo(page, context) {
    Navigator.push(context, FadeRoute(page: page));
  }
}
