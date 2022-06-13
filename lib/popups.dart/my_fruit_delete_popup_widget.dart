// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers/vendor_provider.dart';
import '../providers/products_provider.dart';

class DeletePopupWidget extends StatefulWidget {
  final data;
  final ValueChanged<bool> onItemClicked;
  DeletePopupWidget(this.data, this.onItemClicked);

  // DeletePopupWidget(this.onItemClicked);

  @override
  _DeletePopupWidgetState createState() => _DeletePopupWidgetState();
}

class _DeletePopupWidgetState extends State<DeletePopupWidget> {
  var vendorData;
  var isLoadingProgress = false;
  @override
  void initState() {
    vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoadingProgress,
      child: Stack(children: [
        AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
          content: Container(
            height: 160,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Are You Sure You Want To Delete This Item!',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoadingProgress = true;
                            });
                            for (int i = 0;
                                i < vendorData.products.length;
                                i++) {
                              if (vendorData.products[i]['id'] ==
                                  widget.data['id']) {
                                vendorData.products.removeAt(i);
                              }
                            }

                            await Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .deleteProducts(vendorData.products, context);
                            widget.onItemClicked(true);

                            setState(() {
                              isLoadingProgress = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w600),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.30,
                                MediaQuery.of(context).size.height * 0.060),
                            primary: Theme.of(context).accentColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).accentColor)),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(left: 5, right: 10),
                              child: new Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w600),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.30,
                                MediaQuery.of(context).size.height * 0.060),
                            primary: Colors.red,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                                side: BorderSide(width: 1, color: Colors.red)),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(left: 5, right: 10),
                              child: new Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
        if (isLoadingProgress)
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Platform.isIOS?
          CupertinoActivityIndicator():
           CircularProgressIndicator(),
          )),
      ]),
    );
  }
}
