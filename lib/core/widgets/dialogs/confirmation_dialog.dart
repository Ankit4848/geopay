import 'package:fintech/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
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
  const ConfirmationDialog({
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
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 58,
                width: 58,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Center(
                  child: SvgPicture.asset(
                    AssetUtilities.error,
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 196,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetUtilities.dialogBack),
                      fit: BoxFit.contain),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 52,
                    ),
                    Text(
                      title ?? "Are You sure?",
                      style: FontUtilities.style(
                        fontSize: 20,
                        fontWeight: FWT.semiBold,
                        fontColor: const Color(0xFFD92D20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: FontUtilities.style(
                          fontSize: 15,
                          fontWeight: FWT.light,
                          fontColor: const Color(0xFF1C1E28),
                        ).copyWith(height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomFlatButton(
                              onPressed: () {
                                Get.back();
                              },
                              title: 'Cancel',
                              isOutlined: true,
                              height: 44,
                              radius: 4,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: CustomFlatButton(
                              onPressed: onPositveTap ?? () {},
                              title: 'Delete',
                              height: 44,
                              radius: 4,
                              backColor: const Color(0xFFD92D20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
