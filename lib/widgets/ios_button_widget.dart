import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IosButtons extends StatefulWidget {
  final VoidCallback google;
  final VoidCallback facebook;
  final VoidCallback apple;

  const IosButtons({Key? key,required this.google,required this.apple,required this.facebook}) : super(key: key);

  @override
  _IosButtonsState createState() => _IosButtonsState();
}

class _IosButtonsState extends State<IosButtons> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        child: ElevatedButton(
          onPressed: widget.facebook,
          //     () {
          //   // navigationService.navigateTo(MeasureHeightScreenRoute);
          // },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w600),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.10,
                MediaQuery.of(context).size.height * 0.060),
            primary: Color.fromRGBO(242, 243, 245, 1),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(200.0),
                side: BorderSide(
                    width: 1, color: Color.fromRGBO(242, 243, 245, 1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  'assets/images/Login-Facebook.png',
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 20.h,
      ),
      Container(
        child: ElevatedButton(
          onPressed: widget.google,
          //     () {
          //   // navigationService.navigateTo(MeasureHeightScreenRoute);
          // },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w600),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.10,
                MediaQuery.of(context).size.height * 0.060),
            primary: Color.fromRGBO(242, 243, 245, 1),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(
                    width: 1, color: Color.fromRGBO(242, 243, 245, 1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  'assets/images/Login-Google.png',
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 20.h,
      ),
      Container(
        child: ElevatedButton(
          onPressed: widget.apple,
          //     () {
          //   // navigationService.navigateTo(MeasureHeightScreenRoute);
          // },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w600),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.10,
                MediaQuery.of(context).size.height * 0.060),
            primary: Color.fromRGBO(242, 243, 245, 1),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(
                    width: 1, color: Color.fromRGBO(242, 243, 245, 1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  "assets/images/apple-icon.png",
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
