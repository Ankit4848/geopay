import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeHistoryCard extends StatelessWidget {
  final bool isTransactionHistory;
  final int? index;
  const RechargeHistoryCard(
      {super.key, this.isTransactionHistory = false, this.index});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: !isTransactionHistory
          ? () {
              Get.toNamed(RouteUtilities.rechargeInvoiceScreen);
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF5F4F4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (isTransactionHistory) ...{
                  BuildRowWidget(
                    title: 'Sr No.',
                    value: '$index',
                  ),
                } else ...{
                  Text(
                    'Airtel India',
                    style: FontUtilities.style(
                      fontSize: 10,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                },
                const SizedBox(width: 22),
                Expanded(
                  child: Container(
                    height: 1,
                    color: VariableUtilities.theme.blackColor.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BuildRowWidget(
                              title: 'Name',
                              value: 'Tejas Sharma',
                            ),
                          ),
                          Expanded(
                            child: BuildRowWidget(
                              title: 'Date ',
                              value: '25/10/2024',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildRowWidget(
                              title: 'Mobile',
                              value: '+919874563210',
                            ),
                          ),
                          Expanded(
                            child: BuildRowWidget(
                              title: 'Amount',
                              value: '16.31 USD',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isTransactionHistory)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VariableUtilities.theme.secondaryColor,
                    ),
                    child: Icon(
                      Icons.history,
                      color: VariableUtilities.theme.whiteColor,
                      size: 10,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
