// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../services/navigation_service.dart';
// import '../utils/service_locator.dart';
// import '../popups.dart/my_fruit_delete_popup_widget.dart';
// import '../popups.dart/my_fruits_list_popup.dart';

// class MyFruitsItem extends StatefulWidget {
//   final data;
//   final ValueChanged<bool> active;

//   MyFruitsItem({this.data, required this.active});

//   @override
//   _MyFruitsItemState createState() => _MyFruitsItemState();
// }

// class _MyFruitsItemState extends State<MyFruitsItem> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   var navigationService = locator<NavigationService>();
//   TextEditingController numController = TextEditingController();
//   bool? isactive = false;
//   void handletap() {
//     setState(() {
//       isactive = !isactive!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);
//     return Container(
//       margin: EdgeInsets.only(top: 5),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: handletap,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Tooltip(
//                         message: this.widget.data["description"],
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: this.widget.data["backgroundColor"] ==
//                                       "orange"
//                                   ? Color.fromRGBO(254, 245, 236, 1)
//                                   : this.widget.data["backgroundColor"] ==
//                                           " yellow"
//                                       ? Color.fromRGBO(254, 248, 216, 1)
//                                       : this.widget.data["backgroundColor"] ==
//                                               "green"
//                                           ? Color.fromRGBO(238, 245, 227, 1)
//                                           : this.widget.data[
//                                                       "backgroundColor"] ==
//                                                   "red"
//                                               ? Color.fromRGBO(248, 232, 232, 1)
//                                               : this.widget.data[
//                                                           "backgroundColor"] ==
//                                                       "peach"
//                                                   ? Color.fromRGBO(
//                                                       254, 241, 230, 1)
//                                                   : this
//                                                                   .widget
//                                                                   .data[
//                                                               "backgroundColor"] ==
//                                                           "darkgreen"
//                                                       ? Color.fromRGBO(
//                                                           235, 241, 232, 1)
//                                                       : Color.fromRGBO(
//                                                           254, 241, 230, 1),
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 15.0,
//                                 bottom: 15.0,
//                                 left: 13.0,
//                                 right: 13.0),
//                             child: Image(
//                               image: NetworkImage(this.widget.data["picture"]),
//                               fit: BoxFit.fill,
//                               height: 25,
//                               width: 25,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             this.widget.data["name"],
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                           Text(
//                             '\$${this.widget.data["price"]} / ${this.widget.data["unit"]}',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           showDialog(
//                             barrierDismissible: false,
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return MyFruitListPopup(
//                                   // data: this.widget.data,
//                                   // onItemClicked: this.widget.active,
//                                 );
//                               });
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Color.fromRGBO(235, 244, 250, 1),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                           child: Image.asset(
//                             'assets/images/edit.png',
//                             color: Color.fromRGBO(124, 143, 158, 1),
//                             scale: 3,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20.h,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return DeletePopupWidget(
//                                     this.widget.data, this.widget.active);
//                               });
//                         },
//                         child: Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 color: Color.fromRGBO(235, 244, 250, 1),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10))),
//                             child: Icon(
//                               Icons.delete,
//                               color: Color.fromRGBO(124, 143, 158, 1),
//                               size: 18,
//                             )),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Divider()
//           ],
//         ),
//       ),
//     );
//   }
// }
