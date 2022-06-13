import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:fruit_delivery_flutter/models/messages.dart';

class MyMessageChatTile extends StatelessWidget {
  final double minValue = 8.0;
  // final Message? message;
  final Map<String, dynamic>? messageData;
  final bool isCurrentUser;

  MyMessageChatTile({this.messageData, required this.isCurrentUser});
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return messageData!['type'] == 'text'
          ? Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: sy(5), bottom: sy(5)),
                  child: Bubble(
                    style: BubbleStyle(padding: BubbleEdges.all(sy(7))),
                    // radius: Radius.elliptical(40, 40),

                    margin: isCurrentUser
                        ? BubbleEdges.only(right: sx(15), left: sx(115))
                        : BubbleEdges.only(right: sx(115), left: sx(15)),
                    nip: isCurrentUser
                        ? BubbleNip.rightTop
                        : BubbleNip.leftBottom,
                    color: isCurrentUser
                        ? Color.fromRGBO(63, 190, 144, 1)
                        : Colors.transparent,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SelectableText(
                            messageData!['message'],
                            style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ]),
                  ),
                ),
                Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: isCurrentUser
                            ? EdgeInsets.only(right: sx(40), left: sx(15))
                            : EdgeInsets.only(right: sx(40), left: sx(40)),
                        child: Text(
                          timeago.format(
                            DateTime.now().subtract(
                              DateTime.now().difference(
                                messageData!['time'].toDate(),
                              ),
                            ),
                          ),
                          style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.black : Colors.black,
                              fontSize: sy(5)),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: sy(10),
                )
              ],
            )
          : messageData!['type'] == 'image'
              ? GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            _showSecondPage(context, messageData!['imageUrl']));
                  },
                  child: Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: sy(5), bottom: sy(5)),
                        child: Bubble(
                          style: BubbleStyle(padding: BubbleEdges.all(sy(7))),
                          // radius: Radius.elliptical(40, 40),

                          margin: isCurrentUser
                              ? BubbleEdges.only(right: sx(15), left: sx(115))
                              : BubbleEdges.only(right: sx(115), left: sx(15)),
                          nip: isCurrentUser
                              ? BubbleNip.rightTop
                              : BubbleNip.leftBottom,
                          color: isCurrentUser
                              ? Color.fromRGBO(63, 190, 144, 1)
                              : Colors.transparent,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // PhotoView(
                                //   imageProvider:
                                //       AssetImage(messageData!['imageUrl']),
                                // );

                                Container(
                                  child: Image.network(
                                    messageData!['imageUrl'],
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                SelectableText(
                                  messageData!['message'],
                                  style: TextStyle(
                                    color: isCurrentUser
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: isCurrentUser
                                  ? EdgeInsets.only(right: sx(40), left: sx(15))
                                  : EdgeInsets.only(
                                      right: sx(40), left: sx(40)),
                              child: Text(
                                timeago.format(
                                  DateTime.now().subtract(
                                    DateTime.now().difference(
                                      messageData!['time'].toDate(),
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    color: isCurrentUser
                                        ? Colors.black
                                        : Colors.black,
                                    fontSize: sy(5)),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: sy(10),
                      )
                    ],
                  ),
                )
              : Container();
    });
  }

  _showSecondPage(BuildContext context, String imageUrl) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
                basePosition: Alignment(0.5, 0.0),
              ),
            )));
  }
}
