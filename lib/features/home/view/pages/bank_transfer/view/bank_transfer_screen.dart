import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/controller/bank_transfer_controller.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/view/add_bank_beneficiary_screen.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/widget/confirm_beneficiary_dialog.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/controller/momo_transfer_controller.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/view/add_mobile_beneficiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../model/drop_down_model.dart';
import '../../add_money/widgets/balance_card.dart';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  BankTransferController bankTransferController = Get.find();

  Widget _buildAmountInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bankTransferController.clearAllFields(); // <- You create this function
    super.dispose();
  }

  // 🔹 Password Dialog
  Future<bool> _showPasswordDialog() async {
    final TextEditingController passCtrl = TextEditingController();
    bool success = false;

    await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.black,
        // 🔹 black background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Enter Password",
          style: TextStyle(color: Colors.white), // 🔹 white font
        ),
        content: TextField(
          controller: passCtrl,
          obscureText: true,
          style: const TextStyle(color: Colors.white), // 🔹 input text white
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: const TextStyle(color: Colors.white54),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white54),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // close
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white), // 🔹 white text
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24, // 🔹 light grey btn on black bg
              foregroundColor: Colors.white, // 🔹 text white
            ),
            onPressed: () async {
              Get.focusScope?.unfocus();
              // 🔹 password verify API call
              bool isValid = await bankTransferController.getPassword(
                passCtrl.text,
              );

              if (isValid) {
                success = true;
                Get.back(); // close dialog
              } else {
                Get.snackbar(
                  "Error",
                  "Invalid password",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'Transfer to Bank'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const BalanceCard(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 4),
                    Image.asset(AssetUtilities.redLine),

                    /*const SizedBox(height: 20),*/
                    const SizedBox(height: 20),
                    /* CustomTextField(
                      hintText:
                          bankTransferController.selectedCountry.value?.label ??
                              'Select Payer Country',
                      labelText: 'Payer Country *',
                      errorWidget: bankTransferController.countryError.value!=""?
                      Text(bankTransferController.countryError.value,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12
                          )):Offstage(),
                      onTap: () {
                        Get.dialog(DropdownBottomsheet(
                          label: 'Select Payer Country',
                          dropDownItemList: bankTransferController
                              .countryCollectionList
                              .map((country) => DropDownModel(
                                  title: country.label!, icon: country.countryFlag))
                              .toList(),
                          onTap: (index) {
                            setState(() {
                              bankTransferController.changeSelectedCountry(
                                  bankTransferController
                                      .countryCollectionList[index]);
                            });
                          },
                        ));
                      },
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SvgPicture.asset(AssetUtilities.dropDown),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),*/
                    Obx(
                      () => Visibility(
                        visible: true,
                        child: CustomTextField(
                          onTap: () {
                            Get.dialog(
                              DropdownBottomsheet(
                                label: 'Select Recipient',

                                dropDownItemList:
                                    bankTransferController
                                        .mobileBeneficiaryList
                                        .value
                                        .map(
                                          (channel) => DropDownModel(
                                            title:
                                                " ${channel.data["receiverfirstname"]!} ${channel.data["receiverlastname"] ?? ""} (${channel.data["bankName"] ?? ""})",
                                            icon:
                                                "${channel.countryDetail["country_flag"] ?? ""}",
                                          ),
                                        )
                                        .toList(),

                                onTap: (index) {
                                  // Get.back();
                                  Get.dialog(
                                    ConfirmBeneficiaryDialog(
                                      mtmBeneficiaryModel:
                                          bankTransferController
                                              .mobileBeneficiaryList[index],
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            );
                          },
                          errorWidget:
                              bankTransferController.beneError.value != ""
                                  ? Text(
                                    bankTransferController.beneError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  )
                                  : const Offstage(),
                          hintText:
                              bankTransferController.selectedBene.value == null
                                  ? 'Select Recipient'
                                  : "${bankTransferController.selectedBene.value!.data["receiverfirstname"]} ${bankTransferController.selectedBene.value!.data["receiverlastname"] ?? ""} (${bankTransferController.selectedBene.value!.data["bankName"] ?? ""})",
                          labelText: 'Recipient *',
                          hintStyle: FontUtilities.style(
                            fontSize: 13,
                            fontWeight: FWT.regular,
                            fontColor: VariableUtilities.theme.blackColor,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: SvgPicture.asset(AssetUtilities.dropDown),
                          ),
                          // prefixIcon: Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 12.0),
                          //   child: SvgPicture.asset(
                          //       AssetUtilities.beneficiaryName),
                          // ),
                        ),
                      ),
                    ),

                    // Amount and Notes fields - only show after beneficiary confirmation
                    Obx(
                      () => Visibility(
                        visible:
                            bankTransferController.isBeneficiaryConfirmed.value,
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: bankTransferController.amountCtrl,
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              errorWidget:
                                  bankTransferController.amountError.value != ""
                                      ? Text(
                                        bankTransferController
                                            .amountError
                                            .value,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                      : const Offstage(),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              hintText: 'Enter you amount USD',
                              labelText: 'Amount *',
                              onChange: (value) async {
                                if (value!.isNotEmpty) {
                                  await bankTransferController
                                      .fetchAmountBreakdown();
                                } else {
                                  bankTransferController.commissionModel.value =
                                      null;
                                }
                                setState(() {});
                              },
                              // prefixIcon: Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              //   child: SvgPicture.asset(AssetUtilities.doller),
                              // ),
                            ),
                            const SizedBox(height: 8),
                            if (bankTransferController.commissionModel.value !=
                                null)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xfff9f9f9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildAmountInfo(
                                      'Processing Fee (${bankTransferController.commissionModel.value!.remitCurrency})',
                                      bankTransferController
                                          .commissionModel
                                          .value!
                                          .totalCharges!
                                          .toStringAsFixed(2),
                                    ),
                                    _buildAmountInfo(
                                      'Net Amount (${bankTransferController.commissionModel.value!.remitCurrency})',
                                      bankTransferController
                                          .commissionModel
                                          .value!
                                          .netAmount!
                                          .toStringAsFixed(2),
                                    ),
                                    _buildAmountInfo(
                                      'Receivable Amount (${bankTransferController.commissionModel.value!.payoutCurrency})',
                                      bankTransferController
                                          .commissionModel
                                          .value!
                                          .payoutCurrencyAmount!
                                          .toStringAsFixed(2),
                                    ),
                                  ],
                                ),
                              ),
                            Stack(
                              children: [
                                CustomTextField(
                                  controller:
                                      bankTransferController
                                          .accountDescriptionCtrl,
                                  hintText: 'Account Descriptions',
                                  labelText: 'Notes',
                                  maxLine: 5,
                                  minLine: 5,
                                ),
                                // Positioned(
                                //   top: 16,
                                //   left: 12,
                                //   child: SvgPicture.asset(AssetUtilities.edit),
                                // ),
                              ],
                            ),
                          ],
                        ),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: CustomFlatButton(
              onPressed: () async {
                bankTransferController.countryError.value = '';
                bankTransferController.beneError.value = '';
                bankTransferController.amountError.value = '';

                bool hasError = false;
                if (bankTransferController.selectedBene.value == null) {
                  bankTransferController.beneError.value =
                      'Please select and confirm a beneficiary.';
                  hasError = true;
                }
                if (bankTransferController.isBeneficiaryConfirmed.value &&
                    bankTransferController.amountCtrl.text.trim().isEmpty) {
                  bankTransferController.amountError.value =
                      'Amount is required.';
                  hasError = true;
                }

                var selectedCountryFromList =
                    bankTransferController.countryCollectionList
                        .where(
                          (country) =>
                              country.data ==
                              bankTransferController
                                  .selectedBene
                                  .value!
                                  .data["payoutCountry"],
                        )
                        .firstOrNull;

                if (selectedCountryFromList != null) {
                  bankTransferController.selectedCountry.value =
                      selectedCountryFromList;
                }

                setState(() {});
                if (hasError) return;

                bool isVerified = await _showPasswordDialog();
                if (!isVerified) return;

                if (bankTransferController.isbtnClick.value) return;
                bankTransferController.isbtnClick.value = true;
                bankTransferController.update();
                await bankTransferController.getTMtoMStore();
              },
              backColor: VariableUtilities.theme.secondaryColor,
              title: "Submit",
            ),
          ),
        ],
      ),
    );
  }
}
