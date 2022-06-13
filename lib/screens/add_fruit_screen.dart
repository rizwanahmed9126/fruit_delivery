// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/popups.dart/my_fruits_list_popup.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/products_provider.dart';
import '../widgets/add_fruit_item.dart';
import '../popups.dart/warning_dialogue.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class AddFruitScreen extends StatefulWidget {
  AddFruitScreen({Key? key}) : super(key: key);

  @override
  _AddFruitScreenState createState() => _AddFruitScreenState();
}

class _AddFruitScreenState extends State<AddFruitScreen> {
  List<dynamic> addProductsData = [];
  List<dynamic> newProductsData = [];
  var navigationService = locator<NavigationService>();

  bool isLoading = false;
  String tagId = ' ';

  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  @override
  void initState() {
    // data = Provider.of<ProductsProvider>(context, listen: false).getAllProducts;
    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;

    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    // newProductsData = vendorData.products.addAll(addProductsData);
    // [...vendorData.products, ...addProductsData].toSet().toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return WillPopScope(
      onWillPop: () async {
        navigationService.closeScreen();
        return false;
      },
      child: AbsorbPointer(
        absorbing: isLoading,
        child: Consumer<ProductsProvider>(builder: (context, pp, _) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: pp.tempSelectedProducts.length != 0
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
                // shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: double.infinity,
              child: FloatingActionButton(
                // splashColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                onPressed: () {
                  if (pp.tempSelectedProducts.length != 0) {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    // await Provider.of<ProductsProvider>(context, listen: false)
                    //     .postProducts(context);
                    pp.selectedProducts.addAll(pp.tempSelectedProducts);
                    Provider.of<VendorProvider>(context, listen: false)
                        .setVendorProducts(pp.selectedProducts);
                    navigationService.closeScreen();
                    pp.tempSelectedProducts.clear();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  pp.tempSelectedProducts.length != 0
                      ? "Submit "
                      : "Enter Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context
                                .read<ProductsProvider>()
                                .tempSelectedProducts
                                .length !=
                            0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      //navigationService.navigateTo(DriverHomeScreenRoute);
                      navigationService.closeScreen();
                    },
                    child: Image.asset(
                      'assets/images/ArrowBack.png',
                      fit: BoxFit.fill,
                      width: 10.h,
                      height: 10.h,
                    ),
                  ),
                ),

                centerTitle: true,

                title: Image.asset(
                  'assets/images/logoleaf.png',
                  scale: 14,
                  // color: Colors.white,
                ),
                bottomOpacity: 0.0,
                // backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
                    child: IconButton(
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (_) {
                        //       return WarningScreen();
                        //     });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return MyFruitListPopup(
                                  // data: vendorData.products,
                                  // onItemClicked: active,
                                  );
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AddFruitListPopup();
                        //     });
                      },
                      icon: Image.asset(
                        'assets/images/add_icon.png',
                        // width: 40.h,
                        // height: 40.h,
                      ),
                      iconSize: 35.h,
                    ),
                  )
                ],
              ),
            ),
            body: Container(
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                          height: 32,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('DrawerAddFruits'),
                            // "   Add Fruits",
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w600),
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<ProductsProvider>(
                            builder: (context, pp, _) {
                          return ListView.builder(
                              itemCount: pp.productData.length,
                              itemBuilder: (ctx, i) {
                                return AddFruitItem(
                                  data: pp.productData[i],
                                  isActiveID: i,
                                );
                              });
                        }),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50.h,
                    // )
                  ],
                ),
                if (isLoading)
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ))
              ]),
            ),
          );
        }),
      ),
    );
  }
}


