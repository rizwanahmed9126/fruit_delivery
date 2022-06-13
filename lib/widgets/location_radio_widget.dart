import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LocationRadiowidget extends StatefulWidget {
  final data;
  final active;
  ValueChanged<dynamic>? action; //callback value change
  String? tag;
  LocationRadiowidget({
    this.data,
    this.active,
    this.action,
    this.tag,
  });

  @override
  _LocationRadiowidgetState createState() => _LocationRadiowidgetState();
}

class _LocationRadiowidgetState extends State<LocationRadiowidget> {
  bool isSelected = false;
  void handletap() {
    widget.action!(widget.tag!);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Padding(
      padding: const EdgeInsets.only(
        left: 0.0,
        right: 0.0,
      ),
      child: GestureDetector(
        onTap: handletap,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              left: 0.0,
              right: 0.0,
              top: 8.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     ${widget.data['title']}',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: widget.active!
                              ? Colors.black
                              : Colors.grey.shade500,
                          fontWeight: widget.active!
                              ? FontWeight.bold
                              : FontWeight.w400),
                    ),
                    Spacer(),
                    widget.active!
                        ? new Icon(
                            Icons.radio_button_on_rounded,
                            color: Colors.green.shade700,
                            size: 20.0.h,
                          )
                        : new Icon(
                            Icons.circle_outlined,
                            color: Colors.grey,
                            size: 20.0.h,
                          ),
                    SizedBox(
                      width: 10.h,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                if (widget.tag! == "1")
                  Divider(
                    thickness: 1.5,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
