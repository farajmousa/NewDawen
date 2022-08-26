import 'package:sky_vacation/helper/dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSVG extends StatelessWidget{
  final String name;
  final Color? color;
  final double? width;
  final double? height;
  AppSVG({required this.name, this.color, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    double size = width ?? Dim.w6 ;
    return SvgPicture.asset(
        this.name,
        color: color,
        width: size,
        height: height ?? size ,
        // semanticsLabel: 'A red up arrow'
    );;
  }

}