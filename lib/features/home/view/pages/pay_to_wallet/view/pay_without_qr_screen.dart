import 'package:fintech/config/navigation/app_route.dart';
import 'package:fintech/features/home/view/pages/pay_to_wallet/controller/pay_to_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/core.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../widgets/country_dialog.dart';
import '../../add_money/widgets/balance_card.dart';

class PayWithoutQrScreen extends StatefulWidget {
  const PayWithoutQrScreen({super.key});

  @override
  State<PayWithoutQrScreen> createState() => _PayWithoutQrScreenState();
}

class _PayWithoutQrScreenState extends State<PayWithoutQrScreen> {
  CommonController commonController = Get.find();
  PayToWalletController payToWalletController = Get.find();

  /// 🔹 Centralized validation
  bool _validateFields() {
    bool isValid = true;
    payToWalletController.countryError.value = '';
    payToWalletController.mobileError.value = '';
    payToWalletController.amountError.value = '';

    // Country validation
    if (payToWalletController.selectedCountry.value == null) {
      payToWalletController.countryError.value = 'Country is required.';
      isValid = false;
    }

    // Mobile validation
    String mobile = payToWalletController.mobileCtrl.text.trim();
    if (mobile.isEmpty) {
      payToWalletController.mobileError.value = 'Mobile Number is required.';
      isValid = false;
    } else if (mobile.length < 7) {
      payToWalletController.mobileError.value = 'Enter valid Mobile Number.';
      isValid = false;
    }

    // Amount validation
    String amountText = payToWalletController.amountCtrl.text.trim();
    if (amountText.isEmpty) {
      payToWalletController.amountError.value = 'Amount is required.';
      isValid = false;
    } else {
      double? amount = double.tryParse(amountText);
      if (amount == null || amount <= 0) {
        payToWalletController.amountError.value =
        'Enter valid amount greater than 0.';
        isValid = false;
      }
    }

    setState(() {}); // refresh UI
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    payToWalletController.clearErrors();

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'Without QR Code'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    const BalanceCard(),
                    const SizedBox(height: 20),
                    Image.asset(AssetUtilities.redLine),
                    const SizedBox(height: 20),

                    // Country
                    Obx(
                          () => CustomTextField(
                        hintText: payToWalletController.selectedCountry.value ==
                            null
                            ? "Select Payer Country"
                            : payToWalletController
                            .selectedCountry.value!.name ??
                            'Select Payer Country',
                        labelText: "Payer Country *",
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            useSafeArea: true,
                            builder: (context) {
                              return Obx(
                                    () => CountryDialog(
                                  searchController: payToWalletController
                                      .searchController.value,
                                  onClose: () {
                                    payToWalletController.selectedCountry
                                        .value = null;
                                  },
                                  onChange: (value) {
                                    payToWalletController
                                        .onCountrySearch(value ?? '');
                                  },
                                  onCountrySelect: (countryModel) {
                                    payToWalletController
                                        .selectedCountry.value =
                                        countryModel;
                                  },
                                ),
                              );
                            },
                          );
                        },
                        errorWidget: payToWalletController
                            .countryError.value.isNotEmpty
                            ? Text(
                          payToWalletController.countryError.value,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12),
                        )
                            : Container(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SvgPicture.asset(AssetUtilities.dropDown),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Mobile label
                    Row(
                      children: [
                        Text(
                          "Mobile Number *",
                          style: FontUtilities.style(
                            fontSize: 14,
                            fontWeight: FWT.semiBold,
                            fontFamily: FontFamily.poppins,
                            fontColor: VariableUtilities.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Mobile input
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Obx(
                                () => CustomTextField(
                              hintText: payToWalletController
                                  .selectedCountry.value ==
                                  null
                                  ? "+"
                                  : "+${payToWalletController.selectedCountry.value!.isdcode}",
                                  onTap: () { },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 8,
                          child: Obx(
                                () => CustomTextField(
                              controller: payToWalletController.mobileCtrl,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child:
                                SvgPicture.asset(AssetUtilities.phoneBook),
                              ),
                              textInputType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              hintText: 'Mobile No.',
                              errorWidget: payToWalletController
                                  .mobileError.value.isNotEmpty
                                  ? Text(
                                payToWalletController.mobileError.value,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : Container(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: SvgPicture.asset(AssetUtilities.phone),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Amount
                    Obx(
                          () => CustomTextField(
                        controller: payToWalletController.amountCtrl,
                        textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),],
                        hintText: 'Enter Amount in USD (eg:100 or 0.00)',
                        labelText: "Amount *",
                        errorWidget: payToWalletController.amountError.value.isNotEmpty ? Text(payToWalletController.amountError.value,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12),
                        )
                            : Container(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SvgPicture.asset(AssetUtilities.doller),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Note
                    Stack(
                      children: [
                        CustomTextField(
                          controller:
                          payToWalletController.accountDescriptionCtrl,
                          hintText: 'Account Descriptions',
                          labelText: "Note",
                          maxLine: 5,
                          minLine: 5,
                          contentPadding:
                          const EdgeInsets.fromLTRB(40, 14, 12, 12),
                        ),
                        Positioned(
                          top: 43,
                          left: 12,
                          child: SvgPicture.asset(AssetUtilities.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
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
              onPressed: () async {










                FocusScope.of(context).unfocus();

                if (!_validateFields()) {
                  Get.snackbar("Validation Error",
                      "Please fix the errors before proceeding.");
                  return;
                }

                if (payToWalletController.isbtnClick.value) return;

                payToWalletController.isbtnClick.value = true;
                payToWalletController.update();

                await payToWalletController.payWithoutQr(context);
              },
              backColor: VariableUtilities.theme.secondaryColor,
              title: "Pay Money",
            ),
          ),
        ],
      ),
    );
  }
}
