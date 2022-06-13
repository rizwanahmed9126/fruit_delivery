import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/notification_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var navigationService = locator<NavigationService>();
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: AppBar(
              backgroundColor: Colors.white,
              // actions: [
              //   GestureDetector(
              //     onTap: () {
              //       navigationService.navigateTo(NotificationScreenRoute);
              //     },
              //     child: Image.asset(
              //       'assets/images/notification.png',
              //       scale: 2.5,
              //       // color: Colors.white,
              //     ),
              //   ),
              // ],

              leading: Builder(
                builder: (context) => IconButton(
                    icon: Image.asset(
                      'assets/images/ArrowBack.png',
                      scale: 2.5,
                      // color: Colors.white,
                    ),
                    onPressed: () async {
                      // var storageService, data;
                      // storageService = locator<StorageService>();
                      // data = await storageService.getData("route");
                      // navigationService.navigateTo(data);
                      navigationService.closeScreen();
                    }),
              ), // leading: Text('abc'),

              centerTitle: true,

              title: Image.asset(
                'assets/images/logoleaf.png',
                scale: 14,
                // color: Colors.white,
              ),
              bottomOpacity: 0.0,
              // backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate('DrawerNotification'),
                      // "Notifications ",
                      style: TextStyle(
                          fontSize: sy(16), fontWeight: FontWeight.w700),
                    ),
                    // Container(
                    //   color: Colors.grey,
                    //   width: sx(10),
                    //   height: sy(1),
                    // ),
                    // Text(
                    //   "0",
                    //   style: TextStyle(
                    //       fontSize: sy(14),
                    //       color: Colors.grey,
                    //       fontWeight: FontWeight.w700),
                    // ),
                  ],
                ),
                StreamBuilder(
                    stream: firestore.collection("notificationHistory").where("recipient",isEqualTo:
                    Provider.of<UserProvider>(context,listen: false).user==null?
                    Provider.of<VendorProvider>(context,listen: false).vendorData!.id:
                    Provider.of<UserProvider>(context,listen: false).user!.id
                    ) .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                      if(!snapshot.hasData){
                        return Column(
                          children: [
                            SizedBox(height: height*0.2,),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                      if(snapshot.data!.docs.isEmpty){
                        return Column(
                          children: [
                            SizedBox(height: height*0.2,),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Image.asset(
                                    "assets/images/no-notification.png")
                            ),

                          ],
                        );
                      }
                      return Expanded(
                        child: ListView(
                            children: snapshot.data!.docs.map((document)
                            {

                              return Column(
                                children: [
                                  notificationTile(document["title"],document["message"],document["createdOnDate"]),
                                  //SizedBox(height: 10,)
                                ],
                              );
                            }).toList()
                        ),
                      );
                    }
                )

                // Expanded(
                //     child: Center(
                //         child: Container(
                //             width: MediaQuery.of(context).size.width * 0.5,
                //             child: Image.asset(
                //                 "assets/images/no-notification.png")
                //         )
                //     )
                //     //  NotificationWidget()
                //
                //     ),
              ],
            ),
          ));
    });
  }

  Widget notificationTile(String title,String desc,int timestamp){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(
                  color:Colors.grey[200], //Color.fromRGBO(63, 190, 144, 1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications,size: 15,),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(timestamp))}',style: TextStyle(color: Colors.grey,fontSize: 10),),
                  SizedBox(height: 5,),
                  Text('$title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: 3,),
                  Text('$desc',style: TextStyle(fontSize: 13,color: Colors.grey),),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
