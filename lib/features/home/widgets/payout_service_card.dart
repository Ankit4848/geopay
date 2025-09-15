import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../data/home_data.dart';

class PayoutServiceCard extends StatelessWidget {
  const PayoutServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: VariableUtilities.theme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pay Out Service',
            style: FontUtilities.style(
              fontSize: 16,
              fontWeight: FWT.semiBold,
              fontColor: VariableUtilities.theme.whiteColor,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          BuildServiceButton(serviceModel: HomeData.payOutService)
        ],
      ),
    );
  }
}
