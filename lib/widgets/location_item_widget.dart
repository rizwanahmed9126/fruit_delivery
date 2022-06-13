import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationItemWidget extends StatefulWidget {
  final data;

  LocationItemWidget({
    this.data,
  });

  @override
  _LocationItemWidgetState createState() => _LocationItemWidgetState();
}

class _LocationItemWidgetState extends State<LocationItemWidget> {
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
              padding: const EdgeInsets.only(left: 25.0, right: 10),
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
                  IconButton(
                      onPressed: () {
                        handeltap();
                      },
                      icon: isactive!
                          ? Icon(
                              Icons.favorite_sharp,
                              color: Colors.red,
                              size: 20.h,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.grey.shade500,
                              size: 20.h,
                            )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
