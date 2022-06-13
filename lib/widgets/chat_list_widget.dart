import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/src/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ChatWidget extends StatefulWidget {
  final data;
  ChatWidget(this.data);
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  var member = {};
  var memberProfile = {};
  var navigationService = locator<NavigationService>();

  getMember(Map<String, dynamic> chatMessage, BuildContext context) {
    //getMember detail from chatMessage gorup
    if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<UserProvider>().userData.id) {
          member = value;
        }
      });
    } else if (SelectAccount.selectAccount ==
        SelectAccountEnum.Driver.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    } else {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    }

    print(member);
  }

  Future getChatDetails() async {
    if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
      context.read<ChatProvider>().senderId =
          context.read<UserProvider>().userData.id!;
    } else if (SelectAccount.selectAccount ==
        SelectAccountEnum.Driver.toString()) {
      context.read<ChatProvider>().senderId =
          context.read<VendorProvider>().vendorData!.id!;
    }

    context.read<ChatProvider>().receverId = member['id'];
    await context.read<ChatProvider>().getChatRoomId();
    // if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
    //   await context.read<ChatProvider>().getMessageCount(
    //       context.read<ChatProvider>().chatRoomId,
    //       context.read<UserProvider>().user!.id);
    // } else {
    //   await context.read<ChatProvider>().getMessageCount(
    //       context.read<ChatProvider>().chatRoomId,
    //       context.read<VendorProvider>().vendorData!.id);
    // }
  }

  @override
  void initState() {
    getMember(widget.data, context);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatWidget oldWidget) {
    getMember(widget.data, context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // DateTime messageTime = (widget.data['time'] as Timestamp).toDate();
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return InkWell(
        onTap: () async {
          showLoadingAnimation(context);
          var storageService = locator<StorageService>();
          await storageService.setData("route", "/letschat-Screen");
          await getChatDetails();
          context.read<ChatProvider>().resetUnreadCount(context);
          navigationService.closeScreen();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => ChatScreen(
                memberProfile: member['profile'],
                memberName: member['name'],
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
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                        member['profile'],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sx(25),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: sy(11),
                        ),
                      ),
                      SizedBox(
                        height: sy(2),
                      ),
                      Text(
                        SelectAccount.selectAccount ==
                                SelectAccountEnum.User.toString()
                            ? 'Driver'
                            : 'Customer',
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
              // StreamBuilder<QuerySnapshot>(
              //     stream: SelectAccount.selectAccount ==
              //             SelectAccountEnum.Driver.toString()
              //         ? context.read<ChatProvider>().getMessageCount(
              //             context.read<ChatProvider>().chatRoomId,
              //             context.read<VendorProvider>().vendorData!.id)
              //         : context.read<ChatProvider>().getMessageCount(
              //             context.read<ChatProvider>().chatRoomId,
              //             context.read<UserProvider>().user!.id),
              //     builder: (context, snapshot) {
              //       return Text("${context.read<ChatProvider>().unreadCount}",
              //           style: TextStyle(color: Colors.black));
              //     }),
              int.parse("${member['unreadCount']}") != 0
                  ? Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                      child: Center(
                        child: Text("${member['unreadCount']}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  : Container(),
              // Icon(
              //   Icons.keyboard_arrow_right,
              //   color: Color.fromRGBO(
              //     118,
              //     134,
              //     151,
              //     1,
              //   ),
              // )
            ],
          ),
        ),
      );
    });
  }
}

//dummy

// import 'package:flutter/material.dart';
// import 'package:fruit_delivery_flutter/services/navigation_service.dart';
// import 'package:fruit_delivery_flutter/services/storage_service.dart';
// import 'package:fruit_delivery_flutter/utils/routes.dart';
// import 'package:fruit_delivery_flutter/utils/service_locator.dart';
// import 'package:relative_scale/relative_scale.dart';

// class ChatWidget extends StatefulWidget {
//   final data;
//   ChatWidget(this.data);
//   @override
//   _ChatWidgetState createState() => _ChatWidgetState();
// }

// class _ChatWidgetState extends State<ChatWidget> {
//   var navigationService = locator<NavigationService>();
//   @override
//   Widget build(BuildContext context) {
//     return RelativeBuilder(builder: (context, height, width, sy, sx) {
//       return InkWell(
//         onTap: () async {
//           var storageService = locator<StorageService>();
//           await storageService.setData("route", "/letschat-Screen");
//           navigationService.navigateTo(ChatScreenRoute);
//         },
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: sy(6),
//             bottom: sy(6),
//             left: sx(10),
//             right: sx(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                       border: Border.all(
//                         color: Color.fromRGBO(
//                           236,
//                           238,
//                           245,
//                           1,
//                         ),
//                         width: sx(3),
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       radius: sy(18),
//                       backgroundImage: AssetImage(
//                         widget.data["profile-pic"],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: sx(25),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.data["name"],
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: sy(11),
//                         ),
//                       ),
//                       SizedBox(
//                         height: sy(2),
//                       ),
//                       Text(
//                         widget.data["position"],
//                         style: TextStyle(
//                           color: Color.fromRGBO(
//                             118,
//                             134,
//                             151,
//                             1,
//                           ),
//                           fontSize: sy(8),
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Icon(
//                 Icons.keyboard_arrow_right,
//                 color: Color.fromRGBO(
//                   118,
//                   134,
//                   151,
//                   1,
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
