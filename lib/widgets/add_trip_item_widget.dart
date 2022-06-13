import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

class AddItems extends StatefulWidget {
  bool? active;
  final Products data;
  AddItems({required this.data, this.active});

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  var navigationService = locator<NavigationService>();
  bool? isActive = false;

  void handletap() {
    setState(() {
      isActive = !isActive!;
    });
    if (!isActive!) {
      Provider.of<ProductsProvider>(context, listen: false)
          .removeTempSelectedProducts(id: widget.data.id, context: context);
    } else if (isActive!) {
      Provider.of<ProductsProvider>(context, listen: false).setSelectedProducts(
          id: widget.data.id,
          name: widget.data.name,
          picture: widget.data.picture,
          price: widget.data.price,
          createdOnDate: widget.data.createdOnDate,
          backgroundColor: widget.data.backgroundColor,
          context: context);
    }
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
              onTap: handletap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: this.widget.data.backgroundColor == "orange"
                                ? Color.fromRGBO(254, 245, 236, 1)
                                : this.widget.data.backgroundColor == " yellow"
                                    ? Color.fromRGBO(254, 248, 216, 1)
                                    : this.widget.data.backgroundColor ==
                                            "green"
                                        ? Color.fromRGBO(238, 245, 227, 1)
                                        : this.widget.data.backgroundColor ==
                                                "red"
                                            ? Color.fromRGBO(248, 232, 232, 1)
                                            : this.widget.data.backgroundColor ==
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
                              top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
                          child: Image(
                            image: NetworkImage(widget.data.picture!),
                            fit: BoxFit.contain,
                            height: 22,
                            width: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.name!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          // RichText(
                          //   Tex
                          //   Text(
                          //     "PER KG",
                          //     style: TextStyle(
                          //         fontSize: 8.0.h,
                          //         height: 1.3,
                          //         color: isactive!
                          //             ? Colors.black
                          //             : Colors.grey.shade400),
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              // RichText(
                              //   text: TextSpan(
                              //     text: this.widget.data.price,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.black54,
                              //         fontSize: 12),
                              //     children: const <TextSpan>[
                              //       // TextSpan(
                              //       //   text: this.widget.data.unit,
                              //       //   style: TextStyle(
                              //       //       color: Colors.grey, fontSize: 9),
                              //       // ),
                              //     ],
                              //   ),
                              // ),
                              Text(
                                // this.widget.data.price.toString(),
                                "\$${widget.data.price} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 12),
                              ),
                              Text(
                                widget.data.unit!,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // GestureDetector(
                      //   onTap: ()  {
                      //     setState(() {
                      //       isActive = !isActive!;
                      //     });

                      // if (isActive!) {
                      //   await Provider.of<ProductsProvider>(context,
                      //           listen: false)
                      //       .setSelectedProducts(
                      //     id: widget.data.id,
                      //     name: widget.data.name,
                      //     picture: widget.data.picture,
                      //     price: widget.data.price,
                      //     createdOnDate: widget.data.createdOnDate,
                      //     backgroundColor: this.widget.data.backgroundColor,

                      //   );
                      // }
                      // },
                      // child:
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
                      ),
                      // )
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
