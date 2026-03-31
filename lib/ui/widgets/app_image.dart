import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawim/helper/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:dawim/helper/app_asset.dart';
import 'package:dawim/helper/app_color.dart';
import 'package:dawim/helper/dim.dart';
import 'package:dawim/ui/widgets/loading_indicator.dart';
import 'dart:math';

class AppImage extends StatelessWidget {
  final String? img;
  final String? tag;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? placeholderSize;
  final String? placeholder;
  final double? radius;
  final Function? onTap;
  final Color? bkgColor;
  final Color? placeHolderColor;

  AppImage({
    required this.img,
    this.tag,
    this.fit,
    this.width,
    this.height,
    this.placeholderSize,
    this.placeholder,
    this.radius,
    this.onTap,
    this.bkgColor,
    this.placeHolderColor,
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
      width: placeholderSize ?? Dim.h8,
      height: placeholderSize ?? Dim.h8,
      color: placeHolderColor,
    );
  }
}
