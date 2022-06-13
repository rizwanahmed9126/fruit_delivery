// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_delivery_flutter/globals.dart';
// import 'package:fruit_delivery_flutter/local/app_localization.dart';
// import 'package:fruit_delivery_flutter/models/products_model.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
// import 'package:fruit_delivery_flutter/providers/products_provider.dart';
// import 'package:fruit_delivery_flutter/services/navigation_service.dart';
// import 'package:fruit_delivery_flutter/services/util_service.dart';
// import 'package:fruit_delivery_flutter/utils/service_locator.dart';
// import 'package:provider/provider.dart';

// class AddFruitListPopup extends StatefulWidget {
//   // final data;
//   // final ValueChanged<bool> onItemClicked;
//   const AddFruitListPopup();

//   @override
//   _AddFruitListPopupState createState() => _AddFruitListPopupState();
// }

// class _AddFruitListPopupState extends State<AddFruitListPopup> {
//   var utilService = locator<UtilService>();
//   var navigationService = locator<NavigationService>();
//   String? imageUrl = '';

//   var isLoadingProgress = false;
//   Products? newProductData;

//   String? value = 'KG';
//   List<String> menuitems = ['Boxes', 'KG', 'Pound'];
//   bool disabledropdown = true;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController priceController = TextEditingController();

//   // final group_a = {
//   //   "1": "BOXES",
//   //   "2": "KG",
//   //   "3": "POUND",
//   // };

//   // void populateA() {
//   //   for (String key in group_a.keys) {
//   //     menuitems.add(DropdownMenuItem<String>(
//   //       child: Center(
//   //         child: Text(group_a[key]!),
//   //       ),
//   //       value: group_a[key],
//   //     ));
//   //   }
//   // }

//   // void selected(_value) {
//   //   if (_value == AppLocalizations.of(context).translate('unit')) {
//   //     menuitems = [];
//   //     populateA();
//   //   }
//   //   setState(() {
//   //     value = _value;
//   //   });
//   // }

