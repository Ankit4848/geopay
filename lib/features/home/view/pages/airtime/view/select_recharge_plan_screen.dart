import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/airtime/controller/airtime_controller.dart';
import 'package:fintech/features/home/view/pages/airtime/widget/recharge_plan_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add_money/widgets/balance_card.dart';

class SelectRechargePlanScreen extends StatefulWidget {
  const SelectRechargePlanScreen({super.key});

  @override
  State<SelectRechargePlanScreen> createState() =>
      _SelectRechargePlanScreenState();
}

class _SelectRechargePlanScreenState extends State<SelectRechargePlanScreen>
    with SingleTickerProviderStateMixin {
  AirtimeController airtimeController = Get.find();

  @override
  void initState() {
    airtimeController.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: BalanceCard(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '+91 9874563210 - Airtel',
                      style: FontUtilities.style(
                          fontSize: 16,
                          fontWeight: FWT.bold,
                          fontColor: VariableUtilities.theme.secondaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      hintText: 'Search a Plan',
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TabBar(
                      controller: airtimeController.tabController,
                      dividerColor: const Color(0xFFAEAED3).withOpacity(0.83),
                      dividerHeight: 0.5,
                      indicatorColor: VariableUtilities.theme.secondaryColor,
                      labelStyle: FontUtilities.style(
                        fontSize: 14,
                        fontWeight: FWT.semiBold,
                        fontColor: const Color(0xFF21252E),
                      ),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelStyle: FontUtilities.style(
                        fontSize: 14,
                        fontWeight: FWT.regular,
                        fontColor: const Color(0xFF555555),
                      ),
                      tabs: const [
                        Tab(
                          text: 'Topup Plan',
                        ),
                        Tab(
                          text: 'Data',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.56,
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      viewportFraction: 1,
                      controller: airtimeController.tabController,
                      children: [
                        buildPlanList(),
                        buildPlanList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPlanList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      itemBuilder: (context, index) {
        return Bounce(
            onTap: () {
              Get.toNamed(RouteUtilities.rechargeInvoiceScreen);
            },
            child: const RechargePlanCard());
      },
    );
  }
}
