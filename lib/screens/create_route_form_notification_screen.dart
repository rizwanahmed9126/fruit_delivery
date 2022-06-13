
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:fruit_delivery_flutter/constants/color_constants.dart';

class CreateRouteFormNotificationScreen extends StatefulWidget {
  @override
  _CreateRouteFormNotificationScreenState createState() =>
      _CreateRouteFormNotificationScreenState();
}

class _CreateRouteFormNotificationScreenState
    extends State<CreateRouteFormNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  var navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0.0,
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 18.0.w, top: 8.h),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'assets/images/ArrowBack.png',
                width: 35.h,
                height: 35.h,
              )),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            AppLocalizations.of(context).translate('CreateRoute'),
            style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 18.0.w, top: 8.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  'assets/images/Notifications.png',
                  width: 35.h,
                  height: 35.h,
                )),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.9,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.fromLTRB(18.0.w, 0.0, 18.0.w, 0.0),
                children: [
                  TimeLineTextField(
                    isFirst: true,
                    isLast: false,
                    suffixOnpress: () {},
                    timelineAlignment: TimelineAlign.start,
                    hintText:
                        AppLocalizations.of(context).translate('StartLocation'),
                    isSuffixIcon: true,
                    suffixIcon: Icons.location_searching_rounded,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TimeLineTextField(
                          isFirst: false,
                          isLast: false,
                          hintText: 'MS 39503',
                          timelineAlignment: TimelineAlign.start,
                          suffixOnpress: () {},
                          isSuffixIcon: false,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0.h),
                        child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.close,
                              color: Colors.black54,
                              size: 18.sp,
                            )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.52.w),
                            child: TimelineTile(
                              beforeLineStyle:
                                  LineStyle(color: iconColor, thickness: 1.5),
                              afterLineStyle:
                                  LineStyle(color: iconColor, thickness: 1.5),
                              lineXY: 0.0,
                              indicatorStyle: IndicatorStyle(
                                  indicatorXY: 0.5,
                                  width: 0.0.w,
                                  height: 0.0.w),
                              endChild: Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0.w, bottom: 18.0.h),
                                child: Row(
                                  children: [
                                    CalenderButton(
                                      buttonIcon: Icons.lock_clock,
                                      buttonText: AppLocalizations.of(context)
                                          .translate('TripDate'),
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2025));
                                      },
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CalenderButton(
                                      buttonIcon: Icons.calendar_view_day,
                                      buttonText: AppLocalizations.of(context)
                                          .translate('estimatedArrival'),
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2025));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TimeLineTextField(
                              isFirst: false,
                              isLast: false,
                              hintText: AppLocalizations.of(context)
                                  .translate('Addstop2'),
                              timelineAlignment: TimelineAlign.start,
                              isSuffixIcon: false,
                              suffixOnpress: () {}),
                          TimeLineTextField(
                              isFirst: false,
                              isLast: false,
                              hintText: AppLocalizations.of(context)
                                  .translate('Addstop3'),
                              timelineAlignment: TimelineAlign.start,
                              isSuffixIcon: false,
                              suffixOnpress: () {}),
                          TimeLineTextField(
                              isFirst: false,
                              isLast: true,
                              hintText: AppLocalizations.of(context)
                                  .translate('Addstop4'),
                              timelineAlignment: TimelineAlign.start,
                              isSuffixIcon: false,
                              suffixOnpress: () {})
                        ],
                      )),
                      Container(width: 25.w),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.38,
            child: Padding(
              padding: EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 20.w),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 175.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // GestureDetector(
                    //   onTap: (){
                    //     // navigationService.navigateTo();
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.bottomRight,
                    //     height: 110.h,
                    //     child: Image.asset('assets/images/floatingAction.png',fit: BoxFit.cover,),
                    //   ),
                    // ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: baseColor,
                            borderRadius: BorderRadius.circular(8.0.r)),
                        height: 45.w,
                        width: double.infinity,
                        child: Text(
                            AppLocalizations.of(context).translate('Submit'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CalenderButton extends StatelessWidget {
  String buttonText;
  IconData buttonIcon;
  VoidCallback onTap;
  CalenderButton({
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(5.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                buttonText,
                style: TextStyle(fontSize: 10.sp),
                overflow: TextOverflow.ellipsis,
              )),
              Icon(
                buttonIcon,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // Offset in X direction
  double offsetY; // Offset in Y direction
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}

// ignore: must_be_immutable
class TimeLineTextField extends StatelessWidget {
  String? hintText;
  Color? indicatorColor;
  bool isFirst;
  bool isLast;
  bool isSuffixIcon;
  IconData? suffixIcon;
  TimelineAlign timelineAlignment;
  VoidCallback suffixOnpress;

  TimeLineTextField(
      {required this.isLast,
      required this.isFirst,
      this.indicatorColor,
      required this.timelineAlignment,
      this.hintText,
      required this.isSuffixIcon,
      required this.suffixOnpress,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isLast: isLast,
      isFirst: isFirst,
      lineXY: 0.0,
      beforeLineStyle: LineStyle(color: iconColor, thickness: 1.5),
      afterLineStyle: LineStyle(color: iconColor, thickness: 1.5),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.5,
        width: 5.w,
        height: 5.w,
        color: baseColor,
      ),
      alignment: timelineAlignment,
      endChild: Padding(
        padding: EdgeInsets.only(left: 8.0.w, bottom: 12.0.w),
        child: Container(
          height: 40.h,
          child: TextFormField(
              cursorColor: baseColor,
              cursorHeight: 20,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12.0.w),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: BorderSide(
                    color: baseColor,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: BorderSide(
                    color: smokeColor,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0.r),
                    ),
                    borderSide: BorderSide(color: smokeColor)),
                filled: true,
                fillColor: Colors.white,
                hintStyle: new TextStyle(
                    color: Colors.black45,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
                hintText: hintText,
                suffixIcon: isSuffixIcon == true
                    ? Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: iconColor,
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          child: Icon(
                            suffixIcon,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      )
                    : null,
              )),
        ),
      ),
    );
  }
}
