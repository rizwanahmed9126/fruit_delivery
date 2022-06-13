import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/color_constants.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geocode/geocode.dart';
import 'package:google_geocoding/google_geocoding.dart';

class AddStopWidget extends StatefulWidget {
  final int? index;
  String? filledAddress;
  String? time;

  AddStopWidget({
    Key? key,
    this.index,
    this.filledAddress,
    this.time,
  }) : super(key: key);

  @override
  _AddStopWidgetState createState() => _AddStopWidgetState();
}

class _AddStopWidgetState extends State<AddStopWidget> {
  TextEditingController timeController = TextEditingController();
  bool disableTime = true;
  int? index;

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
        timeController.text = _time.format(context).toString();
      });

      Provider.of<GMapsProvider>(context, listen: false)
          .addtime(timeController.text.toString(), index);
    }
  }

  var _controller = TextEditingController();

  @override
  void initState() {
    // if(Provider.of<GMapsProvider>(context,listen: false).stopData.length==0){
    //   index=0;
    // }
    // else if(Provider.of<GMapsProvider>(context,listen: false).stopData.length==1){
    //   index=1;
    // }
    // else{
    //   index=Provider.of<GMapsProvider>(context,listen: false).stopData.length-1;
    // }
    super.initState();
    if (widget.filledAddress != "" || widget.time != "") {
      _controller.text = widget.filledAddress!;
      timeController.text = widget.time!;
      Provider.of<GMapsProvider>(context, listen: false)
          .addtime(timeController.text.toString(), widget.index);
    }
  }

  var uuid = new Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];

  _onChanged(String abc) {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(abc);
  }

  void getSuggestion(String input) async {
    String aPiKey = "AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M";
    // String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$aPiKey&sessiontoken=$_sessionToken&region=pk';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  bool show = true;
  var googleGeocoding =
      GoogleGeocoding("AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M");

  @override
  Widget build(BuildContext context) {
    return show
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.64,
                child: TimelineTile(
                  isLast: false,
                  isFirst: false,
                  lineXY: 0.0,
                  beforeLineStyle: LineStyle(color: iconColor, thickness: 1.5),
                  afterLineStyle: LineStyle(color: iconColor, thickness: 1.5),
                  indicatorStyle: IndicatorStyle(
                    indicatorXY: 0.5,
                    width: 5.w,
                    height: 5.w,
                    color: baseColor,
                  ),
                  alignment: TimelineAlign.start,
                  endChild: Padding(
                    padding: EdgeInsets.only(left: 8.0.w, bottom: 4.0.w),
                    child: Container(
                        // height: 40.h,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40.h,
                          child: TextFormField(
                              onTap: () {
                                //_onChanged();
                              },
                              onChanged: (e) {
                                _onChanged(_controller.text);
                                disableTime = false;
                                setState(() {});
                                if (_controller.text.isEmpty) {
                                  disableTime = true;
                                  setState(() {});
                                  Provider.of<GMapsProvider>(context,
                                          listen: false)
                                      .removeStop(widget.index);
                                }
                              },
                              controller: _controller,
                              cursorColor: baseColor,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 12.0.w),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    borderSide: BorderSide(
                                      color: baseColor,
                                      width: 1.4,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    borderSide: BorderSide(
                                      color: smokeColor,
                                      width: 1.4,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0.r),
                                      ),
                                      borderSide:
                                          BorderSide(color: smokeColor)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: new TextStyle(
                                      color: Color(0xffb5bcc6),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                  hintText: "Add stop "

                                  // timeController.text =
                                  // '${_time.format(context)}',

                                  )),
                        ),
                        _placeList.isNotEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300]!,
                                          spreadRadius: 3,
                                          blurRadius: 2)
                                    ]),
                                child: ListView.builder(
                                  // scrollDirection: Axis.vertical,
                                  // physics: ScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemCount: _placeList.length,
                                  itemBuilder: (context, i) {
                                    //print(_placeList.length);
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            
                                            List<Component> abc = [];

                                            var risult = await googleGeocoding.geocoding.get( _placeList[i]["description"],abc);
                                            // print("${risult!.results!.first.geometry!.location!.lat}");
                                            //print("${risult!.results!.first.geometry!.location!.lng}");
                                            //risult!.results!.first.geometry!.location!.lat

                                            //Provider.of<GMapsProvider>(context,listen: false).saveRouteData(await locationFromAddress(_placeList[index]["description"]));

                                            //List<Location> locations = await locationFromAddress(_placeList[i]["description"]);

                                            // Provider.of<GMapsProvider>(context,
                                            //         listen: false)
                                            //     .saveRouteData(routeModel(
                                            //         time: timeController.toString(),
                                            //         lng: LatLng(locations[0].latitude,
                                            //             locations[0].longitude)));
                                            // int? index;
                                            // if(Provider.of<GMapsProvider>(context,listen: false).stopData.length==0 ){
                                            //   index=0;
                                            // }
                                            // // else if(Provider.of<GMapsProvider>(context,listen: false).stopData.length==1){
                                            // //   index=1;
                                            // // }
                                            // else{

                                            index = Provider.of<GMapsProvider>(
                                                    context,
                                                    listen: false)
                                                .stopData
                                                .length;

                                            // }

                                            //print(_placeList[i]["description"]);
                                            Provider.of<GMapsProvider>(context,
                                                    listen: false)
                                                .addStopData({
                                              'serialNo': index
                                                  .toString(), //widget.index.toString(),
                                              'location': {
                                                'lat': risult!.results!.first
                                                    .geometry!.location!.lat,
                                                'long': risult.results!.first
                                                    .geometry!.location!.lng,
                                                'address': _placeList[i]
                                                    ["description"],
                                              },
                                            }, index);

                                            _controller.text = _placeList[i]["description"];

                                            print(
                                                'length--${Provider.of<GMapsProvider>(context, listen: false).routesData.length}');
                                            setState(() {
                                              _placeList.clear();
                                            });
                                          },
                                          child: ListTile(
                                            title: Text(
                                                _placeList[i]["description"]),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey[300],
                                        )
                                        //Divider(),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Text(' ')
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width / 2.64,
                child: TextField(
                    readOnly: disableTime,
                    onTap: disableTime
                        ? () {}
                        : () {
                            _selectTime();
                          },
                    controller: timeController,

                    // isFirst: false,
                    // isLast: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12.0.w),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                        borderSide: BorderSide(
                          color: baseColor,
                          width: 1.4,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                        borderSide: BorderSide(
                          color: disableTime ? Colors.grey[100]! : smokeColor,
                          width: 1.4,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0.r),
                          ),
                          borderSide: BorderSide(
                            color: disableTime ? Colors.grey[100]! : smokeColor,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: new TextStyle(
                          color: Color(0xffb5bcc6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                      hintText:
                          // timeController.text =
                          // '${_time.format(context)}',
                          "Select Time",
                    )),
              ),
              Container(
                width: 30.w,
                child: Visibility(
                  visible: widget.index! == 0 ? false : true,
                  child: IconButton(
                      onPressed: () {
                        Provider.of<GMapsProvider>(context, listen: false)
                            .removeStop(index == null ? widget.index : index);
                        show = false;
                        setState(() {});
                        //removeField(index);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black54,
                        size: 18.sp,
                      )),
                ),
              ),
            ],
          )
        : Container();
  }
}

