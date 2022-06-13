import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/services/http_service.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class SearchProductScreen extends StatefulWidget {
  final data;

  SearchProductScreen({this.data});

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  var navigationService = locator<NavigationService>();
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          print('Page reached end of page');
          getAllProducts(count: count, page: page);
        });
        setState(() {
          page += 1;
        });
      }
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAllProducts(count: 4, page: 1);

    super.initState();
  }

  HttpService? http = locator<HttpService>();
  List<DocumentSnapshot> documents = [];
  String searchText = '';
  final TextEditingController _searchbar = new TextEditingController();
  var data = [];
  List filterList = [];
  ScrollController scrollController = new ScrollController();
  int page = 2;
  int count = 10;

  getAllProducts({int count = 0, int page = 0}) async {
    showLoadingAnimation(context);
    await context
        .read<ProductsProvider>()
        .fetchAllProducts(count: count, page: page);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Consumer<ProductsProvider>(builder: (context, i, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.white,
            actions: [
              InkWell(
                onTap: SelectAccount.selectAccount ==
                        SelectAccountEnum.Guest.toString()
                    ? () {}
                    : () async {
                        var storageService = locator<StorageService>();
                        await storageService.setData(
                            "route", "/search-product");
                        navigationService.navigateTo(NotificationScreenRoute);
                      },
                child: Image.asset(
                  'assets/images/notification.png',
                  scale: 2.5,
                  // color: Colors.white,
                ),
              )
            ],

            leading: Builder(
              builder: (context) => IconButton(
                  icon: Image.asset(
                    'assets/images/ArrowBack.png',
                    scale: 2.5,
                    // color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ), // leading: Text('abc'),
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
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)
                      .translate('SearchProductFruitDoorStep'),
                  // "Get fresh exotic fruits at you doorstep",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  controller: _searchbar,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 24.h,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15.h,
                      color: Colors.grey.shade700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(
                        width: 0.w,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    hintText: AppLocalizations.of(context)
                        .translate('SearchProductFavouriteFruits'),
                    // "Search your favourite fruits",
                    fillColor: Color.fromRGBO(235, 244, 250, 1),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                StreamBuilder<QuerySnapshot>(
                  // stream: i.productData.,

                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot streamSnapshot) {
                    //todo Documents list added to filterTitle

                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.green,
                      ));
                    }
                    documents = streamSnapshot.data.docs;
                    if (searchText.length > 0) {
                      documents = documents.where((element) {
                        return element
                            .get('name')
                            .toString()
                            .toLowerCase()
                            .contains(searchText.toLowerCase());
                      }).toList();

                      return Expanded(
                          child: GridView.count(
                              childAspectRatio: 2 / 2.5,
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              shrinkWrap: true,
                              children: List.generate(
                                documents.length,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: "${documents[index]['backgroundColor']}" ==
                                              "orange"
                                          ? Color.fromRGBO(254, 245, 236, 1)
                                          : "${documents[index]['backgroundColor']}" ==
                                                  " yellow"
                                              ? Color.fromRGBO(254, 248, 216, 1)
                                              : "${documents[index]['backgroundColor']}" ==
                                                      "green"
                                                  ? Color.fromRGBO(
                                                      238, 245, 227, 1)
                                                  : "${documents[index]['backgroundColor']}" ==
                                                          "red"
                                                      ? Color.fromRGBO(
                                                          248, 232, 232, 1)
                                                      : "${documents[index]['backgroundColor']}" ==
                                                              "peach"
                                                          ? Color.fromRGBO(
                                                              254, 241, 230, 1)
                                                          : "${documents[index]['backgroundColor']}" ==
                                                                  "darkgreen"
                                                              ? Color.fromRGBO(
                                                                  235,
                                                                  241,
                                                                  232,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  254,
                                                                  241,
                                                                  230,
                                                                  1),
                                      // itemsList[index]['BoxColor'],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Image(
                                                image: NetworkImage(
                                                  "${documents[index]['picture']}",
                                                  // "${itemsList[index]['Image']}"
                                                ),
                                                height: 80.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${documents[index]['name']}",
                                          // '${itemsList[index]['Name']}',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "PER ${documents[index]['unit']}",
                                          // '${itemsList[index]['Kg']}',
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
                                          "\$${documents[index]['price']}",
                                          // '${itemsList[index]['Price']}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )));
                    } else {
                      return Expanded(
                          child: GridView.count(
                              childAspectRatio: 2 / 2.5,
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              shrinkWrap: true,
                              children: List.generate(
                                documents.length,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: "${documents[index]['backgroundColor']}" ==
                                              "orange"
                                          ? Color.fromRGBO(254, 245, 236, 1)
                                          : "${documents[index]['backgroundColor']}" ==
                                                  " yellow"
                                              ? Color.fromRGBO(254, 248, 216, 1)
                                              : "${documents[index]['backgroundColor']}" ==
                                                      "green"
                                                  ? Color.fromRGBO(
                                                      238, 245, 227, 1)
                                                  : "${documents[index]['backgroundColor']}" ==
                                                          "red"
                                                      ? Color.fromRGBO(
                                                          248, 232, 232, 1)
                                                      : "${documents[index]['backgroundColor']}" ==
                                                              "peach"
                                                          ? Color.fromRGBO(
                                                              254, 241, 230, 1)
                                                          : "${documents[index]['backgroundColor']}" ==
                                                                  "darkgreen"
                                                              ? Color.fromRGBO(
                                                                  235,
                                                                  241,
                                                                  232,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  254,
                                                                  241,
                                                                  230,
                                                                  1),
                                      // itemsList[index]['BoxColor'],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Image(
                                                image: NetworkImage(
                                                  "${documents[index]['picture']}",
                                                  // "${itemsList[index]['Image']}"
                                                ),
                                                height: 80.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${documents[index]['name']}",
                                          // '${itemsList[index]['Name']}',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "PER ${documents[index]['unit']}",
                                          // '${itemsList[index]['Kg']}',
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
                                          "\$${documents[index]['price']}",
                                          // '${itemsList[index]['Price']}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
