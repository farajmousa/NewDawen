import 'package:flutter/material.dart';
import 'package:sky_vacation/helper/dim.dart';

class LoadingIndicator extends StatelessWidget {
  final bool? fullScreen;
  final double? indicatorSize;

  LoadingIndicator({Key? key, this.fullScreen = true, this.indicatorSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (fullScreen ?? true)? Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
        // color: Color.fromRGBO(0, 0, 0, 0.1),
      ),
      child: Center(
        child: SizedBox(
          width: indicatorSize ?? Dim.h4,
          height: indicatorSize ?? Dim.h4,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),),
    ):  Padding(
      padding: EdgeInsets.only(bottom: Dim.h4),
      child: Align(
        alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: indicatorSize ?? Dim.h5,
            height: indicatorSize ?? Dim.h5,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
    );
  }
}
