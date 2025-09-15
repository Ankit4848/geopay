import 'package:flutter/material.dart';

import '../../core.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      seconds: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          3,
          (index) {
            return Container(
              height: index == 0 ? 12 : 8,
              width: index == 0 ? 12 : 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 0
                    ? VariableUtilities.theme.primaryColor
                    : VariableUtilities.theme.lightGrey,
              ),
            );
          },
        ),
      ),
    );
  }
}
