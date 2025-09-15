import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class HeadingText extends StatelessWidget {
  final String text;
  final VoidCallback? onSelectAllTap;
  const HeadingText({
    super.key,
    required this.text,
    this.onSelectAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: FontUtilities.style(
            fontSize: 14,
            fontWeight: FWT.semiBold,
            fontColor: VariableUtilities.theme.whiteColor,
          ),
        ),
        if (onSelectAllTap != null)
          Bounce(
            onTap: onSelectAllTap,
            child: Row(
              children: [
                Text(
                  'See All',
                  style: FontUtilities.style(
                    fontSize: 10,
                    fontWeight: FWT.black,
                    fontColor: VariableUtilities.theme.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: VariableUtilities.theme.whiteColor,
                  size: 15,
                )
              ],
            ),
          ),
      ],
    );
  }
}
