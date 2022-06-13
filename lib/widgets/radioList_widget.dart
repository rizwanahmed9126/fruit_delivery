import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/providers/app_language_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

class RadioButtionWidget extends StatefulWidget {
  final data;
  final active;
  ValueChanged<dynamic>? action; //callback value change
  String? tag;
  RadioButtionWidget({this.action, this.data, this.tag, this.active});

  @override
  _RadioButtionWidgetState createState() => _RadioButtionWidgetState();
}

class _RadioButtionWidgetState extends State<RadioButtionWidget> {
  var navigationService = locator<NavigationService>();

  void handleTap() {
    setState(() {
      widget.action!(widget.tag);

      if (widget.tag == '1') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("en"));
      }
      if (widget.tag! == '2') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("es"));
      }
      if (widget.tag! == '3') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("vi"));
      }
      if (widget.tag! == '4') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("km"));
      }
      if (widget.tag! == '5') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("pt"));
      }
      if (widget.tag! == '6') {
        Provider.of<AppLanguage>(context, listen: false)
            .changeLanguage(Locale("hi"));
      }
    });
  }

  // int? _radioValue = 0;

  // void _handleRadioValueChange(int? value) {
  //   setState(() {
  //     _radioValue = value!;

  //     switch (_radioValue) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return GestureDetector(
        onTap: handleTap,
        child: Container(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color: widget.active ? Colors.green : Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data['label'],
                      style: TextStyle(
                          color: widget.active ? Colors.black : Colors.grey,
                          fontSize: 15.h,
                          fontWeight: FontWeight.bold),
                    ),
                    widget.active!
                        ? new Icon(
                            Icons.radio_button_on_rounded,
                            color: Colors.red,
                            size: 20.0,
                          )
                        : new Icon(
                            Icons.circle_outlined,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
