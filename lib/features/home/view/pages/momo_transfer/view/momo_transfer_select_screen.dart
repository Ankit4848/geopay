import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/controller/momo_transfer_controller.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/view/add_mobile_beneficiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../add_money/widgets/balance_card.dart';

class MomoTransferSelectScreen extends StatefulWidget {
  const MomoTransferSelectScreen({super.key});

  @override
  State<MomoTransferSelectScreen> createState() =>
      _MomoTransferSelectScreenState();
}

class _MomoTransferSelectScreenState extends State<MomoTransferSelectScreen> {
  MomoTransferController momoTransferController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    momoTransferController.getCountryList();
  }
  @override
  void dispose() {
    momoTransferController.clearAllFields(); // <- You create this function
    super.dispose();
  }

  String getCountryFlag(String payoutCountry) {
    try {
      var country = momoTransferController.countryCollectionList
          .firstWhere((country) => country.name == payoutCountry);
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
            title: 'Transfer to Mobile Money Wallets',
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
                              onPressed: () {
                                Get.to(AddMobileBeneficiaryScreen(
                                  isEdit: false,
                                ))?.then(
                                      (value) async {
                                    await momoTransferController
                                        .changeSelectedCountry(
                                        momoTransferController
                                            .selectedCountry.value).then((value) {
                                      momoTransferController.getCountryList();
                                            },);
                                    EasyLoading.dismiss();
                                    setState(() {});
                                  },
                                );
                              },
                              height: Get.height*0.16,
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
                                Get.toNamed(RouteUtilities.momoTransfer);
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
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                    Obx(() {
                      return momoTransferController.mobileBeneficiaryRecentList.isEmpty?Container():Container(

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: const Color(0xff212121), width: 1)),
                        child: ListView.builder(
                            itemCount: momoTransferController.mobileBeneficiaryRecentList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 20,bottom: 20),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = momoTransferController
                                  .mobileBeneficiaryRecentList[index].data!;

                              return GestureDetector(
                                onTap: () async {
                                  var selectedCountryFromList = momoTransferController.countryCollectionList
                                      .where((country) => country.name == data.recipientCountryName)
                                      .firstOrNull;

                                  if (selectedCountryFromList != null) {
                                    momoTransferController.changeSelectedCountry(selectedCountryFromList);

                                    // Wait for beneficiary list to load
                                    await momoTransferController.getTMtoMBeneListStore();


                                    print(data.recipientMobile!);


                                    // Find and set the beneficiary
                                    var selectedBeneFromList = momoTransferController.mobileBeneficiaryList
                                        .where((bene) {

                                      print(bene.data!.recipientMobile!);
                                      return bene.data!.recipientMobile!.contains(data.recipientMobile!);
                                    })
                                        .firstOrNull;

                                    if (selectedBeneFromList != null) {
                                      momoTransferController.changeSelectedBene(selectedBeneFromList);
                                    }

                                    // Navigate to bank transfer screen
                                    Get.toNamed(RouteUtilities.momoTransfer);
                                  }

                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.recipientCountryName} (${data.recipientCountryCode})",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Color(0xff616161),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            margin: const EdgeInsets.only(right: 12),
                                            child: getCountryFlag(data.recipientCountryName!).isNotEmpty
                                                ? Image.network(
                                              getCountryFlag(data.recipientCountryName!),
                                              width: 28,
                                              height: 20,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Container(
                                                  width: 28,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                );
                                              },
                                            )
                                                : Container(
                                              width: 28,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Text(
                                                  "${data.recipientMobile}",
                                                  style: const TextStyle(
                                                      color: Color(0xff212121),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index < momoTransferController.mobileBeneficiaryRecentList.length - 1)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                          child: const Divider(
                                            color: Colors.black12,
                                            height: 1,
                                          ),
                                        )
                                    ],
                                  ),
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