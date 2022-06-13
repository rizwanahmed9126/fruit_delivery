import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/chat_list_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class LetsChatScreen extends StatefulWidget {
  LetsChatScreen({Key? key}) : super(key: key);

  @override
  _LetsChatScreenState createState() => _LetsChatScreenState();
}

class _LetsChatScreenState extends State<LetsChatScreen> {
  GlobalKey? key;
  var navigationService = locator<NavigationService>();
  // List chatlist = [
  //   {
  //     'profile-pic': "assets/images/dummy.jpg",
  //     'name': "Sara Johns",
  //     'position': "Manager",
  //   },
  //   {
  //     'profile-pic': "assets/images/dummy1.jpg",
  //     'name': "Simth",
  //     'position': "Admin",
  //   },
  //   {
  //     'profile-pic': "assets/images/dummy4.jpg",
  //     'name': "Jacqueline ",
  //     'position': "Admin",
  //   },
  //   {
  //     'profile-pic': "assets/images/dummy2.jpg",
  //     'name': "Tom Brady",
  //     'position': "Driver",
  //   },
  //   {
  //     'profile-pic': "assets/images/dummy3.jpg",
  //     'name': "Martin David",
  //     'position': "Admin",
  //   },
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();

            return true;
          },
          child: Scaffold(
            appBar: SelectAccount.selectAccount ==
                    SelectAccountEnum.Driver.toString()
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                    ),
                  )
                : AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.fromLTRB(sy(10), sy(0), sy(10), sy(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('ChatHeading'),
                    style: TextStyle(
                      color: Color.fromRGBO(
                        34,
                        36,
                        38,
                        1,
                      ),
                      fontSize: sy(20),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: sy(8),
                  ),
                  // chatlist.length == 0
                  //     ? Expanded(
                  // child: Center(
                  //     child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.5,
                  //         child: Image.asset(
                  //             "assets/images/no-message.png"))),
                  //       )
                  InkWell(
                    onTap: () async {
                      showLoadingAnimation(context);
                      var storageService = locator<StorageService>();
                      await storageService.setData("route", "/letschat-Screen");
                      if (SelectAccount.selectAccount ==
                          SelectAccountEnum.User.toString()) {
                        context.read<ChatProvider>().senderId =
                            context.read<UserProvider>().userData.id!;
                        context.read<ChatProvider>().chatRoomId =
                            context.read<UserProvider>().userData.id!;
                      } else if (SelectAccount.selectAccount ==
                          SelectAccountEnum.Driver.toString()) {
                        context.read<ChatProvider>().senderId =
                            context.read<VendorProvider>().vendorData!.id!;
                        context.read<ChatProvider>().chatRoomId =
                            context.read<VendorProvider>().vendorData!.id!;
                      }
                      context.read<ChatProvider>().receverId = "123";

                      navigationService.closeScreen();
                      // navigationService.navigateTo(ChatScreenRoute);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext ctx) => ChatScreen(
                            memberName: 'Admin',
                            memberProfile:
                                'https://firebasestorage.googleapis.com/v0/b/backyard-bet.appspot.com/o/images%2Fp3.png?alt=media&token=76805497-6a85-4924-90df-8800e58006ad',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: sy(6),
                        bottom: sy(6),
                        left: sx(10),
                        right: sx(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  border: Border.all(
                                    color: Color.fromRGBO(
                                      236,
                                      238,
                                      245,
                                      1,
                                    ),
                                    width: sx(3),
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: sy(18),
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/backyard-bet.appspot.com/o/images%2Fp3.png?alt=media&token=76805497-6a85-4924-90df-8800e58006ad'),
                                ),
                              ),
                              SizedBox(
                                width: sx(25),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Administrator',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: sy(11),
                                    ),
                                  ),
                                  SizedBox(
                                    height: sy(2),
                                  ),
                                  Text(
                                    'Admin',
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                        118,
                                        134,
                                        151,
                                        1,
                                      ),
                                      fontSize: sy(8),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(
                              118,
                              134,
                              151,
                              1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 2,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: SelectAccount.selectAccount ==
                                SelectAccountEnum.User.toString()
                            ? FirebaseFirestore.instance
                                .collection('chats')
                                .where(
                                    'members.${context.read<UserProvider>().userData.id}.id',
                                    isEqualTo: context
                                        .read<UserProvider>()
                                        .userData
                                        .id)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('chats')
                                .where(
                                    'members.${context.read<VendorProvider>().vendorData!.id}.id',
                                    isEqualTo: context
                                        .read<VendorProvider>()
                                        .vendorData!
                                        .id)
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  thickness: 2,
                                  color: Color.fromRGBO(
                                    236,
                                    238,
                                    245,
                                    1,
                                  ),
                                );
                                // return Container();
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> chatMap =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                print(snapshot.data!.docs[index].id);

                                // if (chatMap['lastMessage'] == '') {
                                //   FirebaseFirestore.instance
                                //       .collection('chats')
                                //       .doc(snapshot.data!.docs[index].id)
                                //       .delete();
                                // }

                                // if (chatMap['lastMessage'] == '') {
                                //   FirebaseFirestore.instance
                                //       .collection('chats')
                                //       .doc()
                                //       .delete();
                                // }
                                print(chatMap['members']);
                                return chatMap['lastMessage'] == ''
                                    ? Container()
                                    : ChatWidget(chatMap);
                              },
                            );
                          } else {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child:
                                    Image.asset("assets/images/no-message.png"),
                              ),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


