import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  NotificationWidgetState createState() => NotificationWidgetState();
}

class NotificationWidgetState extends State<NotificationWidget> {
  List today = [
    {
      'image': 'assets/images/Driver.png',
      'title': 'Hey! Driver is here in your area.',
      'message': 'Driver is reached in your area go and get your fruits',
      'time': '16:27'
    },
    {
      'image': 'assets/images/Driver.png',
      'title': 'Track Driver! He is on his way',
      'message': 'Driver is on way youn can track his trip througout',
      'time': '15:00'
    },
  ];

  List yesterday = [
    {
      'color': Colors.pink.shade50,
      'image': 'assets/images/WelcomeUser.png',
      'title': 'Welcome.',
      'message': 'Congratulation you\'ve successfully created your account',
      'time': '16:27'
    },
    {
      'color': Colors.pink.shade50,
      'image': 'assets/images/WelcomeUser.png',
      'title': 'Account Created',
      'message': 'Your account has been created please complete your profile',
      'time': '16:27'
    },
    {
      'color': Colors.green.shade50,
      'image': 'assets/images/PasswordUpdate.png',
      'title': 'Password Update',
      'message': 'You\'ve successfully update your new password',
      'time': '16:27'
    },
    {
      'color': Colors.green.shade50,
      'image': 'assets/images/AcountCreated.png',
      'title': 'Account Created',
      'message': 'Your account has been created please complete your profile',
      'time': '16:27'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sy(10),
                  ),
                  Text("Today",
                      style: TextStyle(
                          fontSize: sy(10),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey)),
                  SizedBox(
                    height: sy(10),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: today.length,
                      itemBuilder: (_, i) => Container(
                            padding: EdgeInsets.only(bottom: sy(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: sy(30),
                                  width: sx(70),
                                  decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius:
                                          BorderRadius.circular(sy(5))),
                                  child: Image.asset(
                                    today[i]['image'],
                                    height: sy(10),
                                  ),
                                ),
                                SizedBox(
                                  width: sx(15),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(today[i]['title'],
                                        style: TextStyle(
                                            fontSize: sy(10),
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: sy(5),
                                    ),
                                    Text(today[i]['message'],
                                        style: TextStyle(
                                            fontSize: sy(7),
                                            color: Colors.grey)),
                                  ],
                                ),
                                Spacer(),
                                Text(today[i]['time'],
                                    style: TextStyle(
                                        fontSize: sy(7), color: Colors.grey)),
                              ],
                            ),
                          )),
                  SizedBox(
                    height: sy(05),
                  ),
                  Text("Yesterday",
                      style: TextStyle(
                          fontSize: sy(10),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey)),
                  SizedBox(
                    height: sy(10),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: yesterday.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) => Container(
                      padding: EdgeInsets.only(bottom: sy(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: sy(30),
                            width: sx(70),
                            decoration: BoxDecoration(
                                color: yesterday[i]['color'],
                                borderRadius: BorderRadius.circular(sy(5))),
                            child: Image.asset(
                              yesterday[i]['image'],
                              height: sy(10),
                            ),
                          ),
                          SizedBox(
                            width: sx(15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(yesterday[i]['title'],
                                  style: TextStyle(
                                      fontSize: sy(10),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: sy(5),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / sy(1.5),
                                child: Text(yesterday[i]['message'],
                                    style: TextStyle(
                                        fontSize: sy(6), color: Colors.grey)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(yesterday[i]['time'],
                              style: TextStyle(
                                  fontSize: sy(7), color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
