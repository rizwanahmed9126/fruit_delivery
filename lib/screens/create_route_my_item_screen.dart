import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import '../widgets/my_item_create_route_widget.dart';
import '../constants/color_constants.dart';

class CreateRouteScreenMyItems extends StatefulWidget {
  @override
  _CreateRouteScreenMyItemsState createState() =>
      _CreateRouteScreenMyItemsState();
}

class _CreateRouteScreenMyItemsState extends State<CreateRouteScreenMyItems> {
  var navigationService = locator<NavigationService>();
  var vendorData;
  bool isLoadingProgress = false;
  void active(var data) {
    if (data)
      setState(() {
        vendorData =
            Provider.of<VendorProvider>(context, listen: false).vendorData;
      });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationService.closeScreen();
        return false;
      },
      child: Scaffold(
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
                  navigationService.closeScreen();
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
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TimeLineTextField(
                      isFirst: true,
                      isLast: false,
                      suffixOnpress: () {},
                      timelineAlignment: TimelineAlign.start,
                      hintText: AppLocalizations.of(context)
                          .translate('StartLocation'),
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
                            hintText: 'MS 395073',
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
                          padding: EdgeInsets.only(bottom: 15.0.h),
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
                    // Column(
                    //   children: [
                    //     ListView.builder(
                    //       physics: NeverScrollableScrollPhysics(),
                    //       shrinkWrap: true,
                    //       itemCount: length1,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return AddStopWidget(index: index);
                    //       },
                    //     ),
                    //   ],
                    // ),
                    Container(width: 28.w),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Items"),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoadingProgress = true;
                      });
                      await Provider.of<ProductsProvider>(context,
                              listen: false)
                          .fetchAllProducts(count: 10, page: 1);

                      setState(() {
                        isLoadingProgress = false;
                      });
                      navigationService.navigateTo(AddItemScreenRoute);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        4,
                        8,
                        4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green.shade50,
                      ),
                      child: Text(
                        "View All",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: vendorData.products == null
                      ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.4,
                            child: Image.asset(
                              "assets/images/Fruit-Basket.png",
                              // fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<VendorProvider>(
                              builder: (context, provider, child) {
                            return ListView.builder(
                                itemCount:
                                    provider.vendorData!.products!.length,
                                itemBuilder: (ctx, i) {
                                  return MyItemsList(
                                    data: provider.vendorData!.products![i],
                                    active: active,
                                  );
                                });
                          }),
                        )),
            ],
          ),
        ),
        floatingActionButton: Container(
          child: ElevatedButton(
            onPressed: () {
              navigationService.navigateTo(RouteDetailScreenRoute);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.w600),
              fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
                  MediaQuery.of(context).size.height * 0.060),
              primary: Theme.of(context).accentColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      width: 1, color: Theme.of(context).accentColor)),
            ),
            child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 10.w),
                child: new Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