/*
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/popups.dart/my_fruits_list_popup.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/products_provider.dart';
import '../widgets/add_fruit_item.dart';
import '../popups.dart/warning_dialogue.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class AddFruitScreen extends StatefulWidget {
  AddFruitScreen({Key? key}) : super(key: key);

  @override
  _AddFruitScreenState createState() => _AddFruitScreenState();
}

class _AddFruitScreenState extends State<AddFruitScreen> {
  List<dynamic> addProductsData = [];
  List<dynamic> newProductsData = [];
  var navigationService = locator<NavigationService>();

  bool isLoading = false;

  @override
  void initState() {
    // data = Provider.of<ProductsProvider>(context, listen: false).getAllProducts;
    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;

    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    // newProductsData = vendorData.products.addAll(addProductsData);
    // [...vendorData.products, ...addProductsData].toSet().toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return WillPopScope(
      onWillPop: () async {
        navigationService.closeScreen();
        return false;
      },
      child: AbsorbPointer(
        absorbing: isLoading,
        child: Consumer<ProductsProvider>(builder: (context, pp, _) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: pp.tempSelectedProducts.length != 0
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
                // shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: double.infinity,
              child: FloatingActionButton(
                // splashColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                onPressed: () {
                  if (pp.tempSelectedProducts.length != 0) {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    // await Provider.of<ProductsProvider>(context, listen: false)
                    //     .postProducts(context);

                    navigationService.closeScreen();
                    pp.tempSelectedProducts.clear();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  pp.tempSelectedProducts.length != 0
                      ? "Submit "
                      : "Enter Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context
                                .read<ProductsProvider>()
                                .tempSelectedProducts
                                .length !=
                            0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      //navigationService.navigateTo(DriverHomeScreenRoute);
                      navigationService.closeScreen();
                    },
                    child: Image.asset(
                      'assets/images/ArrowBack.png',
                      fit: BoxFit.fill,
                      width: 10.h,
                      height: 10.h,
                    ),
                  ),
                ),

                centerTitle: true,

                title: Image.asset(
                  'assets/images/logoleaf.png',
                  scale: 14,
                  // color: Colors.white,
                ),
                bottomOpacity: 0.0,
                // backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
                    child: IconButton(
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (_) {
                        //       return WarningScreen();
                        //     });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return MyFruitListPopup(
                                  // data: vendorData.products,
                                  // onItemClicked: active,
                                  );
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AddFruitListPopup();
                        //     });
                      },
                      icon: Image.asset(
                        'assets/images/add_icon.png',
                        // width: 40.h,
                        // height: 40.h,
                      ),
                      iconSize: 35.h,
                    ),
                  )
                ],
              ),
            ),
            body: Container(
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                          height: 32,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('DrawerAddFruits'),
                            // "   Add Fruits",
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w600),
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<ProductsProvider>(
                            builder: (context, pp, _) {
                          return ListView.builder(
                              itemCount: pp.productData.length,
                              itemBuilder: (ctx, i) {
                                return AddFruitItem(
                                  key: UniqueKey(),
                                  data: pp.productData[i],
                                  isEnabled: false,
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                ),
                if (isLoading)
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ))
              ]),
            ),
          );
        }),
      ),
    );
  }
}
*/
/*
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/popups.dart/my_fruits_list_popup.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/products_provider.dart';
import '../widgets/add_fruit_item.dart';
import '../popups.dart/warning_dialogue.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class AddFruitScreen extends StatefulWidget {
  AddFruitScreen({Key? key}) : super(key: key);

  @override
  _AddFruitScreenState createState() => _AddFruitScreenState();
}

class _AddFruitScreenState extends State<AddFruitScreen> {
  List<dynamic> addProductsData = [];
  List<dynamic> newProductsData = [];
  var navigationService = locator<NavigationService>();
  TextEditingController priceController = TextEditingController();

  bool isLoading = false;
  bool isEnabled = true;
  String tagId = ' ';

  @override
  void initState() {
    // data = Provider.of<ProductsProvider>(context, listen: false).getAllProducts;
    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;

    // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    // newProductsData = vendorData.products.addAll(addProductsData);
    // [...vendorData.products, ...addProductsData].toSet().toList();

    super.initState();
  }

  void active(val, String productPrice, bool isComingEnabled) {
    setState(() {
      tagId = val;
      isEnabled = isComingEnabled;
    });
    if (isEnabled) {
      var data = context
          .read<ProductsProvider>()
          .productData
          .firstWhere((element) => element.id == tagId);
      Provider.of<ProductsProvider>(context, listen: false).setSelectedProducts(
          id: data.id,
          name: data.name!,
          picture: data.picture,
          price: productPrice,
          unit: data.unit!,
          backgroundColor: data.backgroundColor!,
          description: data.description,
          context: context);
    } else {
      var data = context
          .read<ProductsProvider>()
          .productData
          .firstWhere((element) => element.id == tagId);
      Provider.of<ProductsProvider>(context, listen: false)
          .removeSelectedProducts(
        id: data.id,
        // name: data.name!,
        // picture: data.picture,
        // price: productPrice,
        // unit: data.unit!,
        // backgroundColor: data.backgroundColor!,
        // description: data.description,
        context: context,
      );
    }
  }

  void handleActiveTap(String productId, String productPrice) {
    setState(() {
      if (productPrice != '') {
        setState(() {
          isEnabled = true;
        });
      } else {
        setState(() {
          isEnabled = false;
        });
      }
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
    return WillPopScope(
      onWillPop: () async {
        navigationService.closeScreen();
        return false;
      },
      child: AbsorbPointer(
        absorbing: isLoading,
        child: Consumer<ProductsProvider>(builder: (context, pp, _) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: pp.tempSelectedProducts.length != 0
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
                // shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: double.infinity,
              child: FloatingActionButton(
                // splashColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                onPressed: () {
                  if (pp.tempSelectedProducts.length != 0) {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    // await Provider.of<ProductsProvider>(context, listen: false)
                    //     .postProducts(context);

                    Provider.of<ProductsProvider>(context, listen: false)
                        .selectedProducts
                        .addAll(pp.tempSelectedProducts);

                    navigationService.closeScreen();
                    pp.tempSelectedProducts.clear();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  pp.tempSelectedProducts.length != 0
                      ? "Submit "
                      : "Enter Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context
                                .read<ProductsProvider>()
                                .tempSelectedProducts
                                .length !=
                            0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      //navigationService.navigateTo(DriverHomeScreenRoute);
                      navigationService.closeScreen();
                    },
                    child: Image.asset(
                      'assets/images/ArrowBack.png',
                      fit: BoxFit.fill,
                      width: 10.h,
                      height: 10.h,
                    ),
                  ),
                ),

                centerTitle: true,

                title: Image.asset(
                  'assets/images/logoleaf.png',
                  scale: 14,
                  // color: Colors.white,
                ),
                bottomOpacity: 0.0,
                // backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
                    child: IconButton(
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (_) {
                        //       return WarningScreen();
                        //     });
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return MyFruitListPopup(
                                  // data: vendorData.products,
                                  // onItemClicked: active,
                                  );
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AddFruitListPopup();
                        //     });
                      },
                      icon: Image.asset(
                        'assets/images/add_icon.png',
                        // width: 40.h,
                        // height: 40.h,
                      ),
                      iconSize: 35.h,
                    ),
                  )
                ],
              ),
            ),
            body: Container(
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                          height: 32,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('DrawerAddFruits'),
                            // "   Add Fruits",
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w600),
                          )),
                    ),
                    Column(
                      children: [
                        for(int i=0;i<pp.productData.length;i++)
                        AddFruitItem(
                                  data: pp.productData[i],
                                  active: false,
                                  )

                    ],
                    ),


                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
<<<<<<< HEAD
<<<<<<< HEAD
                        child: ListView.builder(
=======
                        child: Consumer<ProductsProvider>(
                            builder: (context, pp, _) {
                          return ListView.builder(
>>>>>>> 9b2e68d (rizwan)
=======
                        child: ListView.builder(
>>>>>>> 2f0b011 (up)
                              itemCount: pp.productData.length,
                              
                              itemBuilder: (ctx, i) {
                                return AddFruitItem(
                                  data: pp.productData[i],
                                  active: false,
                                  // action: active,
                                  // priceController: priceController,
                                  // isEnabled: isEnabled,
                                  // activeTap: handleActiveTap,
                                  // tag: pp.productData[i].id,
                                  // active: tagId == pp.productData[i].id
                                  //     ? true
                                  //     : false,
                                );
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 2f0b011 (up)
                              })
                        // Consumer<ProductsProvider>(
                        //     builder: (context, pp, _) {
                        //   return ListView.builder(
                        //       itemCount: pp.productData.length,
                              
                        //       itemBuilder: (ctx, i) {
                        //         return AddFruitItem(
                        //           data: pp.productData[i],
                        //           // action: active,
                        //           // priceController: priceController,
                        //           // isEnabled: isEnabled,
                        //           // activeTap: handleActiveTap,
                        //           // tag: pp.productData[i].id,
                        //           // active: tagId == pp.productData[i].id
                        //           //     ? true
                        //           //     : false,
                        //         );
                        //       });
                        // }),
<<<<<<< HEAD
=======
                              });
                        }),
>>>>>>> 9b2e68d (rizwan)
=======
>>>>>>> 2f0b011 (up)
                      ),
                    ),
                    // SizedBox(
                    //   height: 50.h,
                    // )
                  ],
                ),
                if (isLoading)
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ))
              ]),
            ),
          );
        }),
      ),
    );
  }
<<<<<<< HEAD
<<<<<<< HEAD
}
*/
