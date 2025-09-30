import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/view/pages/add_money/widgets/balance_card.dart';
import 'package:geopay/features/home/view/pages/airtime/controller/airtime_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../common/controller/common_controller.dart';
import '../../../../widgets/country_dialog.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  late AirtimeController airtimeController;
  late CommonController commonController;

  @override
  void initState() {
    super.initState();
    airtimeController = Get.find();
    commonController = Get.find();
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: BalanceCard(),
                  ),
                  const SizedBox(height: 4),
                  Image.asset(AssetUtilities.redLine),
                  const SizedBox(height: 20),
                  Obx(() => CustomTextField(
                        hintText: airtimeController.selectedCountry.value ==
                                null
                            ? "Select Payer Country"
                            : airtimeController.selectedCountry.value!.name ??
                                'Select Payer Country',
                        labelText: 'Payer Country *',
                    hintStyle: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                        errorWidget: airtimeController.countryError.value != ""
                            ? Text(airtimeController.countryError.value,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12))
                            : const Offstage(),
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            useSafeArea: true,
                            builder: (context) {
                              return Obx(() => CountryDialogAirTime(
                                    searchController: airtimeController
                                        .searchController.value,
                                    onClose: () {
                                      airtimeController.selectedCountry.value =
                                          null;
                                    },
                                    onChange: (value) {
                                      airtimeController
                                          .onCountrySearch(value ?? '');
                                    },
                                    onCountrySelect: (countryModel) {
                                      airtimeController.selectedCountry.value =
                                          countryModel;

                                      airtimeController.selectedOprator.value =
                                          null;
                                      airtimeController.selectedProduct.value =
                                          null;
                                      setState(() {});
                                      airtimeController.getOperator();
                                    },
                                  ));
                            },
                          );
                        },
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SvgPicture.asset(AssetUtilities.dropDown),
                        ),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => airtimeController.opratorList.isEmpty
                      ? Container()
                      : CustomTextField(
                          hintText: airtimeController.selectedOprator.value ==
                                  null
                              ? "Select Operator "
                              : airtimeController.selectedOprator.value!.name ??
                                  'Select Operator',
                          labelText: "Operator *",
                    hintStyle: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                          errorWidget:
                              airtimeController.operatorError.value != ""
                                  ? Text(airtimeController.operatorError.value,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12))
                                  : const Offstage(),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              useSafeArea: true,
                              builder: (context) {
                                return Obx(() => OpratorDialogAirTime(
                                      searchController: airtimeController
                                          .searchOpratorController.value,
                                      onClose: () {
                                        airtimeController
                                            .selectedOprator.value = null;
                                      },
                                      onChange: (value) {
                                        airtimeController
                                            .onOpratorSearch(value ?? '');
                                      },
                                      onCountrySelect: (countryModel) {
                                        airtimeController.selectedOprator
                                            .value = countryModel;
                                        airtimeController
                                            .selectedProduct.value = null;
                                        setState(() {});

                                        airtimeController.getProduct();
                                      },
                                    ));
                              },
                            );
                          },
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.dropDown),
                          ),
                        )),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => airtimeController.productList.isEmpty
                      ? Container()
                      : CustomTextField(
                          hintText: airtimeController.selectedProduct.value ==
                                  null
                              ? "Select Product "
                              : airtimeController.selectedProduct.value!.name ??
                                  'Select Product',
                          labelText: "Product *",
                    hintStyle: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                          errorWidget:
                              airtimeController.productError.value != ""
                                  ? Text(airtimeController.productError.value,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12))
                                  : const Offstage(),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              useSafeArea: true,
                              builder: (context) {
                                return Obx(() => ProductDialogAirTime(
                                      searchController: airtimeController
                                          .searchProductController.value,
                                      onClose: () {
                                        airtimeController
                                            .selectedProduct.value = null;
                                      },
                                      onChange: (value) {
                                        airtimeController
                                            .onOpratorSearch(value ?? '');
                                      },
                                      onCountrySelect: (countryModel) {
                                        airtimeController.selectedProduct
                                            .value = countryModel;
                                        setState(() {});
                                      },
                                    ));
                              },
                            );
                          },
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.dropDown),
                          ),
                        )),
                  if (airtimeController.selectedOprator.value != null)
                    const SizedBox(
                      height: 12,
                    ),
                  if (airtimeController.selectedProduct.value != null)
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
                            'Processing Fee (${airtimeController.selectedProduct.value!.remitCurrency})',
                            double.parse(airtimeController
                                    .selectedProduct.value!.platformFees!)
                                .toStringAsFixed(2),
                          ),
                          _buildAmountInfo(
                            'Net Amount (${airtimeController.selectedProduct.value!.remitCurrency})',
                            airtimeController
                                .selectedProduct.value!.retailUnitAmount!
                                .toStringAsFixed(2),
                          ),
                          _buildAmountInfo(
                            'Receivable Amount (${airtimeController.selectedProduct.value!.destinationCurrency})',
                            airtimeController
                                .selectedProduct.value!.destinationRates!
                                .toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                  if (airtimeController.selectedProduct.value != null)
                    const SizedBox(height: 12),
                  Text(
                    "Mobile Number *",
                    style: FontUtilities.style(
                      fontSize: 14,
                      fontWeight: FWT.semiBold,
                      fontFamily: FontFamily.poppins,
                      fontColor: VariableUtilities.theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: CustomTextField(
                            onTap: () {},
                            hintText: airtimeController.selectedCountry.value !=
                                    null
                                ? "+${airtimeController.selectedCountry.value!.isdcode}"
                                : '+255',
                            hintStyle: FontUtilities.style(
                              fontSize: 13,
                              fontWeight: FWT.regular,
                              fontColor: VariableUtilities.theme.blackColor,
                            ),
                            textInputType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChange: (value) => airtimeController.fieldErrors
                                .remove('mobile_no'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          controller: airtimeController.mobileNumberCtrl,
                          hintText: 'Mobile No.',
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChange: (value) {
                            airtimeController.getValidationMobile().then(
                              (value) {
                                setState(() {});
                              },
                            );
//                              }

                            return airtimeController.fieldErrors
                                .remove('mobile_no');
                          },
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.phone),
                          ),
                          errorWidget:
                              airtimeController.fieldErrors['mobile_no'] != null
                                  ? Text(
                                      airtimeController
                                          .fieldErrors['mobile_no']!,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : Container(),
                         /* suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.phoneBook),
                          ),*/
                        ),
                      ),
                    ],
                  ),

                  /*



                  CustomTextField(
                    controller: airtimeController.mobileNumberCtrl,
                    hintText: 'Mobile number with country code',
                    labelText: 'Mobile Number *',
                    textInputType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChange: (value) async {
                      //airtimeController.fieldErrors.remove('mobile_no');

                      await airtimeController.getValidationMobile().then((v) {
                        setState(() {});
                      });
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SvgPicture.asset(AssetUtilities.phone),
                    ),
                    errorWidget:
                        airtimeController.fieldErrors['mobile_no'] != null
                            ? Text(
                                airtimeController.fieldErrors['mobile_no']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                            : Container(),
                  ),*/

                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      CustomTextField(
                        controller: airtimeController.accountDescriptionCtrl,
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
                airtimeController.countryError.value = '';
                airtimeController.mobileError.value = '';
                airtimeController.operatorError.value = '';
                airtimeController.productError.value = '';

                bool hasError = false;
                if (airtimeController.selectedCountry.value == null) {
                  airtimeController.countryError.value = 'Country is required.';
                  hasError = true;
                }
                if (airtimeController.mobileNumberCtrl.value.text
                    .trim()
                    .isEmpty) {
                  airtimeController.mobileError.value =
                      'Mobile Number is required.';
                  airtimeController.fieldErrors['mobile_no'] =
                      'Mobile Number is required.';
                  hasError = true;
                }
                if (airtimeController.selectedOprator.value == null) {
                  airtimeController.operatorError.value =
                      'Operator is required.';
                  hasError = true;
                }

                if (airtimeController.selectedProduct.value == null) {
                  airtimeController.operatorError.value =
                      'Product is required.';
                  hasError = true;
                }

                setState(() {});
                if (hasError) return;
                if (airtimeController.isbtnClick.value) {
                  return;
                }
                airtimeController.isbtnClick.value = true;
                airtimeController.update();
                await airtimeController.getStoreTransaction();
                // Get.toNamed(RouteUtilities.selectOperatorScreen);
              },
              backColor: VariableUtilities.theme.secondaryColor,
              title: "Pay",
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    airtimeController.clearAllFields(); // <- You create this function
    super.dispose();
  }

  Widget _buildAmountInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
