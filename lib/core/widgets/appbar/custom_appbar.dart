// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../core.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final double? height;
  final bool showBackButton;
  final Widget? leading;
  final Widget? titleWidget;
  final List<Widget>? action;
  Function(String?)? onChange;
  final VoidCallback? onBackTap;
  final bool isCenterTitle;
  final bool showWallet;

  CustomAppBar({
    super.key,
    required this.title,
    this.action,
    this.onBackTap,
    this.showBackButton = true,
    this.onChange,
    this.isCenterTitle = false,
    this.height,
    this.leading,
    this.titleWidget,
    this.showWallet = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 90),
      child: Container(
        height: widget.height ?? 105,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          // color: VariableUtilities.theme.appBarColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 1,
              color: VariableUtilities.theme.whiteColor.withOpacity(0.12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.leading ??
                Visibility(
                  visible: widget.showBackButton,
                  child: Material(
                    color: VariableUtilities.theme.transparent,
                    child: InkWell(
                      onTap: widget.onBackTap ??
                          () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: VariableUtilities.theme.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
            if (widget.isCenterTitle) ...{
              const Spacer(),
            },
            widget.titleWidget ??
                Padding(
                  padding:
                      EdgeInsets.only(left: !widget.isCenterTitle ? 12.0 : 0),
                  child: Text(
                    widget.title,
                    style: FontUtilities.style(
                      fontSize: 16,
                      fontWeight: FWT.semiBold,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                  ),
                ),
            const Spacer(),
            Row(
              children: widget.action ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
