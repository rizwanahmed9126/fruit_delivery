import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String name;
  final Color txtColor;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.name,
    required this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ElevatedButton(
        onPressed: onTap,
        //     () {
        //   // navigationService.navigateTo(MeasureHeightScreenRoute);
        // },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontWeight: FontWeight.w600),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.27,
              MediaQuery.of(context).size.height * 0.00),
          primary: color,//Color.fromRGBO(255, 122, 0, 1),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              //side: BorderSide(width: 1, color: Color.fromRGBO(255, 122, 0, 1))
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(left: 5.w, right: 10.w),
                child: new Text(
                  name,
                  style: TextStyle(
                    color: txtColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
