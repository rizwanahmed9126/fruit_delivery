import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';

class NoFruitItemScreen extends StatefulWidget {
  NoFruitItemScreen({Key? key}) : super(key: key);

  @override
  _NoFruitItemScreenState createState() => _NoFruitItemScreenState();
}

class _NoFruitItemScreenState extends State<NoFruitItemScreen> {
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
            padding: const EdgeInsets.only(top: 35.0, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/ArrowBack.png"),
                  fit: BoxFit.fill,
                  height: 40,
                ),
                SizedBox(
                  width: 15.h,
                ),
                Text(
                  "Fruit Items",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ) // leading
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 160.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image(
                      image: AssetImage("assets/images/Untitled-1.png"),
                      fit: BoxFit.fill,
                      height: 90.h,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Text(
                    "No Fruit Items Yet",
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
                    height: 15.h,
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
                    // onTap: (){
                    //   navigationService.navigateTo(CreateRouteFormScreenRoute);                    },
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
