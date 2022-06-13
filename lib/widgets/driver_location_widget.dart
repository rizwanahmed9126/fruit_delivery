import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverLocationWidget extends StatefulWidget {
  final data;

  DriverLocationWidget({
    this.data,
  });

  @override
  _DriverLocationWidgetState createState() => _DriverLocationWidgetState();
}

class _DriverLocationWidgetState extends State<DriverLocationWidget> {
  bool? isactive = false;
  void handeltap() {
    setState(() {
      isactive = !isactive!;
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
    return GestureDetector(
      onTap: handeltap,
      child: Container(
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title,
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.data.subtitle,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                            height: 1.5),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
