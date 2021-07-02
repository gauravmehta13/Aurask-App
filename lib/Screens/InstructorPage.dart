import 'package:aurask/Constants.dart';
import 'package:flutter/material.dart';

class InstructorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, elevation: 0),
      body: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 90,
                color: primaryColor,
              ),
              Positioned(
                bottom: -60.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 63,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://media-exp3.licdn.com/dms/image/C5603AQGacJ-P9gTj7w/profile-displayphoto-shrink_400_400/0/1517799815988?e=1630540800&v=beta&t=8G_NtmxHv0FI0hIcXO5W4XJcVnVFJ8QG1rBXPLV2f8E"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Vinay Yadav',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
            subtitle: Center(
                child: Text(
              "Software Development Manager\nat Amazon",
              textAlign: TextAlign.center,
            )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(
                        "https://image.flaticon.com/icons/png/128/3135/3135755.png",
                        height: 30,
                      ),
                      box10,
                      Text(
                        "Total Students",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      box5,
                      Text(
                        "23,594",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(
                        "https://image.flaticon.com/icons/png/128/2665/2665038.png",
                        height: 30,
                      ),
                      box10,
                      Text(
                        "Reviews",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      box5,
                      Text(
                        "3,532",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(
                        "https://image.flaticon.com/icons/png/128/1484/1484560.png",
                        height: 30,
                      ),
                      box10,
                      Text(
                        "Ratings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      box5,
                      Text(
                        "4.8",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          ListTile(
            subtitle: Text(
                "Vinay Yadav is Founder of DeepLearning.AI, General Partner at AI Fund, Chairman and Co-Founder of Coursera, and an Adjunct Professor at Stanford University. As a pioneer both in machine learning and online education, Dr. Ng has changed countless lives through his work in AI, authoring or co-authoring over 100 research papers in machine learning, robotics, and related fields. Previously, he was chief scientist at Baidu, the founding lead of the Google Brain team, and the co-founder of Coursera – the world's largest MOOC platform. Dr. Ng now focuses his time primarily on his entrepreneurial ventures, looking for the best ways to accelerate responsible AI practices in the larger global economy.",
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 1)),
          ),
        ],
      ),
    );
  }
}
