import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/screens/vendor_profile_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';

class CreateRouteScreen extends StatefulWidget {
  CreateRouteScreen({Key? key}) : super(key: key);

  @override
  _CreateRouteScreenState createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends State<CreateRouteScreen> {
  var navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35.h,
                  width: 75.h,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromRGBO(237, 237, 237, 1)),
                      ),
                      onPressed: () {
                        //navigationService.navigateTo(VendorProfileScreenRoute);
                        //navigationService.navigateTo(DriverHomeScreenRoute);
                        navigationService.navigateTo(ScheduleScreenRoute);
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('Skip'),
                        style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 210.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('CreateRoutePlan'),
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 1.5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(53, 186, 139, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 270.h,
                    child: Text(
                      "Lorem ipsum dolar sit amet,cosectetur adipiscing elit ,sed do eiusmod tempor",
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.3.h, fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.navigateTo(CreateRouteFormScreenRoute);
                    },
                    child: CircleAvatar(
                      radius: 57.h,
                      backgroundColor: Color.fromRGBO(154, 219, 195, 1),
                      child: CircleAvatar(
                        radius: 50.h,
                        backgroundColor: Color.fromRGBO(53, 186, 139, 1),
                        child: Icon(
                          Icons.add,
                          size: 50.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
