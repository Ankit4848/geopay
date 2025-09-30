import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core.dart';

class ResultDialog extends StatelessWidget {
  final String? title;
  final String description;
  final String? positiveButtonText;
  final String? closeButtonText;
  final bool showPossitiveButton;
  final bool showCloseButton;
  final VoidCallback? onPositveTap;
  final VoidCallback? onCloseTap;
  final String? image;
  final double? fontSize;
  final double? descriptionFontSize;
  final Widget? descriptionWidget;
  final Widget? titleWidget;
  const ResultDialog({
    super.key,
    this.title,
    required this.description,
    this.positiveButtonText,
    this.closeButtonText,
    this.showPossitiveButton = true,
    this.showCloseButton = true,
    this.onPositveTap,
    this.onCloseTap,
    this.image,
    this.fontSize,
    this.descriptionFontSize,
    this.descriptionWidget,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: VariableUtilities.theme.primaryColor,
      elevation: 2,

      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shadowColor: VariableUtilities.theme.primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Lottie.asset(image ?? AssetUtilities.error,
          //       height: 100, width: 100),
          // ),
          Center(
            child: titleWidget ??
                Text(
                  textAlign: TextAlign.center,
                  title ?? 'Error!',
                  style: FontUtilities.style(
                      fontSize: 25,
                      fontWeight: FWT.bold,
                      fontColor: VariableUtilities.theme.whiteColor),
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: descriptionWidget ??
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: FontUtilities.style(
                    fontSize: descriptionFontSize ?? 17,
                    fontWeight: FWT.bold,
                    fontColor: VariableUtilities.theme.whiteColor,
                  ),
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Row(
              children: [
                if (showPossitiveButton) ...{
                  Expanded(
                    child: CustomFlatButton(
                      onPressed: onPositveTap ?? () {},
                      title: positiveButtonText ?? '',
                      fontSize: fontSize,
                      isOutlined: true,
                    ),
                  ),
                  if (showCloseButton)
                  const SizedBox(
                    width: 20,
                  ),
                },
                if (showCloseButton) ...{
                  Expanded(
                    child: CustomFlatButton(
                      fontSize: fontSize,
                      backColor: Color(0xffc6c6c6),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                      onPressed: onCloseTap ??
                          () {
                            Get.back();
                          },
                      title: closeButtonText ?? 'Close',
                    ),
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
