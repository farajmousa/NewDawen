import 'package:sky_vacation/helper/font_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyError extends StatelessWidget {
  final String? errorMsg;
  final Color? textColor ;

  MyError(this.errorMsg, [this.textColor]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 3.0.h),
      child: Center(
        child: Text(
          errorMsg ?? "",
          style: TS.textStyle(size: 16),
        ),
      ),
    );
  }
}
