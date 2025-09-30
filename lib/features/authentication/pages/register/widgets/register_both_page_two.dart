import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterBothPageForm extends StatelessWidget {
  const RegisterBothPageForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (registerController) {
          return GetBuilder<CommonController>(builder: (commonController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Note: Please fill out all fields',
                  style: FontUtilities.style(
                    fontSize: 14,
                    fontWeight: FWT.regular,
                    fontFamily: FontFamily.poppins,
                    fontColor: VariableUtilities.theme.redColor,
                  ),
                ),
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Business Activity or Occupation",
                                overflow: TextOverflow.ellipsis,
                                style: FontUtilities.style(
                                  fontSize: 14,
                                  fontWeight: FWT.semiBold,
                                  fontFamily: FontFamily.poppins,
                                  fontColor: VariableUtilities.theme.primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (details) {
                                showInfoTooltip(
                                  context,
                                  "If you are self employed, student or employed",
                                  details.globalPosition, // icon nu tap position
                                );
                              },
                              child: const Icon(
                                Icons.info,
                                color: Color(0xff102031),
                              ),
                            ),
                          ],
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Source of Fund",
                                overflow: TextOverflow.ellipsis,
                                style: FontUtilities.style(
                                  fontSize: 14,
                                  fontWeight: FWT.semiBold,
                                  fontFamily: FontFamily.poppins,
                                  fontColor: VariableUtilities.theme.primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (details) {
                                showInfoTooltip(
                                  context,
                                  "How will you be funding your wallet example Remuneration, Savings, Inheritance",
                                  details.globalPosition, // icon nu tap position
                                );
                              },
                              child: const Icon(
                                Icons.info,
                                color: Color(0xff102031),
                              ),
                            ),
                          ],
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
            );
          });
        },
      ),
    );
  }

  void showInfoTooltip(BuildContext context, String message, Offset offset) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy - 40, // icon ni upar
        left: Get.width*0.25,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xff102031),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              message,
              style:  TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    // Auto remove after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      entry.remove();
    });
  }

  void showInfoTooltip1(BuildContext context, String message, Offset offset) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy - 40, // icon ni upar
        left: Get.width*0.25,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              message,
              style:  TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    // Auto remove after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      entry.remove();
    });
  }

}
