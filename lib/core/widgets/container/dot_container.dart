import 'package:flutter/material.dart';

import '../../core.dart';

class DotContainer extends StatelessWidget {
  final Color? color;
  const DotContainer({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? VariableUtilities.theme.whiteColor,
      ),
    );
  }
}
