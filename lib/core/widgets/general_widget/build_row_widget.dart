import 'package:flutter/material.dart';

import '../../core.dart';

class BuildRowWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color? textColor;
  const BuildRowWidget(
      {super.key, this.textColor, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title :",
              style: FontUtilities.style(
                fontSize: 10,
                fontWeight: FWT.semiBold,
                fontColor: VariableUtilities.theme.blackColor,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: FontUtilities.style(
                fontSize: 10,
                fontWeight: FWT.regular,
                fontColor: textColor ?? VariableUtilities.theme.blackColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
