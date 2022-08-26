import 'package:flutter/material.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:sizer/sizer.dart';
import 'package:sky_vacation/helper/app_color.dart';
import 'package:sky_vacation/helper/dim.dart';
import 'package:sky_vacation/helper/font_style.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final String? errorText;
  final Color? borderColor;
  final Color? defaultBorderColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? iconColor;
  final double? iconSize;
  final int? maxLines;
  final int? maxLenght;
  final int? minLines;
  final TextInputType? inputType;
  final bool? secureText;
  final double? textSize;
  final Color? fillColor;
  final Color? hitColor;
  final bool? linearBottomBorder;
  final Color? textColor;
  final double? elevation;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final bool? disableFocus;
  final double? paddingVertical;
  final String? isValid;
  final bool? enable;
  final bool isRequired;
  final String? initialValue;
  final double? marginHorizontal;

  final TextDirection? textDirection;
  final Function(String?)? onValueSaved;
  final Function(String?)? onFieldSubmitted;
  final Function(String?)? onValueChanged;
  final String? Function(String?)? onValidate;
  final Function(String)? onIconTapped;

  AppTextField(
      {Key? key,
      this.hint,
      this.errorText,
      this.borderColor,
      this.defaultBorderColor,
      this.borderRadius,
      this.padding,
      this.prefixIcon,
      this.suffixIcon,
      this.iconColor,
      this.iconSize,
      this.maxLines,
      this.maxLenght,
      this.minLines,
      this.inputType,
      this.secureText,
      this.textSize,
      this.fillColor,
      this.hitColor,
      this.textColor,
      this.textAlign,
      this.isValid,
      this.paddingVertical,
      this.linearBottomBorder,
      this.elevation,
      this.controller,
      this.disableFocus,
      this.enable,
      this.isRequired = false,
      this.textDirection,
      this.initialValue,
      this.marginHorizontal,
      this.onValidate,
      this.onFieldSubmitted,
      this.onValueChanged,
      this.onValueSaved,
      this.onIconTapped})
      : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<AppTextField> {
  var _controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.

    // if (null != widget.controller) {
    //   widget.controller.dispose();
    // }
    if (null != _controller) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (null != widget.initialValue) {
      _controller.text = widget.initialValue ?? "";
      widget.controller?.text = widget.initialValue ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = SizerUtil.deviceType == DeviceType.mobile;
    double vpad = widget.paddingVertical ?? (isMobile ? Dim.h2 : 1.5.h);

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Dim.h_5, horizontal: widget.marginHorizontal ?? 0),
      child: TextFormField(
        focusNode: (null != widget.disableFocus && widget.disableFocus!)
            ? AlwaysDisabledFocusNode()
            : null,
        enabled: widget.enable ?? true,
        controller: widget.controller ?? _controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLines: widget.maxLines ?? null,
        minLines: widget.minLines ?? 1,
        maxLength: widget.maxLenght,
        keyboardType: widget.inputType ?? TextInputType.text,
        obscureText: widget.secureText ?? false,
        style: TS.medGrayDark10,
        decoration: InputDecoration(
          errorText: widget.errorText,
          filled: true,
          fillColor: widget.fillColor ?? AppColor.bkgGray,
          isDense: true,
          prefixIcon: (null != widget.prefixIcon)
              ? IconButton(
                  icon: Image.asset(
                    widget.prefixIcon!,
                    color: widget.iconColor ?? AppColor.grayDark2,
                    width: widget.iconSize ?? Dim.w5,
                  ),
                  onPressed: () {
                    if (null != widget.onIconTapped)
                      widget.onIconTapped!(
                          widget.controller?.text ?? _controller.text);
                  },
                )
              : null,
          suffixIcon: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (widget.isRequired)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: (null != widget.suffixIcon) ? 0 : Dim.w2),
                  child: Text(
                    "*",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.red,
                        fontSize: Dim.s10),
                  ),
                ),
              if (null != widget.suffixIcon)
                IconButton(
                  icon: Image.asset(
                    widget.suffixIcon!,
                    color: widget.iconColor ?? AppColor.grayDark2,
                    width: widget.iconSize ?? Dim.w5,
                  ),
                  onPressed: () {
                    if (null != widget.onIconTapped)
                      widget.onIconTapped!(
                          (widget.controller ?? _controller).text);
                  },
                ),
            ],
          ),
          hintText: (null != widget.hint && widget.hint!.isNotEmpty)
              ? widget.hint
              : "",
          hintStyle: TS.medGrayDark10,
          errorStyle: TS.regularRed8,
          counterStyle: TS.medBlack8,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColor.grayDark2, width: 1.4),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? Dim.h1),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.borderRadius ?? Dim.h1),
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColor.grayMed, width: 1.4),),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.red, width: 0.8),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? Dim.h1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? Dim.h1),
          ),
        ),
        validator: widget.onValidate,
        onSaved: widget.onValueSaved,
        onChanged: widget.onValueChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AlwaysEnabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}
