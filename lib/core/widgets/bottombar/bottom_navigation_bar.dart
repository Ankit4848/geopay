import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/dashboard/data/dashboard_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarContainer extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTap;
  const BottomBarContainer(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.33, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: VariableUtilities.theme.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          DashboardData.bottomOption.length,
          (index) {
            return Bounce(
              onTap: () {
                onTap(index);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: currentIndex == index
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF27435B),
                        border: Border.all(
                            color: VariableUtilities.theme.whiteColor
                                .withOpacity(0.3),
                            width: 1.5),
                      )
                    : null,
                child: SvgPicture.asset(DashboardData.bottomOption[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
