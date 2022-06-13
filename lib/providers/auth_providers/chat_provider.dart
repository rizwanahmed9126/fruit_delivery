import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';

import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/src/provider.dart';

class ChatProvider with ChangeNotifier {
  var utilService = locator<UtilService>();
  String chatRoomId = " ";
  String senderId = '';
  int unreadCount = 0;
  String receverId = '';

  get getUnreadCount {
    return this.unreadCount;
  }

  updateUnreadCount(int count, String message) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .update({
      'lastMessage': message,
      'time': DateTime.now(),
      'members.$senderId.time': DateTime.now(),
      'members.$receverId.unreadCount': 0,
      'members.$senderId.unreadCount': count++,
    });
  }

  onSendMedia(String url, BuildContext context, {String message = ''}) async {
    Map<String, dynamic> chatData = {
      "senderId": senderId,
      "imageUrl": url,
      "message": message,
      "type": "image",
      "time": DateTime.now()
    };

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('conversation')
        .add(chatData)
        .then((value) {
      Navigator.pop(context);
    });

    if (SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()) {
      updateLastSeen(context.read<VendorProvider>().vendorData!.id);
    } else {
      updateLastSeen(context.read<UserProvider>().userData.id);
    }
  }

  resetUnreadCount(BuildContext context) async {
    unreadCount = 0;
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .update({
      'time': DateTime.now(),
      'members.$senderId.time': DateTime.now(),
      'members.$receverId.unreadCount': 0,
      'members.$senderId.unreadCount': 0,
    });
    if (SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()) {
      updateLastSeen(context.read<VendorProvider>().vendorData!.id);
    } else {
      updateLastSeen(context.read<UserProvider>().userData.id);
    }
  }

  sendMessage(String message) async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('conversation')
        .add({
      'message': message,
      'senderId': senderId,
      'type': 'text',
      'time': DateTime.now(),
    });

    await getMessageCount(chatRoomId, receverId);

    updateLastSeen(senderId);
  }

// FirebaseFirestore.instance
//         .collection('chats')
//         .where('lastMessage', isEqualTo: "");
//         .delete()
//         .whenComplete(() {
//       print("DELETE DONE::");
//     });
  Future getChatRoomId() async {
    chatRoomId = " ";
    await FirebaseFirestore.instance
        .collection('chats')
        .where('members.$senderId.id', isEqualTo: senderId)
        .where('members.$receverId.id', isEqualTo: receverId)
        .get()
        .then((response) {
      print(response.docs.length);
      response.docs.forEach((doc) {
        chatRoomId = doc.id;
      });
    });
    print(chatRoomId);
    print(senderId);
    print(receverId);
    notifyListeners();
  }

  updateLastSeen(String? userId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .get()
        .then((value) async {
      Map<String, dynamic> members =
          value.data()!['members'] as Map<String, dynamic>;
      members.forEach((key, value) async {
        if (value['id'] == userId) {
          value['lastSeen'] = DateTime.now();
          print(key);

          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatRoomId)
              .update({'members.$key.lastSeen': value['lastSeen']});
          notifyListeners();
        }
      });
    });
  }

  getMessageCount(String chatRoomId, String? userId) async {
    var data = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .get();
    // .then((value) async {
    Map<String, dynamic> currentUserID = data.data()!['members'];
    var lastseen;
    currentUserID.forEach((key, value) {
      if (key == userId) {
        lastseen = value['lastSeen'];
        print(value['lastSeen']);
      }

      // });
    });
    var data2 = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection("conversation")
        .where("time", isGreaterThan: lastseen)
        .get();
    this.unreadCount = data2.docs.length;
    notifyListeners();
  }

  createChatRoom(
      {required var senderUser,
      required var receiverUser,
      String? recieverName,
      BuildContext? context}) {
    FirebaseFirestore.instance
        .collection('chats')
        // .where('members.${senderUser['senderId']}.id',
        //     isEqualTo: senderUser['senderId'])
        // .where('members.${receiverUser.id.toString()}.id',
        //     isEqualTo: receiverUser.id.toString())
        .where('members.$senderUser.id', isEqualTo: senderUser.toString())
        .where('members.$receiverUser.id', isEqualTo: receiverUser.toString())
        .get()
        .then((response) {
      if (response.docs.length == 0) {
        FirebaseFirestore.instance.collection('chats').add({
          'time': DateTime.now(),
          'lastMessage': "",
          'members': {
            senderUser: {
              'id': senderUser,
              'name': SelectAccount.selectAccount ==
                      SelectAccountEnum.User.toString()
                  ? context!.read<UserProvider>().userData.fullName
                  : context!.read<VendorProvider>().vendorData!.fullName,
              'profile': SelectAccount.selectAccount ==
                      SelectAccountEnum.User.toString()
                  ? context.read<UserProvider>().userData.profilePicture
                  : context.read<VendorProvider>().vendorData!.profilePicture,
              'time': DateTime.now(),
              'unreadCount': 0,
            },
            receiverUser: {
              'id': receiverUser,
              'name': recieverName,
              'profile':
                  'https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%2F$receiverUser?alt=media&token=1088bf58-1e94-4e3b-8ea2-6c17b50125f6',
              'time': DateTime.now(),
              'unreadCount': 0,
            },
          },
        });
      }
    });
  }

  //support chat work

  sendSupportMessage(String? chatId, String message) async {
    try {
      // ignore: deprecated_member_use
      FirebaseFirestore.instance
          .collection('supportChats')
          .doc(chatId)
          .collection('conversation')
          .add({
        'message': message,
        'senderId': senderId,
        'type': 'text',
        'time': DateTime.now(),
      });
      await FirebaseFirestore.instance
          .collection('supportChats')
          .doc(chatId)
          .set({
        'lastMessage': message,
        'time': DateTime.now(),
        // 'members.$senderId.time': DateTime.now(),
        "userId": senderId,
        "adminId": "123"
      }, SetOptions(merge: true));
    } catch (err) {
      // print(err);
    }
  }
}
