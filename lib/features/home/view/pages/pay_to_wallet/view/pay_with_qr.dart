import 'package:geopay/core/app_assets/asset_images.dart';
import 'package:geopay/core/settings/variable_utilities.dart';
import 'package:geopay/core/widgets/appbar/custom_appbar.dart';
import 'package:geopay/core/widgets/buttons/custom_flat_button.dart';
import 'package:geopay/core/widgets/input_fields/custom_textfield.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/home/view/pages/add_money/widgets/balance_card.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/controller/pay_to_wallet_controller.dart';
import 'package:geopay/features/home/widgets/country_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/theme/font/font_theme.dart';

class PayWithQrScreen extends StatefulWidget {
  String? mobileNumber;
  int? countryId;

  PayWithQrScreen({super.key, this.mobileNumber, this.countryId});

  @override
  State<PayWithQrScreen> createState() => _PayWithQrScreenState();
}

class _PayWithQrScreenState extends State<PayWithQrScreen> {
  CommonController commonController = Get.find();
  PayToWalletController payToWalletController =
      Get.put(PayToWalletController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    payToWalletController.clearErrors();

    payToWalletController.selectCountry(widget.countryId!);
    payToWalletController.mobileCtrl.text = widget.mobileNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Pay To Wallet',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    const BalanceCard(),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      AssetUtilities.redLine,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => CustomTextField(
                        hintText:
                            payToWalletController.selectedCountry.value == null
                                ? "Select Payer Country"
                                : payToWalletController
                                        .selectedCountry.value!.name ??
                                    'Select Payer Country',

                        onTap: () {
                          /*  showDialog(
                            context: context,
                            barrierDismissible: false,
                            useSafeArea: true,
                            builder: (context) {
                              return Obx(
                                    () => CountryDialog(
                                  searchController: payToWalletController.searchController.value,
                                  onClose: () {
                                    payToWalletController.selectedCountry.value=null;
                                  },
                                  onChange: (value) {
                                    payToWalletController.onCountrySearch(value ?? '');
                                  },
                                  onCountrySelect: (countryModel) {
                                    payToWalletController.selectedCountry.value = countryModel;
                                  },
                                ),
                              );
                            },
                          );*/
                        },
                        labelText: 'Payer Country *',
                        hintStyle: FontUtilities.style(
                          fontSize: 13,
                          fontWeight: FWT.regular,
                          fontColor: VariableUtilities.theme.blackColor,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SvgPicture.asset(AssetUtilities.dropDown),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "Mobile Number *",
                          textAlign: TextAlign.left,
                          style: FontUtilities.style(
                            fontSize:  14,
                            fontWeight: FWT.semiBold,
                            fontFamily: FontFamily.poppins,
                            fontColor: VariableUtilities.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Obx(() => CustomTextField(
                          controller: payToWalletController.mobileCtrl,
                          onTap: () {},
                         /* suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.phoneBook),
                          ),*/
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          ],
                          hintText: 'Mobile No.',
                      hintStyle: FontUtilities.style(
                        fontSize: 13,
                        fontWeight: FWT.regular,
                        fontColor: VariableUtilities.theme.blackColor,
                      ),
                          errorWidget:
                              payToWalletController.mobileError.value != ""
                                  ? Text(
                                      payToWalletController.mobileError.value,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : Container(),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.phone),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),

                    Obx(() => CustomTextField(
                          controller: payToWalletController.amountCtrl,

                          textInputType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          ],
                          hintText: 'Enter Amount in USD (eg:100 or eg:0.00)',
                          labelText: 'Amount *',
                          errorWidget:
                              payToWalletController.amountError.value != ""
                                  ? Text(
                                      payToWalletController.amountError.value,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12))
                                  : Container(),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.doller),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        CustomTextField(
                          controller:
                              payToWalletController.accountDescriptionCtrl,
                          hintText: 'Account Descriptions',
                          labelText: 'Notes',
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




                payToWalletController.countryError.value = '';
                payToWalletController.mobileError.value = '';
                payToWalletController.amountError.value = '';

                bool hasError = false;
                if (payToWalletController.selectedCountry.value == null) {
                  payToWalletController.countryError.value = 'Country is required.';
                  hasError = true;
                }
                if (payToWalletController.mobileCtrl.text.trim().isEmpty) {
                  payToWalletController.mobileError.value = 'Mobile Number is required.';
                  hasError = true;
                }
                if (payToWalletController.amountCtrl.text.trim().isEmpty) {
                  payToWalletController.amountError.value = 'Amount is required.';
                  hasError = true;
                }
                payToWalletController.update();
                setState(() {

                });





                if(payToWalletController.isbtnClick.value)
                  return;
                payToWalletController.isbtnClick.value=true;
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
