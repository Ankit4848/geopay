import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/add_money/controller/add_money_controller.dart';
import 'package:fintech/features/home/view/pages/add_money/widgets/balance_card.dart';
import 'package:fintech/features/home/view/pages/add_money/widgets/select_money_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../model/drop_down_model.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  late AddMoneyController controller;
  FocusNode amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddMoneyController());
    controller.getCountryList();
    amountFocusNode.addListener(() {
      if (!amountFocusNode.hasFocus) {}
    });
  }

  @override
  void dispose() {
    controller.clearAllFields(); // <- You create this function
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'Add Funds'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: BalanceCard(),
                  ),
                  const SizedBox(height: 4),
                  Image.asset(AssetUtilities.redLine),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                    child: GetBuilder<AddMoneyController>(builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hintText: controller.selectedCountry.value?.name ?? 'Select Country',
                            labelText: 'Payer Country *',
                            onTap: () {
                              Get.dialog(DropdownBottomsheet(
                                label: 'Select Payer Country',
                                dropDownItemList: controller.countryCollectionList
                                    .map((country) => DropDownModel(title: country.name!, icon:country.countryFlag!))
                                    .toList(),
                                onTap: (index) {
                                  controller.changeSelectedCountry(controller.countryCollectionList[index]);
                                },
                              ));
                            },
                            errorWidget: controller.fieldErrors['country_code'] != null?Text(
                              controller.fieldErrors['country_code']!,
                              style: const TextStyle(color: Colors.red, fontSize: 12),
                            ):Container(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.dropDown),
                            ),
                          ),


                          if (controller.selectedCountry.value != null &&
                              controller.selectedCountry.value!.availableChannels!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                CustomTextField(
                                  hintText: controller.selectedChannel.value ?? 'Select Channel',
                                  labelText: 'Channel *',
                                  onTap: () {
                                    Get.dialog(DropdownBottomsheet(
                                      label: 'Select Channel',
                                      dropDownItemList: controller.selectedCountry.value!.availableChannels!
                                          .map((channel) => DropDownModel(title: channel, icon: ''))
                                          .toList(),
                                      onTap: (index) {
                                        controller.changeSelectedChannel(
                                            controller.selectedCountry.value!.availableChannels![index]);
                                      },
                                    ));
                                  },
                                  errorWidget: controller.fieldErrors['channel'] != null?Text(
                                    controller.fieldErrors['channel']!,
                                    style: const TextStyle(color: Colors.red, fontSize: 12),
                                  ):Container(),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: SvgPicture.asset(AssetUtilities.dropDown),
                                  ),
                                ),

                              ],
                            ),
                          const SizedBox(height: 12),









                          Text(
                            "Mobile Number *",
                            style: FontUtilities.style(
                              fontSize:  14,
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
                                    onTap: (){},
                                    hintText:controller.selectedCountry.value != null
                                        ? "+${controller.selectedCountry.value!.isdcode}": '+255',
                                    textInputType: TextInputType.phone,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChange: (value) => controller.fieldErrors.remove('mobile_no'),



                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 6,
                                child: CustomTextField(
                                  controller: controller.mobileCtrl,
                                  hintText: 'Mobile No.',

                                  textInputType: TextInputType.phone,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChange: (value) => controller.fieldErrors.remove('mobile_no'),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: SvgPicture.asset(AssetUtilities.phone),
                                  ),
                                  errorWidget: controller.fieldErrors['mobile_no'] != null?Text(
                                    controller.fieldErrors['mobile_no']!,
                                    style: const TextStyle(color: Colors.red, fontSize: 12),
                                  ):Container(),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: SvgPicture.asset(AssetUtilities.phoneBook),
                                  ),
                                ),
                              ),
                            ],
                          ),



                          CustomTextField(
                            controller: controller.beneficiaryNameCtrl,
                            hintText: 'Payer Name',
                            labelText: 'Payer Name',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.beneficiaryName),
                            ),
                          ),

                          CustomTextField(

                            controller: controller.amountCtrl,
                            hintText: 'Enter Amount in USD (eg:100 or eg:0.00)',
                            labelText: 'Amount *',
                            textInputType: TextInputType.numberWithOptions(decimal: true),
                            focusNode: amountFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),

                            ],
                            onChange: (value) {
                              controller.fieldErrors.remove('txnAmount');
                              if(value!.isNotEmpty) {
                                controller.fetchAmountBreakdown();
                              }else
                                {
                                  controller.commissionModel.value=null;
                                  controller.update();
                                }
                            },
                            errorWidget: controller.fieldErrors['txnAmount'] != null?
                            Text(
                              controller.fieldErrors['txnAmount']!,
                              style: const TextStyle(color: Colors.red, fontSize: 12),
                            ):Container(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.doller),
                            ),
                          ),

                          const SizedBox(height: 12),




                          if (controller.commissionModel.value != null)
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
                                    'Processing Fee (${controller.commissionModel.value!.remitCurrency})',
                                    controller.commissionModel.value!.totalCharges!.toStringAsFixed(2),
                                  ),
                                  _buildAmountInfo(
                                    'Net Amount (${controller.commissionModel.value!.remitCurrency})',
                                    controller.commissionModel.value!.netAmount!.toStringAsFixed(2),
                                  ),
                                  _buildAmountInfo(
                                    'Receivable Amount (${controller.commissionModel.value!.payoutCurrency})',
                                    controller.commissionModel.value!.payoutCurrencyAmount!.toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ),
                          if (controller.commissionModel.value != null)
                            const SizedBox(height: 12),



                          Stack(
                            children: [
                              CustomTextField(
                                controller: controller.accountDescriptionCtrl,
                                hintText: 'Account Descriptions',
                                labelText: 'Notes',
                                maxLine: 5,
                                minLine: 5,
                                contentPadding: const EdgeInsets.fromLTRB(40, 14, 12, 12),
                              ),
                              Positioned(
                                top: 43,
                                left: 12,
                                child: SvgPicture.asset(AssetUtilities.edit),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: CustomFlatButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if(controller.isbtnClick.value)
                  return;
                controller.isbtnClick.value=true;
                controller.update();
               await  controller.getCommissionStore();
              },
              backColor: VariableUtilities.theme.secondaryColor,

              title: "Add Money",
            ),
          ),
        ],
      ),
    );

  }
}

