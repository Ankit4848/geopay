import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/data/home_data.dart';
import 'package:flutter/material.dart';

class WalletServiceCard extends StatelessWidget {
  const WalletServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: VariableUtilities.theme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Funds',
            style: FontUtilities.style(
              fontSize: 16,
              fontWeight: FWT.semiBold,
              fontColor: VariableUtilities.theme.whiteColor,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          BuildServiceButton(serviceModel: HomeData.walletService)
        ],
      ),
    );
  }
}
