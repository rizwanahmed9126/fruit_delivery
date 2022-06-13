// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class PopUpValueWidget extends StatefulWidget {
  final String? name;
  final HexColor? color;
  final bool? active;
  final ValueChanged<String>? action; //callback value change
  final String? tag;

  PopUpValueWidget(
      {this.name,
      // this.height,
      // this.width,

      this.color,
      this.active,
      this.action,
      this.tag});

  @override
  _PopUpValueWidgetState createState() => _PopUpValueWidgetState();
}

class _PopUpValueWidgetState extends State<PopUpValueWidget> {
  void handleTap() {
    setState(() {
      widget.action!(widget.tag!);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return InkWell(
      onTap: () {
        handleTap();
        Navigator.of(context).pop();
      },
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 15),
            // height: ScreenUtil().setHeight(90),
            // width: ScreenUtil().setWidth(550),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: widget.active!
                        ? HexColor('#E1E1E1').withOpacity(1.0)
                        : Colors.transparent,
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).backgroundColor,
                    Color.fromRGBO(52, 168, 83, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ),
                color:
                    widget.active! ? HexColor('#9450C9') : Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setSp(50))),
                border: Border.all(
                  width: 0,
                  color: widget.active! ? HexColor('#9450C9') : Colors.grey,
                )),
            child: FlatButton(
              onPressed: null,
              // onPressed: handleTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: ScreenUtil().setSp(5)),
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: ScreenUtil().setSp(10)),
                  //     child: Image.asset(
                  //       this.widget.image,
                  //       color: widget.active ? Colors.white :  Hexcolor('#9450C9'),
                  //       width: ScreenUtil().setHeight(this.widget.width),
                  //       height: ScreenUtil().setHeight(this.widget.height),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Text(this.widget.name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Gotham",
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.w500,
                          color: widget.active!
                              ? Colors.white
                              : HexColor('#B8BCCB'),
                        )
                        // Theme.of(context).textTheme.bodyText1,

                        ),

                    // margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
