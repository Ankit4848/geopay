import 'package:flutter/material.dart';

import '../../core.dart';

class InkwellWithRippleEffect extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final ShapeBorder? customBorder;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  const InkwellWithRippleEffect({
    super.key,
    required this.onTap,
    required this.child,
    this.customBorder,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: VariableUtilities.theme.transparent,
      child: InkWell(
        customBorder: customBorder ?? const CircleBorder(),
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
