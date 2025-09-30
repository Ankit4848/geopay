import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: VariableUtilities.theme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Available Balance',
            style: FontUtilities.style(
                fontSize: 16,
                fontFamily: FontFamily.dmSans,
                fontColor: VariableUtilities.theme.whiteColor,
                fontWeight: FWT.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          GetBuilder<CommonController>(builder: (commonController) {
            return Text(
              '\$ ${double.parse(commonController.userModel.value?.balance?.toString() ?? '0.0').toStringAsFixed(2)}',
              style: FontUtilities.style(
                  fontSize: 36,
                  fontFamily: FontFamily.dmSans,
                  fontColor: VariableUtilities.theme.whiteColor,
                  fontWeight: FWT.bold),
            );
          }),
        ],
      ),
    );
  }
}
