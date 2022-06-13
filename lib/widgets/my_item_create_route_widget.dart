import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/popups.dart/my_fruit_delete_popup_widget.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:provider/provider.dart';

class MyItemsList extends StatefulWidget {
  final Products data;
  final ValueChanged<bool>? active;
  MyItemsList({required this.data, this.active});

  @override
  _MyItemsListState createState() => _MyItemsListState();
}

class _MyItemsListState extends State<MyItemsList> {
  bool? isactive = false;
  var vendorData;

  void handletap() {
    setState(() {
      isactive = !isactive!;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   // vendorData = Provider.of<ProductsProvider>(context,listen: false).selectedProducts;
  //   ScreenUtil.init(
  //       BoxConstraints(
  //           maxWidth: MediaQuery.of(context).size.width,
  //           maxHeight: MediaQuery.of(context).size.height),
  //       designSize: Size(360, 690),
  //       orientation: Orientation.portrait);
  //   return Container(
  //     margin: EdgeInsets.only(top: 5),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //       child: Column(
  //         children: [
  //           GestureDetector(
  //             onTap: handletap,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Tooltip(
  //                       message: this.widget.data["description"],
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                             color: this.widget.data["backgroundColor"] ==
  //                                     "orange"
  //                                 ? Color.fromRGBO(254, 245, 236, 1)
  //                                 : this.widget.data["backgroundColor"] ==
  //                                         " yellow"
  //                                     ? Color.fromRGBO(254, 248, 216, 1)
  //                                     : this.widget.data["backgroundColor"] ==
  //                                             "green"
  //                                         ? Color.fromRGBO(238, 245, 227, 1)
  //                                         : this.widget.data[
  //                                                     "backgroundColor"] ==
  //                                                 "red"
  //                                             ? Color.fromRGBO(248, 232, 232, 1)
  //                                             : this.widget.data[
  //                                                         "backgroundColor"] ==
  //                                                     "peach"
  //                                                 ? Color.fromRGBO(
  //                                                     254, 241, 230, 1)
  //                                                 : this
  //                                                                 .widget
  //                                                                 .data[
  //                                                             "backgroundColor"] ==
  //                                                         "darkgreen"
  //                                                     ? Color.fromRGBO(
  //                                                         235, 241, 232, 1)
  //                                                     : Color.fromRGBO(
  //                                                         254, 241, 230, 1),
  //                             borderRadius: BorderRadius.circular(10)),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(
  //                               top: 15.0,
  //                               bottom: 15.0,
  //                               left: 10.0,
  //                               right: 10.0),
  //                           child: Image(
  //                             image: NetworkImage(this.widget.data["picture"],
  //                                 scale: 3),
  //                             fit: BoxFit.fill,
  //                             height: 25,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 15,
  //                     ),
  //                     Text(
  //                       this.widget.data["name"],
  //                       style: TextStyle(fontWeight: FontWeight.w600),
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () {

  //                       },
  //                       child: Container(
  //                         margin: EdgeInsets.only(top: 8),
  //                         child: CircleAvatar(
  //                           backgroundColor: isactive!
  //                               ? Color.fromRGBO(53, 187, 137, 1)
  //                               : Color.fromRGBO(195, 208, 217, 1),
  //                           radius: 13,
  //                           child: Icon(
  //                             Icons.close,
  //                             size: 16,
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Divider()
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // vendorData = Provider.of<ProductsProvider>(context,listen: false).selectedProducts;
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
              onTap: handletap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Tooltip(
                        message: "${widget.data.backgroundColor ?? 'null'}",
                        child: Container(
                          decoration: BoxDecoration(
                              color: this.widget.data.backgroundColor ==
                                      "orange"
                                  ? Color.fromRGBO(254, 245, 236, 1)
                                  : this.widget.data.backgroundColor ==
                                          " yellow"
                                      ? Color.fromRGBO(254, 248, 216, 1)
                                      : this.widget.data.backgroundColor ==
                                              "green"
                                          ? Color.fromRGBO(238, 245, 227, 1)
                                          : this.widget.data.backgroundColor ==
                                                  "red"
                                              ? Color.fromRGBO(248, 232, 232, 1)
                                              : this
                                                          .widget
                                                          .data
                                                          .backgroundColor ==
                                                      "peach"
                                                  ? Color.fromRGBO(
                                                      254, 241, 230, 1)
                                                  : this
                                                              .widget
                                                              .data
                                                              .backgroundColor ==
                                                          "darkgreen"
                                                      ? Color.fromRGBO(
                                                          235, 241, 232, 1)
                                                      : Color.fromRGBO(
                                                          254, 241, 230, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 10.0,
                                right: 10.0),
                            child: Image(
                              image: NetworkImage(this.widget.data.picture!,
                                  scale: 3),
                              fit: BoxFit.cover,
                              height: 30.h,
                              width: 35.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.data.name!,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Provider.of<ProductsProvider>(context, listen: false)
                              .removeSelectedProducts(
                                  id: widget.data.id, context: context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: CircleAvatar(
                            backgroundColor: isactive!
                                ? Color.fromRGBO(53, 187, 137, 1)
                                : Color.fromRGBO(195, 208, 217, 1),
                            radius: 13,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
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
