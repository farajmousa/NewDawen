import 'package:sky_vacation/helper/dim.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/app_color.dart';

class SliderIndicators extends StatelessWidget {
  final int count;
  final int selectedIndex;

  SliderIndicators({
    Key? key,
    required this.count,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> dataList =
        List<int>.generate(count, (int index) => index); //List(count) ;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: dataList.reversed.map((item) {
        int index = dataList.indexOf(item);
        return Container(
          width: (selectedIndex == index) ? 2.5.h : 1.4.h,
          height: 1.2.h,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: Dim.w1),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(1.4.h),
            color: (selectedIndex == index) ? AppColor.primary : AppColor.grayMed,
          ),
        );
      }).toList(),
    );
  }
}
