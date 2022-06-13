import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';

import '.././services/navigation_service.dart';
import '.././utils/service_locator.dart';
import '../screens/home_screen.dart';
import '../screens/letschat_screen.dart';
import '../screens/location_screen.dart';
import 'myprofile_screen.dart';
import '../constants/select_account.dart';
import '../popups.dart/login_alert.dart';
import '../services/storage_service.dart';
import '../utils/routes.dart';
import '../popups.dart/exit_alert_dialog.dart';
import '../widgets/main_drawer_widget.dart';

class MainDashboardScreen extends StatefulWidget {
  var pageIndex;
  int? tabViewIndex;
  MainDashboardScreen(this.pageIndex, {this.tabViewIndex});
  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;
  int? tabIndex = 0;
  var navigationService = locator<NavigationService>();
  var storageService;
  @override
  void initState() {
    if (widget.tabViewIndex != null) {
      tabIndex = widget.tabViewIndex;
    }
    didChangeDependencies();
  }

  // @override
  void didChangeDependencies() {
    setState(() {
      _selectedIndex = widget.pageIndex;
    });

    super.didChangeDependencies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.pageIndex = _selectedIndex;
      // if (SelectAccount.selectAccount == SelectAccountEnum.Guest.toString()) {
      //   if (_selectedIndex == 1 || _selectedIndex == 2 || _selectedIndex == 3) {
      //     showDialog(
      //         context: context,
      //         barrierDismissible: false,
      //         builder: (_) {
      //           return LoginAlert();
      //         });
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(builder: (context) => SelectAccountScreen()),
      //     // );
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(
          360,
          800,
        ),
        orientation: Orientation.portrait);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: _selectedIndex != 3 ||
                SelectAccount.selectAccount ==
                    SelectAccountEnum.Guest.toString()
            ? Colors.white
            : Theme.of(context).backgroundColor,
        // extendBodyBehindAppBar:
        //     SelectAccount.selectAccount == SelectAccountEnum.Guest.toString() &&
        //             _selectedIndex != 0
        //         ? true
        //         : false,
        drawer: MainDrawerWidget(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            // _selectedIndex != 3 ? Size.fromHeight(65) : Size.fromHeight(0),
            child: AppBar(
              backgroundColor: _selectedIndex != 3 ||
                      SelectAccount.selectAccount ==
                          SelectAccountEnum.Guest.toString()
                  ? Colors.white
                  : Theme.of(context).backgroundColor,
              actions: [
                SelectAccount.selectAccount !=
                        SelectAccountEnum.Guest.toString()
                    ? GestureDetector(
                        onTap: () async {
                          if (_selectedIndex == 0) {
                            storageService = locator<StorageService>();
                            await storageService.setData(
                                "route", "/main-dashboard-screen");
                            navigationService
                                .navigateTo(NotificationScreenRoute);
                          } else if (_selectedIndex == 1) {
                            storageService = locator<StorageService>();
                            await storageService.setData(
                                "route", "/location-screen");
                            navigationService
                                .navigateTo(NotificationScreenRoute);
                          } else if (_selectedIndex == 2) {
                            storageService = locator<StorageService>();
                            await storageService.setData(
                                "route", "/letschat-Screen");
                            navigationService
                                .navigateTo(NotificationScreenRoute);
                          } else {
                            navigationService
                                .navigateTo(EditProfileScreenRoute);
                          }
                        },
                        child: Image.asset(
                          _selectedIndex != 3
                              ? 'assets/images/notification.png'
                              : "assets/images/edit.png",
                          scale: 2.5,
                          // color: Colors.white,
                        ),
                      )
                    : _selectedIndex != 3
                        ? SelectAccount.selectAccount ==
                                    SelectAccountEnum.Guest.toString() &&
                                _selectedIndex != 0
                            ? Container()
                            : Image.asset(
                                'assets/images/notification.png',

                                scale: 2.5,
                                // color: Colors.white,
                              )
                        : Container()
              ],

              leading: Builder(
                builder: (context) => IconButton(
                    icon: SelectAccount.selectAccount ==
                                SelectAccountEnum.Guest.toString() &&
                            _selectedIndex != 0
                        ? Container()
                        : Image.asset(
                            _selectedIndex != 3
                                ? 'assets/images/Menubutton.png'
                                : "assets/images/menu-icon.png",
                            scale: 2.5,
                            // color: Colors.white,
                          ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }),
              ), // leading: Text('abc'),

              centerTitle: true,
              title: _selectedIndex != 3
                  ? SelectAccount.selectAccount ==
                              SelectAccountEnum.Guest.toString() &&
                          _selectedIndex != 0
                      ? Container()
                      : Image.asset(
                          'assets/images/logoleaf.png',
                          scale: 14,
                          // color: SelectAccount.selectAccount ==
                          //             SelectAccountEnum.Guest.toString() &&
                          //         _selectedIndex != 0
                          //     ? Colors.white
                          //     : Colors.green,
                        )
                  : Text(
                      // 'My Profile',
                      AppLocalizations.of(context).translate('MyProfile'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              bottomOpacity: 0.0,
              // backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,

              automaticallyImplyLeading: false,
            )

            // : AppBar(
            //     flexibleSpace: Container(
            //       height: 200,
            //       color: Theme.of(context).backgroundColor,
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(
            //               top: 60.h,
            //               bottom: 10.h,
            //             ),
            //             child: Padding(
            //               padding: EdgeInsets.only(left: 14.w, right: 15.w),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () {},
            //                     child: Image(
            //                       width: 22.w,
            //                       height: 22.h,
            //                       image: AssetImage(
            //                         "assets/images/menu-icon.png",
            //                       ),
            //                     ),
            //                   ),
            //                   Center(
            //                     child: Text(
            //                       'My Profile',
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 18.sp,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),
            //                   ),
            //                   GestureDetector(
            //                     onTap: () => navigationService
            //                         .navigateTo(EditProfileScreenRoute),
            //                     child: Image(
            //                       width: 22.w,
            //                       height: 22.h,
            //                       image: AssetImage(
            //                         "assets/images/edit.png",
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 40.h,
            //           ),
            //           Stack(
            //             children: [
            //               Center(
            //                 child: CircleAvatar(
            //                   radius: 55.h,
            //                   backgroundImage: NetworkImage(
            //                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl1jtx4RcMns_1E-3KZd1PbkxcQ231pwig9w&usqp=CAU",
            //                     scale: 20,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 15.h,
            //           ),
            //           Text(
            //             "Angelina",
            //             style: TextStyle(
            //               color: Color.fromRGBO(
            //                 253,
            //                 255,
            //                 254,
            //                 1,
            //               ),
            //               fontSize: 24.sp,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 1.h,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.location_on_outlined,
            //                 size: 22.h,
            //                 color: Color.fromRGBO(
            //                   239,
            //                   248,
            //                   247,
            //                   1,
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 3.w,
            //               ),
            //               Text(
            //                 "Boston, MA 02101",
            //                 style: TextStyle(
            //                   color: Color.fromRGBO(
            //                     239,
            //                     248,
            //                     247,
            //                     1,
            //                   ),
            //                   fontSize: 14.sp,
            //                   height: 1.5.h,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 60.h,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),

            ),
        body:
            SelectAccount.selectAccount == SelectAccountEnum.Guest.toString() &&
                    (_selectedIndex == 1 ||
                        _selectedIndex == 2 ||
                        _selectedIndex == 3)
                ? Center(child: LoginAlert())
                : IndexedStack(
                    index: _selectedIndex,
                    children: <Widget>[
                      HomeScreen(),
                      LocationScreen(),
                      LetsChatScreen(),
                      MyProfileScreen(),
                    ],
                  ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2),
              ],
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,

              // elevation: 10,
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label:
                      AppLocalizations.of(context).translate('DashboardHome'),
                  icon: Image.asset(
                    'assets/images/BottomMenu.png',
                    scale: 3.0,
                    // color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/MenuColor.png',
                    scale: 3.0,
                    // color: Theme.of(context).backgroundColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: AppLocalizations.of(context)
                      .translate('DashboardMessage'),
                  icon: Image.asset(
                    'assets/images/Locations.png',
                    scale: 1.3,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/Locations.png',
                    scale: 1.3,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: AppLocalizations.of(context)
                      .translate('DashboardLocation'),
                  icon: Image.asset(
                    'assets/images/Chat.png',
                    scale: 3,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/Chat.png',
                    scale: 3,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: AppLocalizations.of(context)
                      .translate('DashboardProfile'),
                  icon: Image.asset(
                    'assets/images/profile.png',
                    scale: 3,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/profile.png',
                    scale: 3,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ],

              // iconSize: 28,
              // selectedFontSize: 0,
              currentIndex: _selectedIndex,

              onTap: _onItemTapped,
              selectedLabelStyle: TextStyle(fontSize: 12, height: 1.8),

              selectedItemColor: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