/*class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMoneyController controller = Get.put(AddMoneyController());
    controller.getCountryList();

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'Add Money'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: BalanceCard(),
                  ),
                  Obx(() => SelectMoneyOptionWidget(
                    selectedIndex: controller.selectedMethodOptionIndex.value,
                    onTap: controller.changeSelectedMethod,
                  )),
                  const SizedBox(height: 4),
                  Image.asset(AssetUtilities.redLine),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                    child: GetBuilder<AddMoneyController>(builder: (controller) {
                      return Column(
                        children: [
                          CustomTextField(
                            hintText: controller.selectedCountry.value?.name ?? 'Select Country',
                            onTap: () {
                              Get.dialog(DropdownBottomsheet(
                                label: 'Select Country',
                                dropDownItemList: controller.countryCollectionList
                                    .map((country) =>
                                    DropDownModel(title: country.name!, icon: ''))
                                    .toList(),
                                onTap: (index) {
                                  controller.changeSelectedCountry(controller.countryCollectionList[index]);
                                //  Get.back();
                                },
                              ));
                            },
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.dropDown),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (controller.selectedCountry.value != null &&
                              controller.selectedCountry.value!.availableChannels!.isNotEmpty)
                            CustomTextField(
                              hintText: controller.selectedChannel.value ?? 'Select Channel',
                              onTap: () {
                                Get.dialog(DropdownBottomsheet(
                                  label: 'Select Channel',
                                  dropDownItemList: controller.selectedCountry.value!.availableChannels!
                                      .map((channel) => DropDownModel(title: channel, icon: ''))
                                      .toList(),
                                  onTap: (index) {
                                    controller.changeSelectedChannel(
                                        controller.selectedCountry.value!.availableChannels![index]);
                                    //Get.back();
                                  },
                                ));
                              },
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: SvgPicture.asset(AssetUtilities.dropDown),
                              ),
                            ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            controller: controller.mobileCtrl,
                            hintText: 'Mobile No.',
                            textInputType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.phone),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.phoneBook),
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            controller: controller.amountCtrl,
                            hintText: 'Enter Amount in USD (eg:100 or eg:0.00)',
                            textInputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.doller),
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            controller: controller.beneficiaryNameCtrl,
                            hintText: 'Beneficiary Name',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SvgPicture.asset(AssetUtilities.beneficiaryName),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Stack(
                            children: [
                              CustomTextField(
                                controller: controller.accountDescriptionCtrl,
                                hintText: 'Account Descriptions',
                                maxLine: 5,
                                minLine: 5,
                                contentPadding: const EdgeInsets.fromLTRB(40, 14, 12, 12),
                              ),
                              Positioned(
                                top: 16,
                                left: 12,
                                child: SvgPicture.asset(AssetUtilities.edit),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: CustomFlatButton(
              onPressed: () {},
              backColor: VariableUtilities.theme.secondaryColor,
              title: "Add Money",
            ),
          ),
        ],
      ),
    );
  }
}*/
