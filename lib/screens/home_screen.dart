import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloadingprogress = false;
  var navigationService = locator<NavigationService>();
  var userData;
  @override
  void initState() {
    userData = Provider.of<UserProvider>(context, listen: false).userData;

    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAllProducts(count: 8, page: 1);

    super.initState();
  }

  var height;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    final List bottomBanner = [
      {
        'Title': AppLocalizations.of(context).translate('HomeSpecialOffer'),
        'Name': 'Banana Starting From',
        'Price': '\$2.00',
        'Image': 'assets/images/BottomBanner.png'
      },
      {
        'Title': AppLocalizations.of(context).translate('HomeSpecialOffer'),
        'Name': 'Banana Starting From',
        'Price': '\$2.00',
        'Image': 'assets/images/BottomBanner.png'
      },
      {
        'Title': AppLocalizations.of(context).translate('HomeSpecialOffer'),
        'Name': 'Banana Starting From',
        'Price': '\$2.00',
        'Image': 'assets/images/BottomBanner.png'
      }
    ];
    final List bannerLists = [
      {
        'Title':
            AppLocalizations.of(context).translate('HomeGetFruitsInYourArea'),
        'Order':
            'Find the nearest driver\'s location from\nyour to get fruit item',
        'BannerImage': 'assets/images/BannerImage.png'
      },
      {
        'Title':
            AppLocalizations.of(context).translate('HomeGetFruitsInYourArea'),
        'Order':
            'Find the nearest driver\'s location from\nyour to get fruit item',
        'BannerImage': 'assets/images/BannerImage.png'
      },
      {
        'Title':
            AppLocalizations.of(context).translate('HomeGetFruitsInYourArea'),
        'Order':
            'Find the nearest driver\'s location from\nyour to get fruit item',
        'BannerImage': 'assets/images/BannerImage.png'
      }
    ];
    height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Consumer<ProductsProvider>(builder: (context, i, _) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context).translate('Welcome'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightGreen,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                " ${userData != null ? "${userData.fullName}" : " Dear"}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   "Hi, Welcome ${userData != null ? userData.fullName : "Dear"}",
                    //   style: TextStyle(
                    //     fontSize: 16.sp,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.lightGreen,
                    //   ),
                    // ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('HomeWhatDoYouWantToOrder'),
                      // "What do you want to order?",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  height: height * 0.2,
                  child: PageView.builder(
                    itemCount: bannerLists.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: EdgeInsets.all(7.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(211, 245, 255, 1),
                        ),
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${bannerLists[index]['Title']}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '${bannerLists[index]['Order']}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: ''),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                if (SelectAccount.selectAccount !=
                                    SelectAccountEnum.Guest.toString())
                                  SizedBox(
                                    height: 30.h,
                                    child: TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('HomeViewTripSchedules'),
                                        // "View Trip Schedules",
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty
                                            .all<EdgeInsets>(EdgeInsets.only(
                                                left: 13, right: 13)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                width: 2, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        showLoadingAnimation(context);
                                        await Provider.of<UserProvider>(context,
                                                listen: false)
                                            .fetchActiveVendor();
                                        navigationService.closeScreen();

                                        navigationService
                                            .navigateTo(TripScreenRoute);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Image(
                                image: AssetImage(
                                    '${bannerLists[index]['BannerImage']}'),
                                height: height * 0.13,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    clipBehavior: Clip.none,
                    controller: controller,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate('HomeBrowseAllFruits'),
                        // "Browse All Fruit",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 30.h,
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            navigationService
                                .navigateTo(SearchProductScreenRoute);
                          },
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('HomeViewAll'),
                            // "View All",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.22,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: i.productData.length,
                    // i.productData.length,
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 130.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: "${i.productData[index].backgroundColor}" ==
                                  "orange"
                              ? Color.fromRGBO(254, 245, 236, 1)
                              : "${i.productData[index].backgroundColor}" ==
                                      " yellow"
                                  ? Color.fromRGBO(254, 248, 216, 1)
                                  : "${i.productData[index].backgroundColor}" ==
                                          "green"
                                      ? Color.fromRGBO(238, 245, 227, 1)
                                      : "${i.productData[index].backgroundColor}" ==
                                              "red"
                                          ? Color.fromRGBO(248, 232, 232, 1)
                                          : "${i.productData[index].backgroundColor}" ==
                                                  "peach"
                                              ? Color.fromRGBO(254, 241, 230, 1)
                                              : "${i.productData[index].backgroundColor}" ==
                                                      "darkgreen"
                                                  ? Color.fromRGBO(
                                                      235, 241, 232, 1)
                                                  : Color.fromRGBO(
                                                      254, 241, 230, 1),
                          // itemsList[index]['BoxColor'],
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: NetworkImage(
                                  // "data:image/jpeg;base64,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",
                                  "${i.productData[index].picture}",
                                  // '${itemsList[index]['Image']}'
                                ),
                                fit: BoxFit.cover,
                                height: 65.h,
                              ),
                            ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${i.productData[index].name}",
                                  // "${itemsList[index]['Name']}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "PER ${i.productData[index].unit}",
                                  // "${itemsList[index]['Kg']}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "\$${i.productData[index].price}",
                                  // "${itemsList[index]['Price']}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 12.w, right: 12.w),
                //   height: height * 0.16,
                //   child: PageView.builder(
                //     clipBehavior: Clip.none,
                //     itemCount: bottomBanner.length,
                //     itemBuilder: (BuildContext context, index) {
                //       return Stack(clipBehavior: Clip.none, children: [
                //         Container(
                //           margin: EdgeInsets.only(
                //               left: 7.w, right: 7.w, bottom: 0.h),
                //           decoration: BoxDecoration(
                //             color: Color.fromRGBO(251, 230, 159, 1),
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           padding: EdgeInsets.all(20),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.only(right: 20.w),
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       AppLocalizations.of(context)
                //                           .translate('HomeSpecialOffer'),
                //                       // "Special Offer",
                //                       style: TextStyle(
                //                         fontSize: 20.sp,
                //                         fontWeight: FontWeight.w600,
                //                         color: Colors.black,
                //                       ),
                //                     ),
                //                     Text(
                //                       AppLocalizations.of(context)
                //                           .translate('HomeStartingFrom'),
                //                       style: TextStyle(
                //                         // height: 1.4,
                //                         fontSize: 12.sp,
                //                         fontWeight: FontWeight.w600,
                //                         color: Colors.black,
                //                       ),
                //                     ),
                //                     Text(
                //                       "\$2.00",
                //                       style: TextStyle(
                //                         // height: 1.4,
                //                         fontSize: 14.sp,
                //                         fontWeight: FontWeight.w700,
                //                         color: Colors.black,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Positioned(
                //           top: -8.h,
                //           left: 20.w,
                //           child: Image(
                //             image:
                //                 AssetImage('${bottomBanner[index]['Image']}'),
                //             height: height * 0.14,
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //         Positioned(
                //             right: height * 0.03,
                //             bottom: height * 0.03,
                //             child: Container(
                //                 padding: EdgeInsets.all(5),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(6),
                //                 ),
                //                 child: Icon(
                //                   Icons.arrow_forward_ios,
                //                   size: height * 0.014,
                //                   color: Colors.grey,
                //                 )))
                //       ]);
                //     },
                //     controller: controller,
                //   ),
                // ),
              ],
            ),
          ));
    });
  }
}
