import 'package:geopay/config/navigation/app_route.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/controller/pay_to_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/core.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../widgets/country_dialog.dart';
import '../../add_money/widgets/balance_card.dart';

class PayWithoutQrScreen extends StatefulWidget {
  final String? countryId;
  final String? mobileNumber;

  const PayWithoutQrScreen({
    super.key,
    this.countryId,
    this.mobileNumber,
  });

  @override
  State<PayWithoutQrScreen> createState() => _PayWithoutQrScreenState();
}

class _PayWithoutQrScreenState extends State<PayWithoutQrScreen> {
  CommonController commonController = Get.find();
  PayToWalletController payToWalletController = Get.put(PayToWalletController(), permanent: false);

  @override
  void initState() {
    super.initState();
    // Auto-populate fields if QR data is provided
    if (widget.countryId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setCountryById(widget.countryId!);
      });
    }
    if (widget.mobileNumber != null) {
      payToWalletController.mobileCtrl.text = widget.mobileNumber!;
    }
  }

  void _setCountryById(String countryId) {
    try {
      final country = commonController.countryList.firstWhere(
        (c) => c.id.toString() == countryId,
      );
      payToWalletController.selectedCountry.value = country;
    } catch (e) {
      print('Country not found for ID: $countryId');
    }
  }

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

  /// 🔹 Password Dialog
  Future<bool> _showPasswordDialog() async {
    final TextEditingController passCtrl = TextEditingController();
    bool success = false;

    await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Enter Password",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: passCtrl,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
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
              Get.back();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Get.focusScope?.unfocus();
              // Password verify API call
              bool isValid = await payToWalletController.getPassword(
                passCtrl.text,
              );

              if (isValid) {
                success = true;
                Get.back();
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
                            hintStyle: FontUtilities.style(
                              fontSize: 13,
                              fontWeight: FWT.regular,
                              fontColor: VariableUtilities.theme.blackColor,
                            ),
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
                                  hintStyle: FontUtilities.style(
                                    fontSize: 13,
                                    fontWeight: FWT.regular,
                                    fontColor: VariableUtilities.theme.blackColor,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 8,
                          child: Obx(
                                () => CustomTextField(
                              controller: payToWalletController.mobileCtrl,
                             /* suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child:
                                SvgPicture.asset(AssetUtilities.phoneBook),
                              ),*/
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

                // Show password dialog before proceeding
                bool isVerified = await _showPasswordDialog();
                if (!isVerified) return;

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
