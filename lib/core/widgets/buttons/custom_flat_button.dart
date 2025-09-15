// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core.dart';

class CustomFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;
  final Color? backColor;
  TextStyle? textStyle;
  bool isloaing;

  CustomFlatButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.width,
      this.padding,
      this.radius,
      this.isOutlined = false,
      this.height,
      this.textStyle,
      this.fontSize,
      this.isloaing = false,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: padding,
      height: height ?? 50,
      minWidth: width,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: isOutlined
                ? VariableUtilities.theme.blackColor.withOpacity(0.5)
                : VariableUtilities.theme.transparent),
        borderRadius: BorderRadius.circular(radius ?? 15),
      ),
      elevation: isOutlined ? 0 : 2,

      color: backColor ??
          (isOutlined
              ? const Color(0xFFFfffff)
              : VariableUtilities.theme.primaryColor),
      child: isloaing
          ? const Offstage()
          : Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  FontUtilities.style(
                    fontSize: fontSize ?? 14,
                    fontWeight: FWT.semiBold,
                    fontColor: isOutlined
                        ? VariableUtilities.theme.blackColor
                        : VariableUtilities.theme.whiteColor,
                  ),
            ),
    );
  }
}
