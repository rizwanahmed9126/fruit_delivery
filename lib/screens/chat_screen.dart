import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:provider/src/provider.dart';
import 'package:relative_scale/relative_scale.dart';

import 'package:fruit_delivery_flutter/models/messages.dart';
import 'package:fruit_delivery_flutter/models/user.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/chat_message_tile.dart';

class ChatScreen extends StatefulWidget {
  String? memberName;
  String? memberProfile;
  ChatScreen({
    Key? key,
    this.memberName,
    this.memberProfile,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var navigationService = locator<NavigationService>();
  var utilService = locator<UtilService>();
  final double minValue = 8.0;
  final double iconSize = 28.0;
  String imgURL = '';
  FocusNode? _focusNode;
  TextEditingController _txtController = TextEditingController();
  // ignore: unused_field
  final GlobalKey _formKey = GlobalKey();

  bool isCurrentUserTyping = false;
  ScrollController? _scrollController;

  String message = '';

  var isLoading = false;

  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    print(
        "chat room on chat screen ${context.read<ChatProvider>().chatRoomId}");
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      print('Something happened');
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    // inChat = false;

    super.dispose();
  }

  void onTextFieldTapped() {}
  void _onMessageChanged(String value) {
    setState(() {
      message = value;
      if (value.trim().isEmpty) {
        isCurrentUserTyping = false;
        return;
      } else {
        isCurrentUserTyping = true;
      }
    });
  }

  // ignore: unused_element
  void _like() {}
  // void _sendMessage() {
  //   // setState(() {
  //   //   myMessages.insert(
  //   //       0, (Message(messageBody: message, senderId: currentUser.userId)));
  //   //   message = '';
  //   //   _txtController.text = '';
  //   // });
  //   _scrollToLast();
  // }

  void _scrollToLast() {
    _scrollController!.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return WillPopScope(
        onWillPop: () async {
          // inChat = false;
          await context.read<ChatProvider>().resetUnreadCount(context);

          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: AppBar(
              backgroundColor: Colors.white,
              actions: [
                InkWell(
                  onTap: () async {
                    var storageService = locator<StorageService>();
                    await storageService.setData("route", "/chat-Screen");
                    navigationService.navigateTo(NotificationScreenRoute);
                  },
                  child: Image.asset(
                    'assets/images/notification.png',
                    scale: 2.5,
                    // color: Colors.white,
                  ),
                ),
              ],

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
                      // // navigationService.navigateTo(data);
                      // inChat = false;
                      // showLoadingAnimation(context);
                      await context
                          .read<ChatProvider>()
                          .resetUnreadCount(context);
                      navigationService.closeScreen();
                      // navigationService.closeScreen();
                      // navigationService.navigateTo(MainDashboardScreenRoute);
                      // FocusScope.of(context).unfocus();
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
          body: Container(
            decoration: BoxDecoration(boxShadow: []),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: sx(18),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: sy(16),
                      // backgroundImage: AssetImage('assets/images/dummy1.jpg'),
                      backgroundImage: NetworkImage(widget.memberProfile!),
                    ),
                    SizedBox(
                      width: sx(22),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.memberName!}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   "California",
                        //   style: TextStyle(color: Colors.black),
                        // ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        onPressed: () => null)
                  ],
                ),
                widget.memberName == 'Admin'
                    ? Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('supportChats')
                                .doc(
                                  SelectAccount.selectAccount ==
                                          SelectAccountEnum.User.toString()
                                      ? context.read<UserProvider>().userData.id
                                      : context
                                          .read<VendorProvider>()
                                          .vendorData!
                                          .id,
                                )
                                .collection('conversation')
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    padding: EdgeInsets.symmetric(
                                        vertical: minValue * 2,
                                        horizontal: minValue),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      // final Message message = myMessages[index];
                                      return MyMessageChatTile(
                                        messageData: snapshot.data!.docs[index]
                                            .data() as Map<String, dynamic>,
                                        isCurrentUser:
                                            SelectAccount.selectAccount ==
                                                    SelectAccountEnum.User
                                                        .toString()
                                                ? data['senderId'] ==
                                                    context
                                                        .read<UserProvider>()
                                                        .userData
                                                        .id
                                                : data['senderId'] ==
                                                    context
                                                        .read<VendorProvider>()
                                                        .vendorData!
                                                        .id,
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Text("No Messages"),
                                );
                              }
                            }),
                      )
                    : Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('chats')
                                .doc(context.read<ChatProvider>().chatRoomId)
                                .collection('conversation')
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    padding: EdgeInsets.symmetric(
                                        vertical: minValue * 2,
                                        horizontal: minValue),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      // final Message message = myMessages[index];
                                      return MyMessageChatTile(
                                        messageData: snapshot.data!.docs[index]
                                            .data() as Map<String, dynamic>,
                                        isCurrentUser:
                                            SelectAccount.selectAccount ==
                                                    SelectAccountEnum.User
                                                        .toString()
                                                ? data['senderId'] ==
                                                    context
                                                        .read<UserProvider>()
                                                        .userData
                                                        .id
                                                : data['senderId'] ==
                                                    context
                                                        .read<VendorProvider>()
                                                        .vendorData!
                                                        .id,
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Text("No Messages"),
                                );
                              }
                            }),
                      ),
                if (imgURL != '')
                  Column(
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Stack(
                            children: [
                              Container(
                                child: Image.file(
                                  File(imgURL),
                                  height: 100,
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {
                                    imgURL = '';

                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 30,
                              blurRadius: 15,
                              offset:
                                  Offset(4, 4), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      _buildBottomSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomSection() {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: sy(35),
              margin: EdgeInsets.all(minValue),
              padding: EdgeInsets.symmetric(horizontal: minValue),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2.0, color: Colors.grey.shade600),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 0,
                  //     right: 5,
                  //     top: 8,
                  //     bottom: 8,
                  //   ),
                  //   child: Icon(
                  //     Icons.insert_emoticon,
                  //     size: iconSize,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: minValue,
                  // ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        textInputAction: TextInputAction.newline,
                        focusNode: _focusNode,
                        controller: _txtController,
                        onChanged: _onMessageChanged,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type your message"),
                        autofocus: false,
                        onTap: () => onTextFieldTapped(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/Attachment.png', scale: 3),
                    onPressed: () async {
                      imgURL = await utilService.browseImageForChat();

                      setState(() {});

                      print("img: $imgURL");
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sy(5), bottom: sy(5)),
                    child: VerticalDivider(
                      width: 2,
                    ),
                  ),
                  // isCurrentUserTyping
                  //     ? Container()
                  //     :
                  IconButton(
                    icon: Image.asset(
                      'assets/images/Send.png',
                      scale: 3,
                      color: Color.fromRGBO(
                        63,
                        190,
                        144,
                        1,
                      ),
                    ),
                    onPressed: () async {
                      print(imgURL);
                      if (_txtController.text.isEmpty && imgURL == '') {
                        return null;
                      } else {
                        _txtController.text = '';
                        if (widget.memberName == 'Admin') {
                          context.read<ChatProvider>().sendSupportMessage(
                                SelectAccount.selectAccount ==
                                        SelectAccountEnum.User.toString()
                                    ? context.read<UserProvider>().userData.id
                                    : context
                                        .read<VendorProvider>()
                                        .vendorData!
                                        .id,
                                message,
                              );
                        } else {
                          if (imgURL != '') {
                            showLoadingAnimation(context);
                            String imageURL =
                                await utilService.sendImageForChat(imgURL);
                            await context.read<ChatProvider>().onSendMedia(
                                  imageURL,
                                  context,
                                  message: message,
                                );
                            message = "";
                            setState(() {
                              imgURL = '';
                            });
                            imageURL = '';
                          } else {
                            await context
                                .read<ChatProvider>()
                                .sendMessage(message);
                          }
                        }

                        var count = context.read<ChatProvider>().getUnreadCount;
                        await context
                            .read<ChatProvider>()
                            .updateUnreadCount(count, message);

                        _scrollToLast();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: minValue),
          //   child: FloatingActionButton(
          //     onPressed: () => isCurrentUserTyping ? _sendMessage() : _like(),
          //     child: Icon(isCurrentUserTyping ? Icons.send : Icons.thumb_up),
          //   ),
          // ),
        ],
      );
    });
  }

///////////////////////////////////////////////

  // Widget _buildBottomSection() {
  //   final double minValue = 8.0;
  //   final double iconSize = 25.0;
  //   return Column(children: <Widget>[
  //     if (showbox)
  //       Column(
  //         children: <Widget>[
  //           Divider(),
  //           SizedBox(height: 5),
  //           Row(
  //             children: <Widget>[
  //               Stack(
  //                 overflow: Overflow.visible,
  //                 alignment: Alignment.topLeft,
  //                 children: <Widget>[
  //                   isLoadingProgress
  //                       ? Padding(
  //                           padding: locale == "en"
  //                               ? EdgeInsets.only(left: 15.0)
  //                               : EdgeInsets.only(right: 15.0),
  //                           child: Center(child:  Platform.isIOS?

  //                       : Padding(
  //                           padding: locale == "en"
  //                               ? EdgeInsets.only(left: 15.0)
  //                               : EdgeInsets.only(right: 15.0),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             child: mediaType == 'file'
  //                                 ? Image.asset(
  //                                     'assets/images/file.png',
  //                                     width: ScreenUtil().setWidth(200),
  //                                     height: ScreenUtil().setHeight(200),
  //                                     fit: BoxFit.cover,
  //                                   )
  //                                 : Image.network(
  //                                     mediaUrl,
  //                                     width: ScreenUtil().setWidth(200),
  //                                     height: ScreenUtil().setHeight(200),
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                           ),
  //                         ),
  //                   if (!isLoadingProgress)
  //                     Positioned(
  //                         //left: 10,
  //                         top: -10,
  //                         right: locale == "en" ? -10 : 10,
  //                         child: GestureDetector(
  //                             onTap: () {
  //                               setState(() {
  //                                 fileAttached = null;
  //                                 mediaUrl = '';
  //                                 isCurrentUserTyping = false;
  //                                 showbox = false;
  //                               });
  //                             },
  //                             child: Container(
  //                                 child: Image.asset(
  //                                     'assets/images/cancel-icon.png',
  //                                     scale: 4))))
  //                   // Center(
  //                   //   child:  Platform.isIOS?
  // CupertinoActivityIndicator():
  //  CircularProgressIndicator(),,
  //                   // )
  //                 ],
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Container(
  //             height: ScreenUtil().setHeight(138),
  //             margin: EdgeInsets.all(minValue),
  //             padding: EdgeInsets.symmetric(horizontal: minValue),
  //             decoration: BoxDecoration(
  //                 boxShadow: [
  //                   new BoxShadow(
  //                     color: Colors.grey,
  //                     blurRadius: 0.5,
  //                   ),
  //                 ],
  //                 color: Colors.white,
  //                 borderRadius:
  //                     BorderRadius.all(Radius.circular(minValue * 4))),
  //             child: Row(
  //               children: <Widget>[
  //                 SizedBox(
  //                   width: minValue,
  //                 ),
  //                 Expanded(
  //                   child: TextField(
  //                     focusNode: _focusNode,
  //                     keyboardType: TextInputType.multiline,
  //                     maxLines: null,
  //                     controller: _txtController,
  //                     onChanged: _onMessageChanged,
  //                     decoration: InputDecoration(
  //                         contentPadding: locale == "en"
  //                             ? EdgeInsets.all(13.0)
  //                             : EdgeInsets.all(5.0),
  //                         border: InputBorder.none,
  //                         hintText: AppLocalizations.of(context)
  //                             .translate('ChatScreenTextMessage')),
  //                     //  "Type your message"
  //                     autofocus: false,
  //                     onTap: () => onTextFieldTapped(),
  //                   ),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     _settingModalBottomSheet(
  //                       context,
  //                     );
  //                   },
  //                   child: Icon(
  //                     Icons.attach_file,
  //                     size: iconSize,
  //                   ),
  //                 ),
  //                 SizedBox(width: 5),
  //                 // GestureDetector(
  //                 //   onTap: () {},
  //                 //   child: Icon(
  //                 //     Icons.gif,
  //                 //     size: iconSize,
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           EdgeInsets.only(right: minValue),
  //           child: SizedBox(
  //             width: ScreenUtil().setHeight(120),
  //             child: FloatingActionButton(
  //               backgroundColor: Theme.of(context).backgroundColor,
  //               heroTag: null,
  //               onPressed: () async {
  //                 // if (_txtController.text == "" &&
  //                 //     (mediaUrl == "" || mediaUrl == null)) {
  //                 //   return;
  //                 // } else {
  //                 //   setState(() {
  //                 //     isCurrentUserTyping = false;
  //                 //     // isLoadingProgress = false;
  //                 //     showbox = false;
  //                 //   });
  //                 //   mess.Message temp = mess.Message();
  //                 //   temp.id = DateTime.now().millisecondsSinceEpoch.toString();
  //                 //   // var a = FieldValue.serverTimestamp();
  //                 //   // var b = DateTime.parse(a);
  //                 //   var a = await NTP.now();
  //                 //   var b;
  //                 //   Future.delayed(Duration(milliseconds: 200));
  //                 //   if (a != null)
  //                 //     b = DateTime.parse(a.toString()).millisecondsSinceEpoch;
  //                 //   temp.createdOnDate = b;
  //                 //   if (mediaUrl != null)
  //                 //     temp.messageText = mediaUrl.contains(
  //                 //                 'https://firebasestorage.googleapis.com') ||
  //                 //             mediaUrl == null
  //                 //         ? ""
  //                 //         : _txtController.text;
  //                 //   else {
  //                 //     temp.messageText = _txtController.text;
  //                 //   }
  //                 //   temp.senderId = user.id;
  //                 //   temp.messageMediaUrl = temp.messageMediaType = mediaType;
  //                 //   temp.messageMediaUrl = mediaUrl;
  //                 //   _txtController.text = "";
  //                 //   mediaType = "";
  //                 //   mediaUrl = "";
  //                 //   await firebaseService.sendMessage(currentChat.id, temp);
  //                 //   isLoadingProgress = false;

  //                 //   _scrollToLast();
  //                 // }
  //               },
  //               child: isLoadingProgress
  //                   ? Icon(
  //                       Icons.cancel,
  //                       size: ScreenUtil().setSp(70),
  //                     )
  //                   : Icon(
  //                       Icons.send,
  //                       size: ScreenUtil().setSp(70),
  //                     ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     SizedBox(height: 20),
  //   ]);
  // }
}
