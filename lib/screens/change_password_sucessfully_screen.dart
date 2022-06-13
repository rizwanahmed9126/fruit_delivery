// import 'dart:async';

// import 'package:animated_check/animated_check.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_delivery_flutter/constants/select_account.dart';
// import 'package:fruit_delivery_flutter/services/navigation_service.dart';
// import 'package:fruit_delivery_flutter/utils/routes.dart';
// import 'package:fruit_delivery_flutter/utils/service_locator.dart';

// import 'package:show_up_animation/show_up_animation.dart';

// class ChangePasswordSuccessfullyScreen extends StatefulWidget {
//   @override
//   _ChangePasswordSuccessfullyScreenState createState() =>
//       _ChangePasswordSuccessfullyScreenState();
// }

// class _ChangePasswordSuccessfullyScreenState
//     extends State<ChangePasswordSuccessfullyScreen>
//     with TickerProviderStateMixin {
//   AnimationController? _animationController;
//   Animation<double>? _animation;
//   var navigationService = locator<NavigationService>();

//   @override
//   void didChangeDependencies() {
//     Timer(Duration(seconds: 3), () {
//       if (SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()) {
//         navigationService.navigateTo(DriverHomeScreenRoute);
//       } else {
//         navigationService.navigateTo(MainDashboardScreenRoute);
//       }
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     super.initState();

//     _animationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     _animation = new Tween<double>(begin: 0, end: 1).animate(
//         new CurvedAnimation(
//             parent: _animationController!, curve: Curves.easeInOutCirc));

//     Timer(Duration(seconds: 2), () {
//       _animationController!.forward();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AnimationController(vsync: this, duration: Duration(seconds: 1));
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/splash.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: (Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Stack(alignment: Alignment.center, children: <Widget>[
//               // Image(
//               //   image: AssetImage("assets/images/Circle.png"),
//               //   height: ScreenUtil().setSp(200),
//               //   width: ScreenUtil().setSp(200),
//               // ),
//               // Icon(Icons.check,color: Colors.greenAccent,size: ScreenUtil().setSp(200),),

//               // ]),
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 60,
//                 child: AnimatedCheck(
//                   progress: _animation!,
//                   size: ScreenUtil().setSp(130),
//                   color: Colors.purple,
//                 ),
//               ),

//               //  SizedBox(height: 50,),
//               Align(
//                   alignment: FractionalOffset.bottomCenter,
//                   child: Container(
//                     child:
//                         // Container(child: Image.asset('assets/images/logo.png')),
//                         ShowUpAnimation(
//                             delayStart: Duration(milliseconds: 400),
//                             animationDuration: Duration(seconds: 2),
//                             curve: Curves.bounceIn,
//                             direction: Direction.vertical,
//                             offset: 0.7,
//                             child: Column(
//                               children: [
//                                 SizedBox(height: ScreenUtil().setSp(60)),
//                                 Text(
//                                   'CHANGED PASSWORD',
//                                   style: TextStyle(
//                                     fontSize: ScreenUtil().setSp(25),
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Oxygen',
//                                   ),
//                                 ),
//                                 Text(
//                                   'Successfully!',
//                                   style: TextStyle(
//                                     fontSize: ScreenUtil().setSp(50),
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'Oxygen',
//                                   ),
//                                 ),
//                               ],
//                             )),
//                   )),
//             ])),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animated_check/animated_check.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class ChangePasswordSuccessfullyScreen extends StatefulWidget {
  final title;
  final routeName;
  ChangePasswordSuccessfullyScreen({this.routeName, this.title});
  @override
  _ChangePasswordSuccessfullyScreenState createState() =>
      _ChangePasswordSuccessfullyScreenState();
}

class _ChangePasswordSuccessfullyScreenState
    extends State<ChangePasswordSuccessfullyScreen>
    with SingleTickerProviderStateMixin {
  var navigationService = locator<NavigationService>();
  AnimationController? _animationController;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController!, curve: Curves.easeInOutCirc));
    setState(() {
      _animationController!.forward();
    });
  }

  var height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return AlertDialog(
      // contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
      content: Container(
        height: height * 0.5,
        width: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Success!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.05),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.01),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Theme.of(context).backgroundColor,
                          style: BorderStyle.solid,
                        ),
                        shape: BoxShape.circle),
                    child: Center(
                      child: AnimatedCheck(
                        color: Theme.of(context).backgroundColor,
                        progress: _animation!,
                        size: height * 0.2,
                      ),
                    )),
                SizedBox(height: height * 0.03),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: height * 0.02),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    navigationService.navigateTo(HomeScreenRoute);
                  });
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
