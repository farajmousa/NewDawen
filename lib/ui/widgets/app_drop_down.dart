import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/app_constant.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';
import 'package:sky_vacation/helper/localize.dart';
import 'package:sky_vacation/helper/user_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class AppDropDown extends StatelessWidget {

  final List<dynamic>? items ;
  final dynamic selectedItem;
  final String? hint;
  final bool enable;
  final bool showDelete;
  final Function(dynamic) onItemChanged;
  final Function() onDeleteTapped;
  final double? width ;
  final bool isRequired;
  final Color? bkgColor;
  final Color? iconColor;
  final bool? isExpanded;
  final TextStyle? fontStyle;
  final double? borderRadius;

  AppDropDown({required this.items ,required  this.selectedItem, required this.onItemChanged,
    required this.hint, this.enable = true,required this.onDeleteTapped, this.showDelete = true,
    this.width, this.isRequired = false, this.bkgColor, this.iconColor, this.isExpanded, this.fontStyle, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.decoration(borderColor: AppColor.grayMed),
      // height: (SizerUtil.deviceType == DeviceType.mobile)? Dim.h6 : null,
      width: width,
      margin: EdgeInsets.symmetric(vertical: Dim.h_5),
      padding: EdgeInsets.symmetric(
          horizontal: Dim.w4, vertical: (SizerUtil.deviceType == DeviceType.mobile)? 0 : Dim.h_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (isExpanded ?? true)?Expanded(child:dropDown(context)
          ): dropDown(context),
          if(null != selectedItem && showDelete && enable)SizedBox(width: Dim.w1,),
          if(null != selectedItem && showDelete && enable)InkWell(
            onTap: onDeleteTapped,
            child: Icon(Icons.cancel_outlined, color: AppColor.red, size: Dim.w5,),
          )
        ],
      ),
    );
  }

  Widget dropDown(BuildContext context){
    return  DropdownButton<dynamic>(
      value: selectedItem,
      isExpanded: isExpanded ?? true,
      hint: RichText(
        text:  TextSpan(
          style: fontStyle?? TS.medGrayDark10,
          children: <TextSpan>[
            TextSpan(
                text: (null != hint && hint!.isNotEmpty)? "${Trans.of(context).t('$hint')}": ''),
            if(isRequired) TextSpan(
                text: ' * ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.red,
                    fontSize: Dim.s10)),
          ],
        ),
      ),

      // iconSize: Dim.h3,
      icon: Icon(
        Icons.arrow_drop_down_rounded,
        color: iconColor ?? AppColor.gray,
        size: Dim.h3,
      ),
      elevation: 16,
      style: fontStyle?? TS.medGrayDark10,
      underline: Container(),
      alignment: (isExpanded ?? true)? AlignmentDirectional.centerStart :AlignmentDirectional.centerEnd,
      onChanged: (enable)? onItemChanged : null,
      items: (items ?? [])
          .map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text("${value.toString()}", style: fontStyle ?? TS.medGrayDark10 ,),
        );
      }).toList(),
    );
  }
  handleValue(String value){
    String newValue = value.replaceAll("_", "replace").replaceAll("-", "replace") ;
    return newValue.toLowerCase() ;
  }
}