import 'package:cached_network_image/cached_network_image.dart';
import 'package:sky_vacation/helper/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/app_asset.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/ui/widgets/loading_indicator.dart';
import 'dart:math';

class AppImage extends StatelessWidget {
  final String? img;
  final String? tag;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String? placeholder;
  final double? radius;
  final Function? onTap;
  final Color? bkgColor;

  AppImage({
    required this.img,
    this.tag,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.radius,
    this.onTap,
    this.bkgColor,
  });

  @override
  Widget build(BuildContext context) {
    // appLog("this.img: ${this.img}");
    String tempTag = "${Random().nextInt(10000000)}$img}";
    return InkWell(
      onTap: () {
        if (null != onTap) onTap!();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Container(
          decoration: AppDecor.decoration(
            borderRadius: radius,
            bkgColor: bkgColor ?? Colors.transparent,
          ),
          child:
              Hero(
                tag: this.tag ?? tempTag,
                child: (null != this.img &&
                        this.img!.isNotEmpty &&
                        "null" != this.img)
                    ? CachedNetworkImage(
                        imageUrl: "${Uri.encodeFull(this.img ?? "")}",
                        width: width ?? double.infinity,
                        height: height ?? double.infinity,
                        fit: fit ?? BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Stack(
                          children: [
                            Center(
                              child: placeholderImg(placeholder),
                            ),
                            LoadingIndicator()
                          ],
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: placeholderImg(placeholder),
                        ),
                      )
                    : placeholderImg(placeholder),
              ),


        ),
      ),
    );
  }

  Widget placeholderImg(String? placeholder) {
    return Image.asset(
      placeholder ?? AppAsset.logo,
      width: Dim.h8,
      height: Dim.h8,
      color: AppColor.primary,
    );
  }
}
