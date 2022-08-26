
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';

class ErrorLabel extends StatelessWidget {
  final String? msg;
  final Color? color;

  ErrorLabel({Key? key, required this.msg, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (null != msg && msg!.isNotEmpty)
        ? Padding(
            padding: EdgeInsets.fromLTRB(Dim.h20, Dim.h10,
                Dim.h20, Dim.h10),
            child:Text(
                    msg ?? "",
                    style: TS.textStyle(size: Dim.s16, color: color ?? AppColor.red),
                  ),
          )
        : Center();
  }
}
