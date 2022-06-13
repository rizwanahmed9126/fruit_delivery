import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchProductWidget extends StatefulWidget {
  final data;
  const SearchProductWidget({this.data});

  @override
  _SearchProductWidgetState createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: this.widget.data.backgroundColor == "orange"
            ? Color.fromRGBO(254, 245, 236, 1)
            : this.widget.data.backgroundColor == " yellow"
                ? Color.fromRGBO(254, 248, 216, 1)
                : this.widget.data.backgroundColor == "green"
                    ? Color.fromRGBO(238, 245, 227, 1)
                    : this.widget.data.backgroundColor == "red"
                        ? Color.fromRGBO(248, 232, 232, 1)
                        : this.widget.data.backgroundColor == "peach"
                            ? Color.fromRGBO(254, 241, 230, 1)
                            : this.widget.data.backgroundColor == "darkgreen"
                                ? Color.fromRGBO(235, 241, 232, 1)
                                : Color.fromRGBO(254, 241, 230, 1),
        // itemsList[i]['BoxColor'],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Image(
                  image: NetworkImage(
                    widget.data.picture,
                    // "${itemsList[index]['Image']}"
                  ),
                  height: 80.h,
                ),
              ),
            ),
          ),
          Text(
            this.widget.data.name,
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
            "PER ${this.widget.data.unit}".toUpperCase(),
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
            this.widget.data.price,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
