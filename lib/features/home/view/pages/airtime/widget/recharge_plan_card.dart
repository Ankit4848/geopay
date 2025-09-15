import 'package:fintech/core/core.dart';
import 'package:flutter/material.dart';

class RechargePlanCard extends StatelessWidget {
  const RechargePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: VariableUtilities.theme.textFieldFilledColor,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              '16.31 USD',
              style: FontUtilities.style(
                  fontSize: 12,
                  fontWeight: FWT.medium,
                  fontColor: VariableUtilities.theme.blackColor),
            ),
            const SizedBox(
              width: 14,
            ),
            VerticalDivider(
              thickness: 2,
              color: VariableUtilities.theme.secondaryColor,
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Text(
                'Topup Plan - 1000 INR',
                style: FontUtilities.style(
                    fontSize: 12,
                    fontWeight: FWT.medium,
                    fontColor: VariableUtilities.theme.blackColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VariableUtilities.theme.secondaryColor,
              ),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: VariableUtilities.theme.whiteColor,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
