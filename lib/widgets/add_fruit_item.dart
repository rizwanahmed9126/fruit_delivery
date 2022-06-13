/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';

class AddFruitItem extends StatefulWidget {
  final Products? data;
   bool active;
  //void Function(dynamic, String, bool)? action;
  //void Function(String, String)? activeTap;

  //String? tag;
  //bool isEnabled;
  //final active;
  AddFruitItem({
    Key? key,
    this.data,
    required this.active,
    //this.action,
    //this.activeTap,

    //this.tag,
    //required this.isEnabled,
    //this.active,
  }) : super(key: key);

  @override
  _AddFruitItemState createState() => _AddFruitItemState();
}

class _AddFruitItemState extends State<AddFruitItem> {
  //final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  // TextEditingController numController = TextEditingController();
  //bool active = false;

  TextEditingController priceController = TextEditingController();

  // void handletap() {
  //   // widget.action!(
  //   //   widget.tag!,
  //   //   numController.text,
  //   //   widget.isEnabled,
  //   // );

  //   widget.activeTap!(widget.tag!, priceController.text);
  //   // setState(() {
  //   //   widget.isEnabled = !widget.isEnabled;
  //   // });
  //   // if (numController.text != '') {
  //   //   setState(() {
  //   //     widget.isEnabled = true;
  //   //   });
  //   // } else {
  //   //   setState(() {
  //   //     widget.isEnabled = false;
  //   //   });
  //   // }

  //   // if (!widget!.isEnabled) {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(
  //   //     id: widget.data!.id,
  //   //     // name: widget.data.name,
  //   //     // picture: widget.data.picture,
  //   //     // price: numController.text,
  //   //     // unit: widget.data.unit
  //   //   );
  //   //   numController.text = '';
  //   // }

  //   // if (widget .isEnabled== false) {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(
  //   //           id: widget.data.id,
  //   //           name: widget.data.name,
  //   //           picture: widget.data.picture,
  //   //           price: numController.text,
  //   //           unit: widget.data.unit);
  //   // }
  //   //else {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(data);
  //   // }
  // }