//dummy


// import 'package:flutter/material.dart';
// import 'package:fruit_delivery_flutter/local/app_localization.dart';
// import 'package:fruit_delivery_flutter/widgets/chat_list_widget.dart';
// import 'package:relative_scale/relative_scale.dart';

// class LetsChatScreen extends StatefulWidget {
//   LetsChatScreen({Key? key}) : super(key: key);
//   @override
//   _LetsChatScreenState createState() => _LetsChatScreenState();
// }

// class _LetsChatScreenState extends State<LetsChatScreen> {
//   List chatlist = [
//     {
//       'profile-pic': "assets/images/dummy.jpg",
//       'name': "Sara Johns",
//       'position': "Manager",
//     },
//     {
//       'profile-pic': "assets/images/dummy1.jpg",
//       'name': "Simth",
//       'position': "Admin",
//     },
//     {
//       'profile-pic': "assets/images/dummy4.jpg",
//       'name': "Jacqueline ",
//       'position': "Admin",
//     },
//     {
//       'profile-pic': "assets/images/dummy2.jpg",
//       'name': "Tom Brady",
//       'position': "Driver",
//     },
//     {
//       'profile-pic': "assets/images/dummy3.jpg",
//       'name': "Martin David",
//       'position': "Admin",
//     },
//   ];
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RelativeBuilder(
//       builder: (context, height, width, sy, sx) {
//         return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: Icon(Icons.arrow_back),
          //     color: Colors.black,
          //   ),
          // ),
//           backgroundColor: Colors.white,
//           body: Container(
//             padding: EdgeInsets.fromLTRB(sy(10), sy(0), sy(10), sy(10)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   AppLocalizations.of(context).translate('ChatHeading'),
//                   style: TextStyle(
//                     color: Color.fromRGBO(
//                       34,
//                       36,
//                       38,
//                       1,
//                     ),
//                     fontSize: sy(20),
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 SizedBox(
//                   height: sy(8),
//                 ),
//                 // Expanded(
//                 //   child: Center(
//                 //       child: Container(
//                 //           width: MediaQuery.of(context).size.width * 0.5,
//                 //           child: Image.asset("assets/images/no-message.png"))),
//                 // )
//                 Container(
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: chatlist.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ChatWidget(
//                         chatlist[index],
//                       );
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return Divider(
//                         thickness: 2,
//                         color: Color.fromRGBO(
//                           236,
//                           238,
//                           245,
//                           1,
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
