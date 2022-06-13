import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../models/add_trip_item_model.dart';

import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import '../widgets/add_trip_item_widget.dart';

class AddTripItemScreen extends StatefulWidget {
  AddTripItemScreen({Key? key}) : super(key: key);

  @override
  _AddTripItemScreenState createState() => _AddTripItemScreenState();
}

class _AddTripItemScreenState extends State<AddTripItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var utilService = locator<UtilService>();
  var navigationService = locator<NavigationService>();
  List<dynamic> addProductsData = [];
  List<dynamic> newProductsData = [];
  bool isLoadingProgress = false;
  bool isLoading = false;
  var vendorData;

  // var data = [];
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
    // data = Provider.of<ProductsProvider>(context, listen: false).getAllProducts;

    vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
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
        // navigationService.navigateTo(DriverHomeScreenRoute);
        navigationService.closeScreen();
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Consumer<ProductsProvider>(builder: (context, pp, _) {
          print("data: ${pp.selectedProducts.length}");
          return pp.selectedProducts.length != 0
              ? Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                    // shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  width: double.infinity,
                  child:
                      //  Provider.of<ProductsProvider>(context, listen: false)
                      //         .selectedProducts
                      //         .isEmpty
                      //     ? Container()
                      // :
                      FloatingActionButton(
                    // splashColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    onPressed: () async {
                      if (context
                              .read<ProductsProvider>()
                              .selectedProducts
                              .length ==
                          0) {
                        return null;
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        // await Provider.of<ProductsProvider>(context,
                        //         listen: false)
                        //     .postTripProduct(context);
                        // navigationService
                        //     .navigateTo(CreateRouteScreenMyItemsRoute);

                        navigationService.closeScreen();
                      }
                      // if (Provider.of<ProductsProvider>(context, listen: false)
                      //     .selectedProducts.length != null) {
                      //        FocusScope.of(context).unfocus();
                      // await Provider.of<ProductsProvider>(context, listen: false)
                      //     .postTripProduct(context);

                      //     }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('Submit'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : Container();
        }),
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.white,

            leading: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: GestureDetector(
                onTap: () {
                  navigationService.navigateTo(CreateRouteFormScreenRoute);
                },
                child: Image.asset(
                  'assets/images/ArrowBack.png',
                  fit: BoxFit.fill,
                  width: 10.h,
                  height: 10.h,
                ),
              ),
            ),

            title: Text(
              "Add Trip Items",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AddFruitListPopup(
                  //           // data: vendorData.products,
                  //           // onItemClicked: active,
                  //           );
                  //     });
                },
                icon: Image.asset(
                  'assets/images/add_icon.png',
                  fit: BoxFit.fill,
                ),
                iconSize: 30.h,
              )
            ],
            bottomOpacity: 0.0,
            // backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 8.w,
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(242, 243, 245, 1),
                              width: 1.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(242, 243, 245, 1),
                              width: 1.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(242, 243, 245, 1),
                              width: 1.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        hintStyle:
                            new TextStyle(color: Colors.grey, fontSize: 12.sp),
                        hintText: "Search for a food",
                        fillColor: Color.fromRGBO(242, 243, 245, 1),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 6.0, left: 8.0, right: 8.0, bottom: 60),
                      child: ListView.builder(
                          itemCount: context
                              .read<ProductsProvider>()
                              .getAllProducts
                              .length,
                          itemBuilder: (ctx, i) {
                            return AddItems(
                              data: context
                                  .read<ProductsProvider>()
                                  .getAllProducts[i],
                            );
                          }),
                    ),
                  ),
                ],
              ),
              if (isLoading)
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
