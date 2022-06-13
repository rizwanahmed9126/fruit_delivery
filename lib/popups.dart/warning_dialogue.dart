import 'package:flutter/material.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class WarningScreen extends StatefulWidget {
  @override
  _WarningScreenState createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen>
    with SingleTickerProviderStateMixin {
  var navigationService = locator<NavigationService>();

  var height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return AlertDialog(
      // contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
      content: Container(
        height: height * 0.4,
        width: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Text(
                //   'Success!',
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold, fontSize: height * 0.05),
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(height: height * 0.01),
                // Container(
                //     margin: EdgeInsets.only(top: 30),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //           width: 3,
                //           color: Theme.of(context).backgroundColor,
                //           style: BorderStyle.solid,
                //         ),
                //         shape: BoxShape.circle),
                //     child: Center(
                //       child: AnimatedCheck(
                //         color: Theme.of(context).backgroundColor,
                //         progress: _animation!,
                //         size: height * 0.2,
                //       ),
                //     )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Icon(
                    Icons.warning_rounded,
                    color: Colors.yellow,
                    size: height * 0.2,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  child: Text(
                    "Will be delivered in beta \nphase 2",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: height * 0.025),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.w600),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.55,
                      MediaQuery.of(context).size.height * 0.060),
                  primary: Theme.of(context).backgroundColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(
                          width: 1, color: Theme.of(context).backgroundColor)),
                ),
                child: Container(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: new Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
    // Scaffold(
    //     appBar: AppBar(
    //       title: Text("Animated Check Example"),
    //     ),
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Container(
    //               child: AnimatedCheck(
    //             progress: _animation,
    //             size: 200,
    //           )),
    //           TextButton(
    //               child: Text("Check"),
    //               onPressed: _animationController.forward),
    //           TextButton(
    //               child: Text("Reset"), onPressed: _animationController.reset)
    //         ],
    //       ),
    //     ));
  }
}
