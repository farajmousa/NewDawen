import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/dim.dart';

class Separator extends StatelessWidget {
  final Color? color;
  final double? horizontalMargin;
  final double? verticalMargin;

  Separator({this.color, this.verticalMargin, this.horizontalMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? 0,
          vertical: verticalMargin ?? Dim.h1),
      height: 0.5,
      color: color ?? Colors.grey.withOpacity(0.5), // line
    );
  }
}


class SeparatorDashed extends StatelessWidget {
  final double height;
  final Color color;
  final double? horizontalMargin;
  final double? verticalMargin;
  const SeparatorDashed({this.height = 1.3, this.color = Colors.black, this.verticalMargin, this.horizontalMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 0,
        vertical: verticalMargin ?? Dim.h2), child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 8.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    ),);
  }
}