  // @override
  // void initState() {
  //   // productData = Provider.of<ProductsProvider>(context, listen: false)
  //   //     .getSelectedProducts;
  //   // widget .isEnabled= productData.contains(this.widget.data);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                 widget.active = !widget.active;
                });
                //handletap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: this.widget.data!.backgroundColor == "orange"
                                ? Color.fromRGBO(254, 245, 236, 1)
                                : this.widget.data!.backgroundColor == " yellow"
                                    ? Color.fromRGBO(254, 248, 216, 1)
                                    : this.widget.data!.backgroundColor ==
                                            "green"
                                        ? Color.fromRGBO(238, 245, 227, 1)
                                        : this.widget.data!.backgroundColor ==
                                                "red"
                                            ? Color.fromRGBO(248, 232, 232, 1)
                                            : this
                                                        .widget
                                                        .data!
                                                        .backgroundColor ==
                                                    "peach"
                                                ? Color.fromRGBO(
                                                    254, 241, 230, 1)
                                                : this
                                                            .widget
                                                            .data!
                                                            .backgroundColor ==
                                                        "darkgreen"
                                                    ? Color.fromRGBO(
                                                        235, 241, 232, 1)
                                                    : Color.fromRGBO(
                                                        254, 241, 230, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 13.0, right: 13.0),
                          child: Image(
                            image: NetworkImage(this.widget.data!.picture!),
                            fit: BoxFit.fill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.widget.data!.name!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // color: Colors.red,
                            child: Text(
                              this.widget.data!.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PER ${this.widget.data!.unit}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 8.0.h,
                                height: 1.3,
                                color: widget.active //widget.isEnabled
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade600)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: widget.active //widget.isEnabled
                                            ? Color.fromRGBO(53, 187, 137, 1)
                                            : Color.fromRGBO(195, 208, 217, 1),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5))),
                                    child: Center(
                                      child: Text(
                                        "\$",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                        child: TextFormField(
                                      // maxLength: 2,
                                      // readOnly: active//widget.isEnabled
                                      // ? false : true,
                                      controller: priceController,
                                      onChanged: (var val) {
                                        // if ( active //widget.isEnabled
                                        // &&
                                        //     priceController.text != '') {
                                        //   // setState(() {
                                        //   //   active//widget.isEnabled
                                        //   //   = true;
                                        //   //   // widget.action!(
                                        //   //   //   widget.tag!,
                                        //   //   //   priceController.text,
                                        //   //   //   widget.isEnabled,
                                        //   //   // );
                                        //   // });
                                        //   // Provider.of<ProductsProvider>(context,
                                        //   //         listen: false)
                                        //   //     .setSelectedProducts(
                                        //   //         id: widget.data!.id!,
                                        //   //         name: widget.data!.name!,
                                        //   //         picture: widget.data!.picture,
                                        //   //         price: numController.text,
                                        //   //         unit: widget.data!.unit!,
                                        //   //         backgroundColor: this
                                        //   //             .widget
                                        //   //             .data!
                                        //   //             .backgroundColor!,
                                        //   //         description: this
                                        //   //             .widget
                                        //   //             .data!
                                        //   //             .description,
                                        //   //         context: context);
                                        // } else if (priceController.text == '') {
                                        //   setState(() {
                                        //     active
                                        //     //widget.isEnabled
                                        //     = false;
                                        //     // widget.action!(
                                        //     //     widget.tag!,
                                        //     //     priceController.text,
                                        //     //     active
                                        //     //     //widget.isEnabled
                                        //     //     );
                                        //   });
                                        //   // Provider.of<ProductsProvider>(context,
                                        //   //         listen: false)
                                        //   //     .removeSelectedProducts(
                                        //   //   id: widget.data!.id,
                                        //   // );
                                        // }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom: 12.h, left: 5.h),
                                          hintText: " ",
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      style: TextStyle(
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.bold,
                                          color: widget.active //widget.isEnabled
                                              ? Colors.black
                                              : Colors.white),
                                    ))),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: CircleAvatar(
                          backgroundColor: widget.active //widget.isEnabled
                              ? Color.fromRGBO(53, 187, 137, 1)
                              : Color.fromRGBO(195, 208, 217, 1),
                          radius: 13,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

class AddFruitItem extends StatefulWidget {
  final Products? data;
  bool isEnabled;
  AddFruitItem({this.data, required this.isEnabled, Key? key})
      : super(key: key);

  @override
  _AddFruitItemState createState() => _AddFruitItemState();
}

class _AddFruitItemState extends State<AddFruitItem> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  TextEditingController numController = TextEditingController();
  bool? isActive = false;
/*
  void handletap() {
    if (numController.text != '') {
      setState(() {
        isActive = !isActive!;
      });
    } else {
      setState(() {
        isActive = !isActive!;
      });
    }

    if (!isActive!) {
      Provider.of<ProductsProvider>(context, listen: false)
          .removeSelectedProducts(
        id: widget.data!.id,
        // name: widget.data.name,
        // picture: widget.data.picture,
        // price: numController.text,
        // unit: widget.data.unit
      );
      numController.text = '';
    }
    // if (isActive == false) {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .removeSelectedProducts(
    //           id: widget.data.id,
    //           name: widget.data.name,
    //           picture: widget.data.picture,
    //           price: numController.text,
    //           unit: widget.data.unit);
    // }
    //else {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .removeSelectedProducts(data);
    // }
  }
*/

  void handletap() {
    // setState(() {
    //   widget.isEnabled = !widget.isEnabled;
    // });
    if (numController.text != '') {
      setState(() {
        isActive = false;
      });
    } else {
      setState(() {
        isActive = true;
      });
    }
    // widget.action!(
    //   widget.tag!,
    //   numController.text,
    // );

    // if (!widget!.isEnabled) {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .removeSelectedProducts(
    //     id: widget.data!.id,
    //     // name: widget.data.name,
    //     // picture: widget.data.picture,
    //     // price: numController.text,
    //     // unit: widget.data.unit
    //   );
    //   numController.text = '';
    // }

    // if (widget .isEnabled== false) {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .removeSelectedProducts(
    //           id: widget.data.id,
    //           name: widget.data.name,
    //           picture: widget.data.picture,
    //           price: numController.text,
    //           unit: widget.data.unit);
    // }
    //else {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .removeSelectedProducts(data);
    // }
  }

  // @override
  // void initState() {
  //   // productData = Provider.of<ProductsProvider>(context, listen: false)
  //   //     .getSelectedProducts;
  //   // isActive = widget.isEnabled;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                handletap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: this.widget.data!.backgroundColor == "orange"
                                ? Color.fromRGBO(254, 245, 236, 1)
                                : this.widget.data!.backgroundColor == " yellow"
                                    ? Color.fromRGBO(254, 248, 216, 1)
                                    : this.widget.data!.backgroundColor ==
                                            "green"
                                        ? Color.fromRGBO(238, 245, 227, 1)
                                        : this.widget.data!.backgroundColor ==
                                                "red"
                                            ? Color.fromRGBO(248, 232, 232, 1)
                                            : this
                                                        .widget
                                                        .data!
                                                        .backgroundColor ==
                                                    "peach"
                                                ? Color.fromRGBO(
                                                    254, 241, 230, 1)
                                                : this
                                                            .widget
                                                            .data!
                                                            .backgroundColor ==
                                                        "darkgreen"
                                                    ? Color.fromRGBO(
                                                        235, 241, 232, 1)
                                                    : Color.fromRGBO(
                                                        254, 241, 230, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 13.0, right: 13.0),
                          child: Image(
                            image: NetworkImage(this.widget.data!.picture!),
                            fit: BoxFit.fill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.widget.data!.name!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // color: Colors.red,
                            child: Text(
                              this.widget.data!.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PER ${this.widget.data!.unit}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 8.0.h,
                                height: 1.3,
                                color: isActive!
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade600)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: isActive!
                                              ? Color.fromRGBO(53, 187, 137, 1)
                                              : Color.fromRGBO(
                                                  195, 208, 217, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          "\$",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                        child: TextFormField(
                                      // maxLength: 2,
                                      readOnly: isActive! ? false : true,
                                      controller: numController,
                                      onChanged: (var val) {
                                        if (isActive! &&
                                            numController.text != '') {
                                          Provider.of<ProductsProvider>(context,
                                                  listen: false)
                                              .setSelectedProducts(
                                                  id: widget.data!.id!,
                                                  name: widget.data!.name!,
                                                  picture: widget.data!.picture,
                                                  price: numController.text,
                                                  unit: widget.data!.unit!,
                                                  backgroundColor: this
                                                      .widget
                                                      .data!
                                                      .backgroundColor!,
                                                  description: this
                                                      .widget
                                                      .data!
                                                      .description,
                                                  context: context);
                                        } else if (numController.text == '') {
                                          Provider.of<ProductsProvider>(context,
                                                  listen: false)
                                              .removeSelectedProducts(
                                            id: widget.data!.id,
                                          );
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom: 12.h, left: 5.h),
                                          hintText: " ",
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      style: TextStyle(
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.bold,
                                          color: isActive!
                                              ? Colors.black
                                              : Colors.white),
                                    ))),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: CircleAvatar(
                          backgroundColor: isActive!
                              ? Color.fromRGBO(53, 187, 137, 1)
                              : Color.fromRGBO(195, 208, 217, 1),
                          radius: 13,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddFruitItem extends StatefulWidget {
  final Products? data;


  AddFruitItem({
    this.data,
  });

  @override
  _AddFruitItemState createState() => _AddFruitItemState();
}

class _AddFruitItemState extends State<AddFruitItem> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  TextEditingController numController = TextEditingController();
  bool? isActive = false;

  void handletap() {
    if (numController.text != '') {
      setState(() {
        isActive = !isActive!;
      });
    } else {
      setState(() {
        isActive = !isActive!;
      });
    }
  }

  // void handletap() {
  //   if (numController.text != '') {
  //     setState(() {
  //       widget.action!(widget.tag!);
  //     });
  //   } else {
  //     setState(() {
  //       widget.action!(widget.tag!);
  //     });
  //   }

  //   if (!isActive!) {
  //     Provider.of<ProductsProvider>(context, listen: false)
  //         .removeTempSelectedProducts(
  //       id: widget.data!.id,
  //       // name: widget.data.name,
  //       // picture: widget.data.picture,
  //       // price: numController.text,
  //       // unit: widget.data.unit
  //     );
  //     numController.text = '';
  //   }
  //   // if (isActive == false) {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(
  //   //           id: widget.data.id,
  //   //           name: widget.data.name,
  //   //           picture: widget.data.picture,
  //   //           price: numController.text,
  //   //           unit: widget.data.unit);
  //   // }
  //   //else {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(data);
  //   // }
  // }

  @override
  void initState() {
    // productData = Provider.of<ProductsProvider>(context, listen: false)
    //     .getSelectedProducts;
    // isActive = productData.contains(this.widget.data);
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
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                handletap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: this.widget.data!.backgroundColor == "orange"
                                ? Color.fromRGBO(254, 245, 236, 1)
                                : this.widget.data!.backgroundColor == " yellow"
                                    ? Color.fromRGBO(254, 248, 216, 1)
                                    : this.widget.data!.backgroundColor ==
                                            "green"
                                        ? Color.fromRGBO(238, 245, 227, 1)
                                        : this.widget.data!.backgroundColor ==
                                                "red"
                                            ? Color.fromRGBO(248, 232, 232, 1)
                                            : this
                                                        .widget
                                                        .data!
                                                        .backgroundColor ==
                                                    "peach"
                                                ? Color.fromRGBO(
                                                    254, 241, 230, 1)
                                                : this
                                                            .widget
                                                            .data!
                                                            .backgroundColor ==
                                                        "darkgreen"
                                                    ? Color.fromRGBO(
                                                        235, 241, 232, 1)
                                                    : Color.fromRGBO(
                                                        254, 241, 230, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 13.0, right: 13.0),
                          child: Image(
                            image: NetworkImage(this.widget.data!.picture!),
                            fit: BoxFit.fill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.widget.data!.name!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // color: Colors.red,
                            child: Text(
                              this.widget.data!.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PER ${this.widget.data!.unit}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 8.0.h,
                                height: 1.3,
                                color: isActive!
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade600)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: isActive!
                                              ? Color.fromRGBO(53, 187, 137, 1)
                                              : Color.fromRGBO(
                                                  195, 208, 217, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          "\$",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                    child: Platform.isAndroid
                                        ? TextFormField(
                                            // maxLength: 2,
                                            readOnly: isActive! ? false : true,
                                            controller: numController,
                                            onEditingComplete: () {
                                              FocusScope.of(context).unfocus();

                                              if (isActive! &&
                                                  numController.text != '') {
                                                Provider.of<
                                                            ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedProducts(
                                                        id: widget.data!.id!,
                                                        name:
                                                            widget.data!.name!,
                                                        picture: widget
                                                            .data!.picture,
                                                        price:
                                                            numController.text,
                                                        unit:
                                                            widget.data!.unit!,
                                                        backgroundColor: this
                                                            .widget
                                                            .data!
                                                            .backgroundColor!,
                                                        description: this
                                                            .widget
                                                            .data!
                                                            .description,
                                                        context: context);
                                              } else if (numController.text ==
                                                  '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeTempSelectedProducts(
                                                        id: widget.data!.id,
                                                        context: context);
                                                //     (
                                                //   id: widget.data!.id,
                                                // );
                                              }
                                              numController.text = '';
                                              setState(() {
                                                isActive = false;
                                              });
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true,
                                                    decimal: true),
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 12.h, left: 5.h),
                                                hintText: " ",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide
                                                            .none),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight: FontWeight.bold,
                                                color: isActive!
                                                    ? Colors.black
                                                    : Colors.white),
                                          )
                                        : CupertinoTextField(
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d+\.?\d{0,4}'))
                                            ],
                                            readOnly: isActive! ? false : true,
                                            controller: numController,

                                            onEditingComplete: () {
                                              FocusScope.of(context).unfocus();

                                              if (isActive! &&
                                                  numController.text != '') {
                                                Provider.of<
                                                            ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedProducts(
                                                        id: widget.data!.id!,
                                                        name:
                                                            widget.data!.name!,
                                                        picture: widget
                                                            .data!.picture,
                                                        price:
                                                            numController.text,
                                                        unit:
                                                            widget.data!.unit!,
                                                        backgroundColor: this
                                                            .widget
                                                            .data!
                                                            .backgroundColor!,
                                                        description: this
                                                            .widget
                                                            .data!
                                                            .description,
                                                        context: context);
                                              } else if (numController.text ==
                                                  '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeTempSelectedProducts(
                                                        id: widget.data!.id,
                                                        context: context);
                                                //     (
                                                //   id: widget.data!.id,
                                                // );
                                              }
                                              numController.text = '';
                                              setState(() {
                                                isActive = false;
                                              });
                                            },
                                            onChanged: (var val) {},
                                            // decoration: BoxDecoration(
                                            //     contentPadding: EdgeInsets.only(
                                            //         bottom: 12.h, left: 5.h),
                                            //     hintText: " ",
                                            //     enabledBorder:
                                            //         UnderlineInputBorder(
                                            //             borderSide: BorderSide
                                            //                 .none),
                                            //     focusedBorder:
                                            //         UnderlineInputBorder(
                                            //             borderSide:
                                            //                 BorderSide.none)),
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight: FontWeight.bold,
                                                color: isActive!
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: CircleAvatar(
                          backgroundColor: isActive!
                              ? Color.fromRGBO(53, 187, 137, 1)
                              : Color.fromRGBO(195, 208, 217, 1),
                          radius: 13,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddFruitItem extends StatefulWidget {
  final Products? data;
  final int? isActiveID;

  AddFruitItem({
    this.data,
    this.isActiveID,
  });

  @override
  _AddFruitItemState createState() => _AddFruitItemState();
}

class _AddFruitItemState extends State<AddFruitItem> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  TextEditingController numController = TextEditingController();
  //bool? isActive = false;
  bool abc = false;

  void handletap() {
    abc = !abc;
    Provider.of<ProductsProvider>(context, listen: false).changeValue(
        widget.isActiveID!,
        isActiveModel(value: numController.text, isActive: abc));
    // print(Provider.of<ProductsProvider>(context, listen: false)
    //     .isActive[widget.isActiveID!]);
    // Provider.of<ProductsProvider>(context, listen: false)
    //         .isActive[widget.isActiveID!] =
    //     !Provider.of<ProductsProvider>(context, listen: false)
    //         .isActive[widget.isActiveID!];

    // if (numController.text != '') {
    //   setState(() {
    //     isActive = !isActive!;
    //   });
    // } else {
    //   setState(() {
    //     isActive = !isActive!;
    //   });
    // }
  }

  // void handletap() {
  //   if (numController.text != '') {
  //     setState(() {
  //       widget.action!(widget.tag!);
  //     });
  //   } else {
  //     setState(() {
  //       widget.action!(widget.tag!);
  //     });
  //   }

  //   if (!isActive!) {
  //     Provider.of<ProductsProvider>(context, listen: false)
  //         .removeTempSelectedProducts(
  //       id: widget.data!.id,
  //       // name: widget.data.name,
  //       // picture: widget.data.picture,
  //       // price: numController.text,
  //       // unit: widget.data.unit
  //     );
  //     numController.text = '';
  //   }
  //   // if (isActive == false) {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(
  //   //           id: widget.data.id,
  //   //           name: widget.data.name,
  //   //           picture: widget.data.picture,
  //   //           price: numController.text,
  //   //           unit: widget.data.unit);
  //   // }
  //   //else {
  //   //   Provider.of<ProductsProvider>(context, listen: false)
  //   //       .removeSelectedProducts(data);
  //   // }
  // }

  @override
  void initState() {
    numController.text = Provider.of<ProductsProvider>(context, listen: false)
        .isActive[widget.isActiveID!]
        .value;
    // productData = Provider.of<ProductsProvider>(context, listen: false)
    //     .getSelectedProducts;
    // isActive = productData.contains(this.widget.data);
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
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                handletap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: this.widget.data!.backgroundColor == "orange"
                                ? Color.fromRGBO(254, 245, 236, 1)
                                : this.widget.data!.backgroundColor == " yellow"
                                    ? Color.fromRGBO(254, 248, 216, 1)
                                    : this.widget.data!.backgroundColor ==
                                            "green"
                                        ? Color.fromRGBO(238, 245, 227, 1)
                                        : this.widget.data!.backgroundColor ==
                                                "red"
                                            ? Color.fromRGBO(248, 232, 232, 1)
                                            : this
                                                        .widget
                                                        .data!
                                                        .backgroundColor ==
                                                    "peach"
                                                ? Color.fromRGBO(
                                                    254, 241, 230, 1)
                                                : this
                                                            .widget
                                                            .data!
                                                            .backgroundColor ==
                                                        "darkgreen"
                                                    ? Color.fromRGBO(
                                                        235, 241, 232, 1)
                                                    : Color.fromRGBO(
                                                        254, 241, 230, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 13.0, right: 13.0),
                          child: Image(
                            image: NetworkImage(this.widget.data!.picture!),
                            fit: BoxFit.fill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.widget.data!.name!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // color: Colors.red,
                            child: Text(
                              this.widget.data!.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.shade400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PER ${this.widget.data!.unit}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 8.0.h,
                                height: 1.3,
                                color: Provider.of<ProductsProvider>(context,
                                            listen: false)
                                        .isActive[widget.isActiveID!]
                                        .isActive
                                    ? Colors.black
                                    : Colors.grey.shade400),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade600)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Provider.of<ProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .isActive[widget.isActiveID!]
                                                  .isActive
                                              ? Color.fromRGBO(53, 187, 137, 1)
                                              : Color.fromRGBO(
                                                  195, 208, 217, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          "\$",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                    child: Platform.isAndroid
                                        ? TextFormField(
                                            // maxLength: 2,

                                            readOnly:
                                                Provider.of<ProductsProvider>(
                                                            context,
                                                            listen: false)
                                                        .isActive[
                                                            widget.isActiveID!]
                                                        .isActive
                                                    ? false
                                                    : true,
                                            controller: numController,
                                            onChanged: (var val) {
                                              Provider.of<ProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeValue(
                                                widget.isActiveID!,
                                                isActiveModel(
                                                    value: numController.text,
                                                    isActive: numController
                                                            .text.isNotEmpty
                                                        ? true
                                                        : false),
                                              );
                                              // FocusScope.of(context).unfocus();

                                              if (Provider.of<ProductsProvider>(
                                                          context,
                                                          listen: false)
                                                      .isActive[
                                                          widget.isActiveID!]
                                                      .isActive ||
                                                  Provider.of<ProductsProvider>(
                                                              context,
                                                              listen: false)
                                                          .isActive[widget
                                                              .isActiveID!]
                                                          .value !=
                                                      '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .setTempSelectedProducts(
                                                        id: widget.data!.id!,
                                                        name:
                                                            widget.data!.name!,
                                                        picture: widget
                                                            .data!.picture,
                                                        price: context
                                                            .read<
                                                                ProductsProvider>()
                                                            .isActive[widget
                                                                .isActiveID!]
                                                            .value,
                                                        unit:
                                                            widget.data!.unit!,
                                                        backgroundColor: this
                                                            .widget
                                                            .data!
                                                            .backgroundColor!,
                                                        description: this
                                                            .widget
                                                            .data!
                                                            .description,
                                                        context: context);
                                              } else if (context
                                                      .read<ProductsProvider>()
                                                      .isActive[
                                                          widget.isActiveID!]
                                                      .value ==
                                                  '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeTempSelectedProducts(
                                                        id: widget.data!.id,
                                                        context: context);
                                                //     (
                                                //   id: widget.data!.id,
                                                // );
                                              }
                                              // numController.text = '';
                                              // setState(() {
                                              //   Provider.of<ProductsProvider>(
                                              //           context,
                                              //           listen: false)
                                              //       .isActive[
                                              //           widget.isActiveID!]
                                              //       .isActive = false;
                                              // });
                                            },

                                            textInputAction:
                                                TextInputAction.done,

                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ], // Only numbers can be entered
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true,
                                                    decimal: true),
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 12.h, left: 5.h),
                                                hintText: " ",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide
                                                            .none),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .isActive[widget
                                                                .isActiveID!]
                                                            .isActive
                                                        ? Colors.black
                                                        : Colors.white),
                                          )
                                        : CupertinoTextField(
                                            // onSubmitted: (val) {
                                            //   print(val);
                                            // },
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                              signed: true,
                                              decimal: true,
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d+\.?\d{0,4}'))
                                            ],
                                            readOnly:
                                                Provider.of<ProductsProvider>(
                                                            context,
                                                            listen: false)
                                                        .isActive[
                                                            widget.isActiveID!]
                                                        .isActive
                                                    ? false
                                                    : true,
                                            controller: numController,
                                            onChanged: (var val) {
                                              Provider.of<ProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeValue(
                                                widget.isActiveID!,
                                                isActiveModel(
                                                    value: numController.text,
                                                    isActive: numController
                                                            .text.isNotEmpty
                                                        ? true
                                                        : false),
                                              );
                                              // FocusScope.of(context).unfocus();

                                              if (Provider.of<ProductsProvider>(
                                                          context,
                                                          listen: false)
                                                      .isActive[
                                                          widget.isActiveID!]
                                                      .isActive ||
                                                  Provider.of<ProductsProvider>(
                                                              context,
                                                              listen: false)
                                                          .isActive[widget
                                                              .isActiveID!]
                                                          .value !=
                                                      '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .setTempSelectedProducts(
                                                        id: widget.data!.id!,
                                                        name:
                                                            widget.data!.name!,
                                                        picture: widget
                                                            .data!.picture,
                                                        price: context
                                                            .read<
                                                                ProductsProvider>()
                                                            .isActive[widget
                                                                .isActiveID!]
                                                            .value,
                                                        unit:
                                                            widget.data!.unit!,
                                                        backgroundColor: this
                                                            .widget
                                                            .data!
                                                            .backgroundColor!,
                                                        description: this
                                                            .widget
                                                            .data!
                                                            .description,
                                                        context: context);
                                              } else if (context
                                                      .read<ProductsProvider>()
                                                      .isActive[
                                                          widget.isActiveID!]
                                                      .value ==
                                                  '') {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeTempSelectedProducts(
                                                        id: widget.data!.id,
                                                        context: context);
                                                //     (
                                                //   id: widget.data!.id,
                                                // );
                                              }
                                              // numController.text = '';
                                              // setState(() {
                                              //   Provider.of<ProductsProvider>(
                                              //           context,
                                              //           listen: false)
                                              //       .isActive[
                                              //           widget.isActiveID!]
                                              //       .isActive = false;
                                              // });
                                            },
                                            // decoration: BoxDecoration(
                                            //     contentPadding: EdgeInsets.only(
                                            //         bottom: 12.h, left: 5.h),
                                            //     hintText: " ",
                                            //     enabledBorder:
                                            //         UnderlineInputBorder(
                                            //             borderSide: BorderSide
                                            //                 .none),
                                            //     focusedBorder:
                                            //         UnderlineInputBorder(
                                            //             borderSide:
                                            //                 BorderSide.none)),
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .isActive[widget
                                                                .isActiveID!]
                                                            .isActive
                                                        ? Colors.black
                                                        : Colors.white),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: CircleAvatar(
                          backgroundColor: Provider.of<ProductsProvider>(
                                      context,
                                      listen: false)
                                  .isActive[widget.isActiveID!]
                                  .isActive
                              ? Color.fromRGBO(53, 187, 137, 1)
                              : Color.fromRGBO(195, 208, 217, 1),
                          radius: 13,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
