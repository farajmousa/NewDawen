import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  Loading(
      {this.loading = false,this.loadingColor = Colors.white,this.loadingAlignment = Alignment.centerRight});
  bool loading;
  Color loadingColor;
  Alignment loadingAlignment;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Align(
      alignment: loadingAlignment,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor:
            AlwaysStoppedAnimation<Color>(loadingColor),
          ),
        ),
      ),
    )
        : Container();
  }
}