// class TimeLineTextField extends StatelessWidget {
//   String? hintText;
//   Color? indicatorColor;
//   bool isFirst;
//   bool isLast;
//   bool isSuffixIcon;
//   IconData? suffixIcon;
//   TimelineAlign timelineAlignment;
//   VoidCallback suffixOnpress;
//   String? controller;
//
//   TimeLineTextField(
//       {required this.isLast,
//         required this.isFirst,
//         this.indicatorColor,
//         required this.timelineAlignment,
//         this.hintText,
//         required this.isSuffixIcon,
//         required this.suffixOnpress,
//         this.controller,
//         this.suffixIcon});
//   TextEditingController controller1 = TextEditingController();
//   @override
//   void initState() {
//     controller1.text = controller!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TimelineTile(
//       isLast: isLast,
//       isFirst: isFirst,
//       lineXY: 0.0,
//       beforeLineStyle: LineStyle(color: iconColor, thickness: 1.5),
//       afterLineStyle: LineStyle(color: iconColor, thickness: 1.5),
//       indicatorStyle: IndicatorStyle(
//         indicatorXY: 0.5,
//         width: 5.w,
//         height: 5.w,
//         color: baseColor,
//       ),
//       alignment: timelineAlignment,
//       endChild: Padding(
//         padding: EdgeInsets.only(left: 8.0.w, bottom: 12.0.w),
//         child: Container(
//           height: 40.h,
//           child: TextFormField(
//               controller: controller1,
//               cursorColor: baseColor,
//               cursorHeight: 20,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 12.0.w),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0.r),
//                   borderSide: BorderSide(
//                     color: baseColor,
//                     width: 1.4,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0.r),
//                   borderSide: BorderSide(
//                     color: smokeColor,
//                     width: 1.4,
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8.0.r),
//                     ),
//                     borderSide: BorderSide(color: smokeColor)),
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintStyle: new TextStyle(
//                     color: Color(0xffb5bcc6),
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w500),
//                 hintText: hintText,
//                 suffixIcon: isSuffixIcon == true
//                     ? Padding(
//                     padding: const EdgeInsets.all(6),
//                     child: GestureDetector(
//                         onTap: () {},
//                         child: Image.asset(
//                             'assets/images/Current-Location.png',
//                             height: 25.w,
//                             width: 25.w)))
//                     : null,
//               )),
//         ),
//       ),
//     );
//   }
// }




