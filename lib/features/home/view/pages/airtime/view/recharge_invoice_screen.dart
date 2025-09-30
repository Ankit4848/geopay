import 'package:geopay/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add_money/widgets/balance_card.dart';

class RechargeInvoiceScreen extends StatelessWidget {
  const RechargeInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'International Airtime'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BalanceCard(),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color:
                                VariableUtilities.theme.textFieldFilledColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Total Amount',
                                  style: FontUtilities.style(
                                      fontSize: 12,
                                      fontFamily: FontFamily.dmSans,
                                      fontWeight: FWT.medium),
                                ),
                              ),
                              Text(
                                '17.20 USD',
                                style: FontUtilities.style(
                                    fontSize: 20,
                                    fontFamily: FontFamily.dmSans,
                                    fontWeight: FWT.bold,
                                    fontColor:
                                        VariableUtilities.theme.secondaryColor),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.2,
                            color: VariableUtilities.theme.blackColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Net Payable (USD)',
                                  style: FontUtilities.style(
                                      fontSize: 12,
                                      fontFamily: FontFamily.dmSans,
                                      fontWeight: FWT.medium),
                                ),
                              ),
                              Text(
                                '16.31 USD',
                                style: FontUtilities.style(
                                    fontSize: 12,
                                    fontFamily: FontFamily.dmSans,
                                    fontWeight: FWT.medium),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Fees (USD)',
                                  style: FontUtilities.style(
                                      fontSize: 12,
                                      fontFamily: FontFamily.dmSans,
                                      fontWeight: FWT.medium),
                                ),
                              ),
                              Text(
                                '0.89 USD',
                                style: FontUtilities.style(
                                    fontSize: 12,
                                    fontFamily: FontFamily.dmSans,
                                    fontWeight: FWT.medium),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: CustomFlatButton(
              onPressed: () {},
              backColor: VariableUtilities.theme.secondaryColor,
              title: "Pay",
            ),
          ),
        ],
      ),
    );
  }
}
