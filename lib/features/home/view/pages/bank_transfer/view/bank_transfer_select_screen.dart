import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/bank_transfer/controller/bank_transfer_controller.dart';
import 'package:fintech/features/home/view/pages/bank_transfer/view/add_bank_beneficiary_screen.dart';
import 'package:fintech/features/home/view/pages/bank_transfer/widget/confirm_beneficiary_dialog.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/controller/momo_transfer_controller.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/view/add_mobile_beneficiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../../../model/drop_down_model.dart';
import '../../add_money/widgets/balance_card.dart';

class BankTransferSelectScreen extends StatefulWidget {
  const BankTransferSelectScreen({super.key});

  @override
  State<BankTransferSelectScreen> createState() =>
      _BankTransferSelectScreenState();
}

class _BankTransferSelectScreenState extends State<BankTransferSelectScreen> {
  BankTransferController bankTransferController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bankTransferController.getCountryList();
  }

  @override
  void dispose() {
    bankTransferController.clearAllFields(); // <- You create this function
    super.dispose();
  }
  String getCountryFlag(String payoutCountry) {
    try {
      var country = bankTransferController.countryCollectionList
          .firstWhere((country) => country.data == payoutCountry);
      return country.countryFlag ?? '';
    } catch (e) {
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Transfer to Bank Account’s',
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    const BalanceCard(),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 4),
                    Image.asset(AssetUtilities.redLine),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: MaterialButton(
                              height: Get.height*0.16,
                          onPressed: () {
                            Get.to(AddBankBeneficiaryScreen(
                              isEdit: false,
                            ))?.then((v) async {
                              await bankTransferController
                                  .getTMtoMBeneListStore().then((value) {
                                    bankTransferController.getCountryList();
                                  },);
                              EasyLoading.dismiss();
                              setState(() {});
                            });
                          },




                            color: VariableUtilities.theme.secondaryColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: VariableUtilities.theme.secondaryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80)),
                                child: Image.asset(
                                  "assets/images/main_image/add.png",
                                  color: VariableUtilities.theme.secondaryColor,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'New Recipient',
                                textAlign: TextAlign.center,
                                style: FontUtilities.style(
                                  fontSize: 17,
                                  fontWeight: FWT.semiBold,
                                  fontColor: VariableUtilities.theme.whiteColor,
                                ),
                              )
                            ],
                          ),
                        )),
                        const SizedBox(width: 20),
                        Expanded(
                            child: MaterialButton(
                              height: Get.height*0.16,
                          onPressed: () {
                            Get.toNamed(RouteUtilities.bankTransfer);
                            EasyLoading.dismiss();
                          },
                          color: VariableUtilities.theme.secondaryColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: VariableUtilities.theme.secondaryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80)),
                                child: Image.asset(
                                  "assets/images/main_image/list.png",
                                  color: VariableUtilities.theme.secondaryColor,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Saved Beneficiaries',
                                textAlign: TextAlign.center,
                                style: FontUtilities.style(
                                  fontSize: 17,
                                  fontWeight: FWT.semiBold,
                                  fontColor: VariableUtilities.theme.whiteColor,
                                ),
                              )
                            ],
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset(AssetUtilities.redLine),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        Text(
                          "Recent",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Obx(() {
                      return  bankTransferController
                          .mobileBeneficiaryRecentList.isEmpty?Container():Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: const Color(0xff212121), width: 1)),
                        child: ListView.builder(
                            itemCount: bankTransferController
                                .mobileBeneficiaryRecentList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = bankTransferController
                                  .mobileBeneficiaryRecentList[index].data;

                              return GestureDetector(
                                onTap: () async {
                                  var selectedCountryFromList = bankTransferController.countryCollectionList
                                      .where((country) => country.data == data["payoutCountry"])
                                      .firstOrNull;

                                  if (selectedCountryFromList != null) {
                                    bankTransferController.changeSelectedCountry(selectedCountryFromList);

                                    // Wait for beneficiary list to load
                                    await bankTransferController.getTMtoMBeneListStore();

                                    // Find and set the beneficiary
                                    var selectedBeneFromList = bankTransferController.mobileBeneficiaryList
                                        .where((bene) => bene.data["bankaccountnumber"] == data["bankaccountnumber"])
                                        .firstOrNull;

                                    if (selectedBeneFromList != null) {
                                      bankTransferController.changeSelectedBene(selectedBeneFromList);
                                    }

                                    // Navigate to bank transfer screen
                                    Get.toNamed(RouteUtilities.bankTransfer);
                                  }

                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["payoutCountryName"]} (${data["payoutCountry"]})",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Color(0xff616161),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(80)
                                          ),
                                          margin: EdgeInsets.only(right: 8),
                                          child: getCountryFlag(data["payoutCountry"]).isNotEmpty
                                              ? Image.network(
                                            getCountryFlag(data["payoutCountry"]),
                                            width: 24,
                                            height: 16,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                width: 24,
                                                height: 16,
                                                color: Colors.grey[300],
                                              );
                                            },
                                          )
                                              : Container(
                                            width: 24,
                                            height: 16,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Text(
                                            "${data["bankaccountnumber"]}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Color(0xff212121),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],)),


                                      ],
                                    ),

                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      child: Divider(
                                        color: Colors.black12,
                                        height: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
