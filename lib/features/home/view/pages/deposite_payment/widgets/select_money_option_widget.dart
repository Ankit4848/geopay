import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/data/home_data.dart';
import 'package:flutter/material.dart';

class SelectMoneyOptionWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const SelectMoneyOptionWidget(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      itemCount: HomeData.addMoneyOption.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: VariableUtilities.theme.blackColor.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: Bounce(
            onTap: () {
              onTap(index);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 24,
                  width: 24,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F4F4),
                  ),
                  child: index == selectedIndex
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: VariableUtilities.theme.secondaryColor,
                          ),
                        )
                      : const Offstage(),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Text(
                    HomeData.addMoneyOption[index],
                    style: FontUtilities.style(
                        fontSize: 12,
                        fontWeight: FWT.medium,
                        fontColor: VariableUtilities.theme.primaryColor),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