//   @override
//   void initState() {
//     //  value = this.widget.data['unit'];
//     value = "KG";
//     nameController.text = '';
//     descriptionController.text = '';
//     priceController.text = '';
//     // vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
//     //  imageUrl = vendorData[0]['picture'];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);
//     return Stack(children: [
//       AlertDialog(
//           scrollable: true,
//           titlePadding: EdgeInsets.only(left: 25),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Add Item"),
//                       SizedBox(
//                         height: 2,
//                       ),
//                       Container(
//                         height: 2,
//                         width: 20,
//                         decoration: BoxDecoration(color: Colors.green),
//                       )
//                     ],
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.close_outlined))
//                 ],
//               ),
//             ],
//           ),
//           contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 10.0),
//           content: Container(
//             // height: this.widget.data['picture'] == null ||
//             //         this.widget.data['picture'] == ""
//             height: imageUrl == ''
//                 ? MediaQuery.of(context).size.height * 0.6
//                 : MediaQuery.of(context).size.height * 0.7,
//             // : MediaQuery.of(context).size.height * 0.65,
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Container(
//                   width: 250,
//                   // height: 40,
//                   child: TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: "Name",
//                       labelStyle:
//                           TextStyle(color: Theme.of(context).backgroundColor),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 12, horizontal: 15),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       hintText: "Name",
//                       enabledBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                       focusedBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: 250,
//                   // height: 40,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(0)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 14.0),
//                     child: DropdownButton<String>(
//                       underline: SizedBox(
//                         height: 5,
//                       ),
//                       isExpanded: true,
//                       items: menuitems.map((e) {
//                         return DropdownMenuItem<String>(
//                           value: e,
//                           child: Text(
//                             e,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (_value) {
//                         value = _value;
//                       },
//                       hint: Text(
//                         "$value",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: 250,
//                   // height: 40,
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     controller: priceController,
//                     decoration: InputDecoration(
//                       labelText: "Price",
//                       labelStyle:
//                           TextStyle(color: Theme.of(context).backgroundColor),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 14, horizontal: -1),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       hintText: "Price",
//                       prefixIcon: Icon(
//                         Icons.attach_money,
//                         size: 20,
//                       ),
//                       enabledBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                       focusedBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: 250,
//                   // height: 40,
//                   child: TextFormField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(
//                       labelText: "Description",
//                       labelStyle:
//                           TextStyle(color: Theme.of(context).backgroundColor),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 12, horizontal: 15),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       hintText: "Description",
//                       enabledBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                       focusedBorder:
//                           UnderlineInputBorder(borderSide: BorderSide.none),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                     // height: this.widget.data['picture'] == null ||
//                     //         this.widget.data['picture'] == ""
//                     // ? 15
//                     height: 30),
//                 if (imageUrl != '')
//                   Container(
//                     height: 120,
//                     width: 150,
//                     padding: EdgeInsets.all(5),
//                     child: Image.network(
//                       imageUrl!,
//                       scale: 3,
//                     ),
//                   ),
//                 // this.widget.data['picture'] == null ||
//                 //         this.widget.data['picture'] == ""
//                 //     ?
//                 Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Container(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         showLoadingAnimation(context);
//                         await utilService
//                             .browseImageforAddingFruit(
//                                 context.read<VendorProvider>().vendorData!.id!)
//                             .then((value) {
//                           setState(() {
//                             imageUrl = value;
//                           });
//                         });
//                         navigationService.closeScreen();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         textStyle: TextStyle(
//                             fontSize: MediaQuery.of(context).size.height * 0.03,
//                             fontWeight: FontWeight.w600),
//                         fixedSize: Size(
//                             MediaQuery.of(context).size.width * 0.64,
//                             MediaQuery.of(context).size.height * 0.050),
//                         primary: Colors.green,
//                         shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(0.0),
//                             side: BorderSide(width: 1, color: Colors.green)),
//                       ),
//                       child: Container(
//                           padding: EdgeInsets.only(left: 5.w, right: 10.w),
//                           child: new Text(
//                             "UPLOAD IMAGE",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )),
//                     ),
//                   ),
//                 ])
//                 //  Row(
//                 //     children: [
//                 //       Container(
//                 //         // decoration: BoxDecoration(
//                 //         //     color: Colors.amber,
//                 //         //     borderRadius: BorderRadius.circular(10)),
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.only(
//                 //               top: 15.0,
//                 //               bottom: 15.0,
//                 //               left: 13.0,
//                 //               right: 13.0),
//                 //           child: Image(
//                 //             image: NetworkImage(
//                 //               imageUrl != '' && imageUrl != null
//                 //                   ? imageUrl
//                 //                   : widget.data['picture'],
//                 //             ),
//                 //             fit: BoxFit.fill,
//                 //             height: 35,
//                 //             width: 40,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       SizedBox(
//                 //         width: 10,
//                 //       ),
//                 //       Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: [
//                 //           Text(
//                 //             this.widget.data['name'],
//                 //             style: TextStyle(fontWeight: FontWeight.w600),
//                 //           ),
//                 //           SizedBox(
//                 //             height: 8,
//                 //           ),
//                 //           Text(
//                 //             '\$${priceController.text} / $value',
//                 //             style: TextStyle(
//                 //                 fontWeight: FontWeight.w600,
//                 //                 color: Colors.grey),
//                 //           )
//                 //         ],
//                 //       ),
//                 //       Spacer(),
//                 //       // Container(
//                 //       //     padding: EdgeInsets.all(10),
//                 //       //     decoration: BoxDecoration(
//                 //       //         color: Color.fromRGBO(235, 244, 250, 1),
//                 //       //         borderRadius:
//                 //       //             BorderRadius.all(Radius.circular(10))),
//                 //       //     child: Icon(
//                 //       //       Icons.close_outlined,
//                 //       //       color: Color.fromRGBO(124, 143, 158, 1),
//                 //       //       size: 18,
//                 //       //     )),
//                 //     ],
//                 //   ),

//                 // if (this.widget.data['picture'] != null ||
//                 //     this.widget.data['picture'] != "")
//                 //   Divider(),
//                 ,
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                         onPressed: () async {
//                           FocusScope.of(context).unfocus();
//                           showLoadingAnimation(context);
//                           newProductData = Products(
//                             name: nameController.text,
//                             picture: imageUrl,
//                             price: priceController.text,
//                             unit: value,
//                             createdOnDate: int.parse(DateTime.now().toString()),
//                             description: descriptionController.text,
//                             backgroundColor: 'Cherries',
//                           );
//                           // setState(() {
//                           //   isLoadingProgress = true;
//                           // });
//                           // for (int i = 0; i < vendorData.products.length; i++) {
//                           //   if (vendorData.products[i]['id'] ==
//                           //       widget.data['id']) {
//                           //     vendorData.products.add(
//                           //       vendorData.products[i]['price'] =
//                           //           priceController.text,
//                           //       vendorData.products[i]['name'] =
//                           //           nameController.text,
//                           //       vendorData.products[i]['description'] =
//                           //           descriptionController.text,
//                           //       vendorData.products[i]['unit'] = value,
//                           //     );
//                           //   }
//                           // }

//                           await Provider.of<ProductsProvider>(context,
//                                   listen: false)
//                               .editProduct(newProductData!, context);
//                           await context
//                               .read<ProductsProvider>()
//                               .fetchAllProducts();
//                           navigationService.closeScreen();
//                           // widget.onItemClicked(true);
//                           // setState(() {
//                           //   isLoadingProgress = false;
//                           // });
//                           Navigator.of(context).pop();
//                         },
//                         child: Text("DONE"))
//                   ],
//                 )
//               ],
//             ),
//           )),
//       if (isLoadingProgress)
//         Positioned.fill(
//             child: Align(
//           alignment: Alignment.center,
//           child:  Platform.isIOS?
          // CupertinoActivityIndicator():
          //  CircularProgressIndicator(),,
        // )),
//     ]);
//   }
// }
