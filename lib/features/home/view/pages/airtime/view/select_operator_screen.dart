import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/data/home_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../add_money/widgets/balance_card.dart';

class SelectOperatorScreen extends StatelessWidget {
  const SelectOperatorScreen({super.key});

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
                    Text(
                      'Select Operator',
                      style: FontUtilities.style(
                          fontSize: 16, fontWeight: FWT.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      hintText: 'Search a Operator',
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: HomeData.operatorList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: VariableUtilities.theme.textFieldFilledColor,
                          ),
                          child: Bounce(
                            onTap: () {
                              Get.toNamed(
                                  RouteUtilities.selectRechargePlanScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  HomeData.operatorList[index],
                                  style: FontUtilities.style(
                                    fontSize: 12,
                                    fontWeight: FWT.medium,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        VariableUtilities.theme.secondaryColor,
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
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
