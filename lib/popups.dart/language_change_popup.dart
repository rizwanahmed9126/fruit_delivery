import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/app_language_provider.dart';

import 'popup_value_widget.dart';

// ignore: must_be_immutable
class LanguageChangePopupWidget extends StatefulWidget {
  var languageController;
  LanguageChangePopupWidget(this.languageController);

  @override
  _LanguageChangePopupWidgetState createState() =>
      _LanguageChangePopupWidgetState();
}

class _LanguageChangePopupWidgetState extends State<LanguageChangePopupWidget> {
  var navigationService = locator<NavigationService>();

  void active(String val) {
    setState(() {
      widget.languageController = val;
    });
    if (val == 'ENGLISH') {
      Provider.of<AppLanguage>(context, listen: false)
          .changeLanguage(Locale("en"));
    } else {
      Provider.of<AppLanguage>(context, listen: false)
          .changeLanguage(Locale("ar"));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 0.5, left: 0.5),
          width: ScreenUtil().setWidth(700),
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: ScreenUtil().setWidth(80),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: ScreenUtil().setHeight(50),
              // ),
              // Center(
              //   child: Container(
              //       height: ScreenUtil().setHeight(100),
              //       child: Image.asset("assets/images/kids_popup.png")),
              // ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  AppLocalizations.of(context).translate('selectLanguage'),
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(60),
                      fontFamily: "Gotham",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: ScreenUtil().setWidth(50),
              //       decoration: BoxDecoration(
              //         border: Border(
              //           top: BorderSide(
              //             color: Theme.of(context).backgroundColor,
              //             width: ScreenUtil().setWidth(5),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              Container(
                // alignment: Alignment.center,
                child: PopUpValueWidget(
                  action: active, //pass data from child to parent
                  tag: "ENGLISH", //specifies attribute of button
                  active: widget.languageController == "ENGLISH"
                      ? true
                      : false, //set button active based on value in this parent
                  name: "ENGLISH",
                ),
              ),
              Container(
                // alignment: Alignment.center,
                child: PopUpValueWidget(
                  action: active, //pass data from child to parent
                  tag: "العربية", //specifies attribute of button
                  active: widget.languageController == "العربية"
                      ? true
                      : false, //set button active based on value in this parent
                  name: "العربية",
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
