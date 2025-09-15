import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/controller/momo_transfer_controller.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/view/add_mobile_beneficiary_screen.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/widgets/confirm_beneficiary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../model/drop_down_model.dart';
import '../../add_money/widgets/balance_card.dart';

class MomoTransferScreen extends StatefulWidget {
  const MomoTransferScreen({super.key});

  @override
  State<MomoTransferScreen> createState() => _MomoTransferScreenState();
}

class _MomoTransferScreenState extends State<MomoTransferScreen> {
  MomoTransferController momoTransferController = Get.find();

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
    momoTransferController.clearAllFields(); // <- You create this function
    super.dispose();
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
                   /* CustomFlatButton(
                      onPressed: () {
                        Get.to(AddMobileBeneficiaryScreen(isEdit: false,))?.then((value) async {

                         await momoTransferController.changeSelectedCountry(momoTransferController.selectedCountry.value);
                         EasyLoading.dismiss();
                          setState(() {

                          });

                        },);

                      },
                      backColor: VariableUtilities.theme.secondaryColor,
                      title: 'Add Beneficiary Details',
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
                    CustomTextField(
                      hintText: momoTransferController.selectedCountry.value?.name ?? 'Select Payer Country',
                      labelText:  'Payer Country *',
                      onTap: () {
                        Get.dialog(DropdownBottomsheet(
                          label: 'Select Payer Country',
                          dropDownItemList: momoTransferController.countryCollectionList
                              .map((country) => DropDownModel(title: country.name!, icon: country.countryFlag))
                              .toList(),
                          onTap: (index) async {
                            await momoTransferController.changeSelectedCountry(momoTransferController.countryCollectionList[index]);
                            setState(()  {



                            });},
                        ));
                      },
                      errorWidget: momoTransferController.countryError.value!=""?
                      const Text("The country code field is required.",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12
                          )):Offstage(),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SvgPicture.asset(AssetUtilities.dropDown),
                      ),
                    ),


                    if(momoTransferController.selectedCountry.value !=
                        null)
                    SizedBox(height: 12,),
                    Obx(
                      () => Visibility(
                        visible: momoTransferController.selectedCountry.value !=
                            null,
                        child: CustomTextField(
                          onTap: () {
                            Get.dialog(
                              DropdownBottomsheet(
                                label: momoTransferController.selectedBene.value==null?'Select Recipient':momoTransferController.selectedBene.value!.data!.recipientName!,
                                dropDownItemList: momoTransferController.mobileBeneficiaryList.value
                                    .map((channel) => DropDownModel(title: "${channel.data!.recipientName!} ${channel.data!.recipientSurname!} (${channel.data!.recipientMobile!})", icon: ''))
                                    .toList(),
                                onTap: (index) {
                                 // Get.back();
                                  Get.dialog(
                                     ConfirmBeneficiaryDialog(
                                       mtmBeneficiaryModel:  momoTransferController.mobileBeneficiaryList[index],

                                     ),
                                  );
                                },
                              ),
                            );
                          },
                          hintText: momoTransferController.selectedBene.value==null?'Select Recipient':"${momoTransferController.selectedBene.value!.data!.recipientName!} ${momoTransferController.selectedBene.value!.data!.recipientSurname!} (${momoTransferController.selectedBene.value!.data!.recipientMobile!})",
                          labelText:  'Recipient *',
                          errorWidget: momoTransferController.beneError.value!=""?
                          const Text("The Recipient id field is required.",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12
                              )):Offstage(),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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

                    SizedBox(height: 12,),
                    CustomTextField(
                      controller: momoTransferController.amountCtrl,
                      textInputType:  TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),],
                      hintText: 'Enter Amount in USD',
                      labelText:  'Amount *',
                      errorWidget: momoTransferController.amountError.value!=""?
                      const Text("The txn amount field is required.",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12
                        )):Offstage(),
                      onChange: (value) async {

                        if(value!.isNotEmpty) {
                          await momoTransferController.fetchAmountBreakdown();
                        }else
                          {
                            momoTransferController.commissionModel.value=null;
                          }
                        setState(() {

                        });
                      },
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //   child: SvgPicture.asset(AssetUtilities.doller),
                      // ),
                    ),
                    if (momoTransferController.commissionModel.value != null)
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
                              'Processing Fee (${momoTransferController.commissionModel.value!.remitCurrency})',
                              momoTransferController.commissionModel.value!.totalCharges!.toStringAsFixed(2),
                            ),
                            _buildAmountInfo(
                              'Net Amount (${momoTransferController.commissionModel.value!.remitCurrency})',
                              momoTransferController.commissionModel.value!.netAmount!.toStringAsFixed(2),
                            ),
                            _buildAmountInfo(
                              'Receivable Amount (${momoTransferController.commissionModel.value!.payoutCurrency})',
                              momoTransferController.commissionModel.value!.payoutCurrencyAmount!.toStringAsFixed(2),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 12,),
                    Stack(
                      children: [
                        CustomTextField(
                          controller:
                              momoTransferController.accountDescriptionCtrl,
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


                momoTransferController.countryError.value = '';
                momoTransferController.beneError.value = '';
                momoTransferController.amountError.value = '';

                bool hasError = false;
                if (momoTransferController.selectedCountry.value == null) {
                  momoTransferController.countryError.value = 'Country is required.';
                  hasError = true;
                }
                if (momoTransferController.selectedBene.value == null) {
                  momoTransferController.beneError.value = 'Beneficiary is required.';
                  hasError = true;
                }
                if (momoTransferController.amountCtrl.text.trim().isEmpty) {
                  momoTransferController.amountError.value = 'Amount is required.';
                  hasError = true;
                }
                setState(() {

                });
                if (hasError) return;


                bool isVerified = await _showPasswordDialog();
                if (!isVerified) return;

                if(momoTransferController.isbtnClick.value)
                  return;
                momoTransferController.isbtnClick.value=true;
                momoTransferController.update();
                await momoTransferController.getTMtoMStore();



              },
              backColor: VariableUtilities.theme.secondaryColor,
              isloaing:  momoTransferController.isbtnClick.value,
              title: "Submit",
            ),
          ),
        ],
      ),
    );
  }
  // 🔹 Password Dialog
  Future<bool> _showPasswordDialog() async {
    final TextEditingController passCtrl = TextEditingController();
    bool success = false;

    await Get.dialog(

      AlertDialog(

        backgroundColor: Colors.black, // 🔹 black background
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
              bool isValid =
              await momoTransferController.getPassword(passCtrl.text);


              if (isValid) {
                success = true;
                Get.back(); // close dialog
              } else {
                Get.snackbar("Error", "Invalid password",
                    backgroundColor: Colors.red, colorText: Colors.white);
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
}
