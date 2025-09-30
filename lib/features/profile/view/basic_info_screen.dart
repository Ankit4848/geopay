import 'dart:io';

import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/profile/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../authentication/pages/register/controller/register_controller.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  RegisterController editProfileController =
      Get.find<RegisterController>();
  CommonController commonController = Get.find();
  final _formKey = GlobalKey<FormState>(); // ✅ Form Key

  @override
  void initState() {

    super.initState();

    editProfileController.selectedIdType.value=commonController.userModel.value?.idType ?? '';
    editProfileController.idNumberCtrl.text=commonController.userModel.value?.idNumber ?? '';
    editProfileController.idIssueDateCtrl.text=commonController.userModel.value?.issueIdDate ?? '';
    editProfileController.idExpiryDateCtrl.text=commonController.userModel.value?.expiryIdDate ?? '';
    editProfileController.dateOfBirthCtrl.text=commonController.userModel.value?.dateOfBirth ?? '';
    editProfileController.fullAdressCtrl.text=commonController.userModel.value?.address ?? '';
    editProfileController.cityCtrl.text=commonController.userModel.value?.city ?? '';
    editProfileController.stateCtrl.text=commonController.userModel.value?.state ?? '';
    editProfileController.zipCtrl.text=commonController.userModel.value?.zipCode ?? '';
    editProfileController.selectedGender.value=commonController.userModel.value?.gender==null?"":commonController.userModel.value?.gender!.toLowerCase() ?? '';
    editProfileController.selectedBusinessOccupation.value=commonController.userModel.value?.businessActivityOccupation ?? '';
    editProfileController.selectedSourceOfFund.value=commonController.userModel.value?.sourceOfFund ?? '';
    editProfileController.firstNameCtrl.text=commonController.userModel.value?.firstName ?? '';
    editProfileController.lastNameCtrl.text=commonController.userModel.value?.lastName ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: GetBuilder<CommonController>(builder: (commonController) {
        return GetBuilder<RegisterController>(builder: (registerController) {
          return Column(
            children: [

              CustomAppBar(title: 'Basic Info'),

              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // ID Type Dropdown
                        Obx(() {
                          return FadeSlideTransition(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select ID Type',
                                  overflow: TextOverflow.ellipsis,
                                  style: FontUtilities.style(
                                    fontSize: 14,
                                    fontWeight: FWT.semiBold,
                                    fontFamily: FontFamily.poppins,
                                    fontColor: VariableUtilities.theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: DropdownButtonFormField<String>(
                                    menuMaxHeight: 250,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                      suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 16,
                                        minWidth: 16,
                                      ),
                                      filled: true,
                                      fillColor:
                                      VariableUtilities.theme.textFieldFilledColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                      hintText: "Select ID Type",
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                        color: VariableUtilities.theme.redColor,
                                      ),
                                      hintStyle: FontUtilities.style(
                                        fontSize: 12,
                                        fontWeight: FWT.regular,
                                        fontColor: VariableUtilities.theme.thirdColor,
                                      ),
                                    ),
                                    style: FontUtilities.style(
                                      fontSize: 13,
                                      fontWeight: FWT.regular,
                                      fontColor: VariableUtilities.theme.thirdColor,
                                    ),
                                    dropdownColor:
                                    VariableUtilities.theme.textFieldFilledColor,
                                    isExpanded: true,
                                    value: registerController
                                        .selectedIdType.value.isNotEmpty
                                        ? registerController.selectedIdType.value
                                        : null,
                                    items: commonController.common.value?.idType
                                        ?.map(
                                          (idType) => DropdownMenuItem<String>(
                                        value: idType.value,
                                        child: Text(idType.label ?? ''),
                                      ),
                                    )
                                        .toList() ??
                                        [],
                                    onChanged: (val) {
                                      registerController.selectedIdType.value =
                                          val ?? '';
                                      registerController.update();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select ID type';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              labelText: 'ID Number *',

                              controller: registerController.idNumberCtrl,
                              errorWidget:
                              registerController.fieldErrors['id_number'] != null
                                  ? Text(
                                registerController.fieldErrors['id_number']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "ID Number can't be empty";
                                }
                                return null;
                              },
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              controller: registerController.idIssueDateCtrl,
                              errorWidget: registerController
                                  .fieldErrors['issue_id_date'] !=
                                  null
                                  ? Text(
                                registerController.fieldErrors['issue_id_date']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  registerController.idIssueDateCtrl.text =
                                      DateFormat('yyyy-MM-dd').format(picked);
                                }
                              },
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "ID Issue Date can't be empty";
                                }
                                return null;
                              },
                              hintText: "Select Date",
                              labelText: "ID Issue Date",
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              controller: registerController.idExpiryDateCtrl,
                              errorWidget: registerController
                                  .fieldErrors['expiry_id_date'] !=
                                  null
                                  ? Text(
                                registerController.fieldErrors['expiry_id_date']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  registerController.idExpiryDateCtrl.text =
                                      DateFormat('yyyy-MM-dd').format(picked);
                                }
                              },
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "ID Expiry Date can't be empty";
                                }
                                return null;
                              },
                              hintText: "Select Date",
                              labelText: "ID Expiry Date",
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              labelText: 'Full Residential Address',
                              errorWidget:
                              registerController.fieldErrors['address'] != null
                                  ? Text(
                                registerController.fieldErrors['address']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              controller: registerController.fullAdressCtrl,
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "Full Residential Address can't be empty";
                                }
                                return null;
                              },
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              labelText: 'City',
                              errorWidget:
                              registerController.fieldErrors['city'] != null
                                  ? Text(
                                registerController.fieldErrors['city']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              controller: registerController.cityCtrl,
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "City can't be empty";
                                }
                                return null;
                              },
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              labelText: 'State',
                              errorWidget:
                              registerController.fieldErrors['state'] != null
                                  ? Text(
                                registerController.fieldErrors['state']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              controller: registerController.stateCtrl,
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "State can't be empty";
                                }
                                return null;
                              },
                            ),
                          );
                        }),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              labelText: 'Zip Code/Postal Code',
                              textInputType: TextInputType.number,
                              errorWidget:
                              registerController.fieldErrors['zip_code'] != null
                                  ? Text(
                                registerController.fieldErrors['zip_code']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              controller: registerController.zipCtrl,
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "Zip Code/Postal Code can't be empty";
                                }
                                return null;
                              },
                            ),
                          );
                        }),

                        // Gender Dropdown
                        Obx(() {
                          return FadeSlideTransition(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Gender",
                                  overflow: TextOverflow.ellipsis,
                                  style: FontUtilities.style(
                                    fontSize: 14,
                                    fontWeight: FWT.semiBold,
                                    fontFamily: FontFamily.poppins,
                                    fontColor: VariableUtilities.theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: DropdownButtonFormField<String>(
                                    menuMaxHeight: 250,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                      suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 16,
                                        minWidth: 16,
                                      ),
                                      filled: true,
                                      fillColor:
                                      VariableUtilities.theme.textFieldFilledColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                      hintText: "Select Gender",
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                        color: VariableUtilities.theme.redColor,
                                      ),
                                      hintStyle: FontUtilities.style(
                                        fontSize: 12,
                                        fontWeight: FWT.regular,
                                        fontColor: VariableUtilities.theme.thirdColor,
                                      ),
                                    ),
                                    style: FontUtilities.style(
                                      fontSize: 13,
                                      fontWeight: FWT.regular,
                                      fontColor: VariableUtilities.theme.thirdColor,
                                    ),
                                    dropdownColor:
                                    VariableUtilities.theme.textFieldFilledColor,
                                    isExpanded: true,
                                    value: registerController
                                        .selectedGender.value.isNotEmpty
                                        ? registerController.selectedGender.value
                                        : null,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'male',
                                        child: Text('Male'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'female',
                                        child: Text('Female'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'other',
                                        child: Text('Other'),
                                      ),
                                    ],





                                    onChanged: (val) {
                                      registerController.selectedGender.value =
                                          val ?? '';
                                      registerController.update();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select gender';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 15),

                        Obx(() {
                          return FadeSlideTransition(
                            child: CustomTextField(
                              controller: registerController.dateOfBirthCtrl,
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                  DateTime.now().subtract(Duration(days: 365 * 18)),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  registerController.dateOfBirthCtrl.text =
                                      DateFormat('yyyy-MM-dd').format(picked);
                                }
                              },
                              validator: (value) {
                                if (!Validator.isNotNullOrEmpty(value)) {
                                  return "Date of Birth can't be empty";
                                }
                                return null;
                              },
                              errorWidget: registerController
                                  .fieldErrors['date_of_birth'] !=
                                  null
                                  ? Text(
                                registerController.fieldErrors['date_of_birth']!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )
                                  : null,
                              hintText: "Select Date",
                              labelText: "Date of Birth",
                            ),
                          );
                        }),

                        // Business Activity Dropdown
                        Obx(() {
                          return FadeSlideTransition(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Business Activity or Occupation",
                                  overflow: TextOverflow.ellipsis,
                                  style: FontUtilities.style(
                                    fontSize: 14,
                                    fontWeight: FWT.semiBold,
                                    fontFamily: FontFamily.poppins,
                                    fontColor: VariableUtilities.theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: DropdownButtonFormField<String>(
                                    menuMaxHeight: 250,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                      suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 16,
                                        minWidth: 16,
                                      ),
                                      filled: true,
                                      fillColor:
                                      VariableUtilities.theme.textFieldFilledColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                      hintText: "Select Business Activity",
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                        color: VariableUtilities.theme.redColor,
                                      ),
                                      hintStyle: FontUtilities.style(
                                        fontSize: 12,
                                        fontWeight: FWT.regular,
                                        fontColor: VariableUtilities.theme.thirdColor,
                                      ),
                                    ),
                                    style: FontUtilities.style(
                                      fontSize: 13,
                                      fontWeight: FWT.regular,
                                      fontColor: VariableUtilities.theme.thirdColor,
                                    ),
                                    dropdownColor:
                                    VariableUtilities.theme.textFieldFilledColor,
                                    isExpanded: true,
                                    value: registerController
                                        .selectedBusinessOccupation.value.isNotEmpty
                                        ? registerController
                                        .selectedBusinessOccupation.value
                                        : null,
                                    items: commonController
                                        .common.value?.businessOccupation
                                        ?.map(
                                          (occupation) => DropdownMenuItem<String>(
                                        value: occupation.value,
                                        child: Text(occupation.label ?? ''),
                                      ),
                                    )
                                        .toList() ??
                                        [],
                                    onChanged: (val) {
                                      registerController
                                          .selectedBusinessOccupation.value = val ?? '';
                                      registerController.update();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select business activity';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 15),

                        // Source of Fund Dropdown
                        Obx(() {
                          return FadeSlideTransition(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Source of Fund",
                                  overflow: TextOverflow.ellipsis,
                                  style: FontUtilities.style(
                                    fontSize: 14,
                                    fontWeight: FWT.semiBold,
                                    fontFamily: FontFamily.poppins,
                                    fontColor: VariableUtilities.theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: DropdownButtonFormField<String>(
                                    menuMaxHeight: 250,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                      suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 16,
                                        minWidth: 16,
                                      ),
                                      filled: true,
                                      fillColor:
                                      VariableUtilities.theme.textFieldFilledColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                      hintText: "Select Source of Fund",
                                      errorStyle: TextStyle(
                                        fontSize: 10,
                                        color: VariableUtilities.theme.redColor,
                                      ),
                                      hintStyle: FontUtilities.style(
                                        fontSize: 12,
                                        fontWeight: FWT.regular,
                                        fontColor: VariableUtilities.theme.thirdColor,
                                      ),
                                    ),
                                    style: FontUtilities.style(
                                      fontSize: 13,
                                      fontWeight: FWT.regular,
                                      fontColor: VariableUtilities.theme.thirdColor,
                                    ),
                                    dropdownColor:
                                    VariableUtilities.theme.textFieldFilledColor,
                                    isExpanded: true,
                                    value: registerController
                                        .selectedSourceOfFund.value.isNotEmpty
                                        ? registerController.selectedSourceOfFund.value
                                        : null,
                                    items: commonController.common.value?.sourceOfFunds
                                        ?.map(
                                          (source) => DropdownMenuItem<String>(
                                        value: source.value,
                                        child: Text(source.label ?? ''),
                                      ),
                                    )
                                        .toList() ??
                                        [],
                                    onChanged: (val) {
                                      registerController.selectedSourceOfFund.value =
                                          val ?? '';
                                      registerController.update();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select source of fund';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
                  onPressed: () {




                    if (_formKey.currentState!.validate()) {
                      editProfileController.editBasicInfo(context);
                    }
                  },
                  backColor: VariableUtilities.theme.secondaryColor,
                  title: "SAVE",
                ),
              ),
            ],
          );
        });
      }),
    );
  }

}
