import 'package:flutter/material.dart';

import '../../../meta/Utility/Constants.dart';

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
                "Vinay Yadav leverages	16	years	global	business	experience to	provide	value	for clients	with	informed	and independent perspectives	on product development with technology strategies.  Acknowledged as	an engaging	and	energetic leader, clients	have	engaged	Vinay	as	Speaker, Innovator, Entrepreneur and Influencer at	over	100 customer in	more than 20 cities both in India and United states.\n\nAs a speaker, Vinay has groomed thousands of coporate engineers, managers and leaders in product design thinking, architecture mind set and building customer focused business for clients Bank Of America, Wells Fargo, JP Morgan Chase and Ericsson.\n\nAs an innovator he has build 5 yr architecture for Alexa which was instrumental in launching Hindi language in India. \n\nAs an entrepreneur, he is running three technology startups. In past have executed two startups in Food chain and in service domain. Last startup was successfully acquired by Virtusa.\n\nAs an Influencer he has transformed BPM consulting by setting Center of Excellence for clients such as American Express, Bank of New York Mellon, BnP Paribas and Orange-France.",
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 1)),
          ),
        ],
      ),
    );
  }
}
