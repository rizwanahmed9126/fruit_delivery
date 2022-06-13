import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
<meta id="viewport" name="viewport" content="width=device-width, initial-scale=0.9, minimum-scale=0.1, maximum-scale=3.0, user-scalable=yes">
</body>
</html>
''';

class FacebookWidget extends StatefulWidget {
  @override
  _FacebookWidgetState createState() => _FacebookWidgetState();
}

class _FacebookWidgetState extends State<FacebookWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int position = 1;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  final Set<Factory> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  UniqueKey _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          // _selectedIndex != 3 ? Size.fromHeight(65) : Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,

            leading: Builder(
              builder: (context) => IconButton(
                  icon: Image.asset(
                    'assets/images/ArrowBack.png',
                    scale: 2.5,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),

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
        body: Builder(builder: (BuildContext context) {
          return IndexedStack(
            index: position,
            children: [
              WebView(
                key: _key,
                // gestureRecognizers: gestureRecognizers,
                initialUrl: "https://www.facebook.com/guanabanasymas/",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onPageStarted: (value) {
                  setState(() {
                    position = 1;
                  });
                },
                onPageFinished: (value) {
                  setState(() {
                    position = 0;
                  });
                },
                allowsInlineMediaPlayback: true,
                initialMediaPlaybackPolicy:
                    AutoMediaPlaybackPolicy.always_allow,
                gestureNavigationEnabled: true,
              ),
              Container(
                child: Center(
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.black),
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ignore: unused_element
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
