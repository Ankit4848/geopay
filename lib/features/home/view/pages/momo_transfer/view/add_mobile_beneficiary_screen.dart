import 'package:geopay/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/drop_down_model.dart';
import '../controller/add_mobile_beneficiary_controller.dart';
import '../model/MTMBeneficiaryModel.dart';

class AddMobileBeneficiaryScreen extends StatefulWidget {
  bool isEdit;
  MTMBeneficiaryModel? mtmBeneficiaryModel;

  AddMobileBeneficiaryScreen(
      {super.key, required this.isEdit, this.mtmBeneficiaryModel});

  @override
  State<AddMobileBeneficiaryScreen> createState() =>
      _AddMobileBeneficiaryScreenState();
}

class _AddMobileBeneficiaryScreenState
    extends State<AddMobileBeneficiaryScreen> {
  AddMobileBeneficiaryController addMobileBeneficiaryController =
  Get.put(AddMobileBeneficiaryController());

  @override
  void initState() {
    super.initState();
    addMobileBeneficiaryController.getTmtoMFieldsViewBaene().then((v) async {
      if (widget.isEdit) {
        setState(() {
          addMobileBeneficiaryController
              .updateControllersFromFields(widget.mtmBeneficiaryModel!);
        });
      }
    });
    addMobileBeneficiaryController.getCountryList().then((v) {
      if (widget.isEdit) {
        setState(() {
          addMobileBeneficiaryController
              .updateControllersFromFields(widget.mtmBeneficiaryModel!);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    addMobileBeneficiaryController.clearAllFields();
  }

  /// 🔹 Validation function
  bool _validateFields() {
    bool isValid = true;
    final controller = addMobileBeneficiaryController;

    controller.fieldErrors.clear();

    // Country required
    if (controller.selectedCountry.value == null) {
      controller.fieldErrors['country_code'] = "Please select a country";
      isValid = false;
    }

    // Channel required
    if (controller.selectedCountry.value != null &&
        (controller.selectedChannel.value == null)) {
      controller.fieldErrors['channel'] = "Please select a channel";
      isValid = false;
    }

    // Dynamic fields
    for (var field in controller.mobileBeneficiaryList) {
      final text = controller.fieldControllers[field.fieldName]?.text.trim() ?? "";

      if (field.required == true && text.isEmpty) {
        controller.fieldErrors[field.fieldName!] =
        "${field.fieldLabel} is required";
        isValid = false;
      }

      // 🔹 Mobile number special validation
      if (field.fieldName!.toLowerCase().contains("recipient_mobile")) {
        if (text.isEmpty) {
          controller.fieldErrors[field.fieldName!] = "Mobile number is required";
          isValid = false;
        } else if (text.length < 7) {
          controller.fieldErrors[field.fieldName!] = "Enter valid mobile number";
          isValid = false;
        }
      }
    }

    setState(() {}); // refresh UI with errors
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: widget.isEdit ? 'Edit Recipient' : 'Add New Recipient',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: addMobileBeneficiaryController
                        .selectedCountry.value?.name ??
                        'Select Recipient Country',
                    labelText: "Recipient Country *",
                    hintStyle: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                    onTap: () {
                      Get.dialog(DropdownBottomsheet(
                        label: 'Select Recipient Country',
                        dropDownItemList: addMobileBeneficiaryController
                            .countryCollectionList
                            .map((country) => DropDownModel(
                            title: country.name!,
                            icon: country.countryFlag))
                            .toList(),
                        onTap: (index) {
                          setState(() {
                            addMobileBeneficiaryController
                                .changeSelectedCountry(
                                addMobileBeneficiaryController
                                    .countryCollectionList[index]);
                          });
                        },
                      ));
                    },
                    errorWidget:
                    addMobileBeneficiaryController.fieldErrors['country_code'] !=
                        null
                        ? Text(
                      addMobileBeneficiaryController
                          .fieldErrors['country_code']!,
                      style: const TextStyle(
                          color: Colors.red, fontSize: 12),
                    )
                        : Container(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SvgPicture.asset(AssetUtilities.dropDown),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (addMobileBeneficiaryController.selectedCountry.value !=
                      null &&
                      addMobileBeneficiaryController
                          .selectedCountry.value!.channels!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hintText: addMobileBeneficiaryController
                              .selectedChannel.value ==
                              null
                              ? 'Select Channel'
                              : addMobileBeneficiaryController
                              .selectedChannel.value!.channel,
                          labelText: "Channel *",
                          hintStyle: FontUtilities.style(
                            fontSize: 13,
                            fontWeight: FWT.regular,
                            fontColor: VariableUtilities.theme.blackColor,
                          ),
                          onTap: () {
                            Get.dialog(DropdownBottomsheet(
                              label: 'Select Channel',
                              dropDownItemList: addMobileBeneficiaryController
                                  .selectedCountry.value!.channels!
                                  .map((channel) => DropDownModel(
                                  title: channel.channel!, icon: ''))
                                  .toList(),
                              onTap: (index) {
                                setState(() {
                                  addMobileBeneficiaryController
                                      .changeSelectedChannel(
                                      addMobileBeneficiaryController
                                          .selectedCountry
                                          .value!
                                          .channels![index]);
                                });
                              },
                            ));
                          },
                          errorWidget: addMobileBeneficiaryController
                              .fieldErrors['channel'] !=
                              null
                              ? Text(
                            addMobileBeneficiaryController
                                .fieldErrors['channel']!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          )
                              : Container(),
                          suffixIcon: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SvgPicture.asset(AssetUtilities.dropDown),
                          ),
                        ),
                      ],
                    ),
                  if (addMobileBeneficiaryController.selectedCountry.value !=
                      null &&
                      addMobileBeneficiaryController
                          .selectedCountry.value!.channels!.isNotEmpty)
                  const SizedBox(height: 12),

                  Obx(() {
                    final controller =
                    Get.find<AddMobileBeneficiaryController>();
                    if (controller.mobileBeneficiaryList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...controller.mobileBeneficiaryList.map((field) {
                            final isDate = field.inputType == 'date';
                            final isRequired = field.required!;
                            var label = field.fieldLabel! + (isRequired ? ' *' : '');
                            var hint = field.fieldLabel! + (isRequired ? ' *' : '');
                            if(field.fieldName=="senderbeneficiaryrelationship") {
                              label = "Relation with Recipient"+
                                  (isRequired ? ' *' : '');
                              hint = "Relation with Recipient"+
                                  (isRequired ? ' *' : '');
                            }else if(field.fieldName!.contains("address")) {
                              hint = "(Apt/Street/Area/Zip code)"+
                                  (isRequired ? ' *' : '');
                            }else
                            {
                              label = field.fieldLabel! +
                                  (isRequired ? ' *' : '');
                              hint = field.fieldLabel! +
                                  (isRequired ? ' *' : '');
                            }




                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: isDate
                                  ? CustomTextField(
                                controller: controller
                                    .fieldControllers[field.fieldName]!,
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    controller
                                        .fieldControllers[field.fieldName]
                                        ?.text = DateFormat('yyyy-MM-dd')
                                        .format(picked);
                                  }
                                },
                                hintText: hint,
                                labelText: label,
                                errorWidget: controller.fieldErrors[
                                field.fieldName] !=
                                    null
                                    ? Text(
                                  controller.fieldErrors[
                                  field.fieldName]!,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12),
                                )
                                    : null,
                              )
                                  : field.fieldName!
                                  .toLowerCase()
                                  .contains("recipient_mobile")
                                  ? Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Recipient Mobile *",
                                        style: FontUtilities.style(
                                          fontSize:  14,
                                          fontWeight: FWT.semiBold,
                                          fontFamily: FontFamily.poppins,
                                          fontColor: VariableUtilities.theme.primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(

                                          child: CustomTextField(

                                            onTap: () {},
                                            hintText: controller
                                                .selectedCountry
                                                .value !=
                                                null
                                                ? "+${controller.selectedCountry.value!.isdcode}"
                                                : '+255',
                                            hintStyle: FontUtilities.style(
                                              fontSize: 13,
                                              fontWeight: FWT.regular,
                                              fontColor: VariableUtilities.theme.blackColor,
                                            ),
                                            textInputType:
                                            TextInputType.phone,

                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 6,
                                        child: CustomTextField(
                                          controller: controller
                                              .fieldControllers[
                                          field.fieldName],
                                          hintText: 'Mobile No.',
                                          textInputType:
                                          TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 12.0),
                                            child: SvgPicture.asset(
                                                AssetUtilities.phone),
                                          ),
                                          errorWidget: controller
                                              .fieldErrors[field
                                              .fieldName] !=
                                              null
                                              ? Text(
                                            controller.fieldErrors[
                                            field.fieldName]!,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          )
                                              : Container(),
                                         /* suffixIcon: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 12.0),
                                            child: SvgPicture.asset(
                                                AssetUtilities.phoneBook),
                                          ),*/
                                        ),
                                      ),
                                                                      ],
                                                                    ),
                                    ],
                                  )
                                  : CustomTextField(
                                controller: controller
                                    .fieldControllers[
                                field.fieldName],
                                textInputType: field.inputType ==
                                    'text'
                                    ? TextInputType.text
                                    : TextInputType.number,
                                inputFormatters:
                                field.inputType == 'text'
                                    ? null
                                    : [
                                  FilteringTextInputFormatter
                                      .digitsOnly
                                ],
                                hintText: hint,
                                labelText: label,
                                errorWidget: controller.fieldErrors[
                                field.fieldName] !=
                                    null
                                    ? Text(
                                  controller.fieldErrors[
                                  field.fieldName]!,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12),
                                )
                                    : null,
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
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
                FocusScope.of(context).unfocus();

                if (!_validateFields()) {
                  Get.snackbar(
                      "Validation Error", "Please fill all required fields.");
                  return;
                }

                if (addMobileBeneficiaryController.isbtnClick.value) {
                  return;
                }

                addMobileBeneficiaryController.isbtnClick.value = true;
                addMobileBeneficiaryController.update();

                if (widget.isEdit) {
                  await addMobileBeneficiaryController
                      .getTMtoMBeneUpdateStore(
                      widget.mtmBeneficiaryModel!.id!.toString());
                } else {
                  await addMobileBeneficiaryController.getStoreTransaction();
                }
              },
              backColor: VariableUtilities.theme.secondaryColor,
              title: widget.isEdit ? "Update" : "Submit",
            ),
          ),
        ],
      ),
    );
  }
}
