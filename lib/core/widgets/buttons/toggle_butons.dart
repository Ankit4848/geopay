import 'package:bounce/bounce.dart';

import 'package:flutter/material.dart';

import '../../core.dart';

class ToggleButons extends StatelessWidget {
  final List<String> buttonTextList;
  final int selectedIndex;
  final Function(int index) onSelectTap;
  const ToggleButons({
    super.key,
    required this.buttonTextList,
    required this.selectedIndex,
    required this.onSelectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(51),
        color: const Color(0xFF101010).withOpacity(0.5),
        border: Border.all(
          color: VariableUtilities.theme.whiteColor.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: List.generate(
          buttonTextList.length,
          (index) {
            return Expanded(
              child: Bounce(
                onTap: () {
                  onSelectTap(index);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: selectedIndex == index
                        ? VariableUtilities.theme.primaryColor
                        : VariableUtilities.theme.transparent,
                  ),
                  child: Center(
                    child: Text(
                      buttonTextList[index],
                      maxLines: 1,
                      style: FontUtilities.style(
                          fontSize: 12,
                          fontWeight: FWT.bold,
                          fontColor: selectedIndex == index
                              ? VariableUtilities.theme.blackColor
                              : VariableUtilities.theme.whiteColor),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
