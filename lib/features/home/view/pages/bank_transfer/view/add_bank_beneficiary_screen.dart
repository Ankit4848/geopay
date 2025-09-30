import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/model/drop_down_model.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/controller/add_bank_beneficiary_controller.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBeneModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBFieldModel.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/model/MTMBeneficiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddBankBeneficiaryScreen extends StatefulWidget {
  bool isEdit;
  TTBBeneModel? mtmBeneficiaryModel;

  AddBankBeneficiaryScreen(
      {super.key, required this.isEdit, this.mtmBeneficiaryModel});

  @override
  State<AddBankBeneficiaryScreen> createState() =>
      _AddBankBeneficiaryScreenState();
}

class _AddBankBeneficiaryScreenState extends State<AddBankBeneficiaryScreen> {
  AddBankBeneficiaryController addBankBeneficiaryController = Get.put(AddBankBeneficiaryController());

  @override
  void initState() {
    super.initState();

    addBankBeneficiaryController.getCountryList().then((v) {
      if (widget.isEdit) {
        addBankBeneficiaryController
            .updateControllersFromFields(widget.mtmBeneficiaryModel!)
            .then(
          (value) {
            setState(() {});
          },
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addBankBeneficiaryController.clearAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: widget.isEdit
                ? 'Edit Recipient'
                : 'Add New Recipient',
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
                    hintText: addBankBeneficiaryController.selectedCountry.value?.label ?? 'Select Recipient Country',
                    labelText: "Recipient Country *",
                    onTap: () {
                      Get.dialog(DropdownBottomsheet(
                        label: 'Select Recipient Country',
                        dropDownItemList: addBankBeneficiaryController.countryCollectionList
                            .map((country) => DropDownModel(
                                title: country.label!,
                                icon: country.countryFlag!))
                            .toList(),
                        onTap: (index) async {
                          await addBankBeneficiaryController
                              .changeSelectedCountry(
                                  addBankBeneficiaryController
                                      .countryCollectionList[index]);
                          print(addBankBeneficiaryController.countryCollectionList[index].value);
                          print(addBankBeneficiaryController.countryCollectionList[index].iso);
                          print(addBankBeneficiaryController.countryCollectionList[index].label);
                          print(addBankBeneficiaryController.countryCollectionList[index].id);
                          print(addBankBeneficiaryController.countryCollectionList[index].data);
                          print(addBankBeneficiaryController.countryCollectionList[index].countryFlag);
                          print(addBankBeneficiaryController.countryCollectionList[index].markdownType);
                          print(addBankBeneficiaryController
                              .countryCollectionList[index]?.isdcode);
                          print(addBankBeneficiaryController
                              .countryCollectionList[index]?.isdcode);
                          print(addBankBeneficiaryController
                              .countryCollectionList[index]?.isdcode);
                          print(addBankBeneficiaryController
                              .countryCollectionList[index]?.isdcode);
                          addBankBeneficiaryController.mobileBeneficiaryList.clear();

                          setState(() {});
                        },
                      ));
                    },
                    hintStyle: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.blackColor,
                    ),
                    errorWidget: addBankBeneficiaryController
                                .fieldErrors['country_code'] !=
                            null
                        ? Text(
                            addBankBeneficiaryController
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
                  if (addBankBeneficiaryController.selectedCountry.value !=
                          null &&
                      addBankBeneficiaryController.bankList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hintText:
                              addBankBeneficiaryController.selectedBank.value ==
                                      null
                                  ? 'Select Bank'
                                  : addBankBeneficiaryController
                                      .selectedBank.value!.locationName,
                          labelText: "Bank Name *",
                          hintStyle: FontUtilities.style(
                            fontSize: 13,
                            fontWeight: FWT.regular,
                            fontColor: VariableUtilities.theme.blackColor,
                          ),
                          onTap: () {
                            Get.dialog(DropdownBottomsheet(
                              label: 'Select Bank',
                              dropDownItemList: addBankBeneficiaryController
                                  .bankList.value
                                  .map((channel) => DropDownModel(
                                      title: addBankBeneficiaryController.selectedCountry.value!.serviceName=="onafric"?" ${channel.locationName!}":channel.locationName!, icon: ''))
                                  .toList(),
                              onTap: (index) async {
                                await addBankBeneficiaryController
                                    .changeSelectedChannel(
                                        addBankBeneficiaryController
                                            .bankList[index]);
                                setState(() {});
                              },
                            ));
                          },





          errorWidget: addBankBeneficiaryController
                                      .fieldErrors['channel'] !=
                                  null
                              ? Text(
                                  addBankBeneficiaryController
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
                  const SizedBox(height: 12),
                  const SizedBox(height: 5),
                  Obx(() {
                    final controller = Get.find<AddBankBeneficiaryController>();

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...controller.mobileBeneficiaryList.map((field) {
                            final isDate = field.inputType == 'date';
                            final isRequired = field.required!;
                            var label = field.fieldLabel!;
                            var hint=field.fieldLabel! +
                                (isRequired ? ' *' : '');
                            print(field.fieldName);
                            if(field.fieldName=="senderbeneficiaryrelationship") {
                              label = "Relation with Recipient"+
                                  (isRequired ? ' *' : '');
                              hint = "Relation with Recipient"+
                                  (isRequired ? ' *' : '');
                            }else if(field.fieldName.contains("address")) {
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
                              child: field.inputType == "select"
                                  ? Obx(() {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            label,
                                            overflow: TextOverflow.ellipsis,
                                            style: FontUtilities.style(
                                              fontSize: 14,
                                              fontWeight: FWT.semiBold,
                                              fontFamily: FontFamily.poppins,
                                              fontColor: VariableUtilities
                                                  .theme.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: controller.fieldErrors[
                                                            field.fieldName] !=
                                                        null
                                                    ? 2
                                                    : 12),
                                            child:
                                                DropdownButtonFormField<String>(
                                              menuMaxHeight: 250,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 14, 12, 12),
                                                suffixIconConstraints:
                                                    const BoxConstraints(
                                                  maxHeight: 16,
                                                  minWidth: 16,
                                                ),
                                                filled: true,
                                                fillColor: VariableUtilities.theme.textFieldFilledColor,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                isDense: true,
                                                hintText: hint,
                                                error: controller.fieldErrors[
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
                                                errorStyle: TextStyle(
                                                  fontSize: 10,
                                                  color: VariableUtilities
                                                      .theme.redColor,
                                                ),
                                                hintStyle: FontUtilities.style(
                                                  fontSize: 12,
                                                  fontWeight: FWT.regular,
                                                  fontColor: VariableUtilities
                                                      .theme.thirdColor,
                                                ),
                                              ),
                                              style: FontUtilities.style(
                                                fontSize: 13,
                                                fontWeight: FWT.regular,
                                                fontColor: VariableUtilities
                                                    .theme.thirdColor,
                                              ),
                                              dropdownColor: VariableUtilities
                                                  .theme.textFieldFilledColor,
                                              isExpanded: true,
                                              value: controller
                                                          .dropdownValues[
                                                              field.fieldName]
                                                          ?.value
                                                          .isNotEmpty ==
                                                      true
                                                  ? controller
                                                      .dropdownValues[
                                                          field.fieldName]
                                                      ?.value
                                                  : null,
                                              items: field.options.entries
                                                  .map((e) => DropdownMenuItem(
                                                      value: e.key,
                                                      child: Text(e.value)))
                                                  .toList(),
                                              onChanged: (val) => controller
                                                  .dropdownValues[
                                                      field.fieldName]
                                                  ?.value = val ?? '',
                                              validator: (value) {
                                                if (field.required &&
                                                    (value == null ||
                                                        value.isEmpty)) {
                                                  return 'Required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                  : isDate
                                      ? CustomTextField(
                                          /*
                                    hintText:label,
                                    isRequired: field.required!,*/
                                          controller:
                                              controller.fieldControllers[
                                                  field.fieldName]!,
                                          onTap: () async {
                                            print("afadasdsada");
                                            final picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2200), // restricts future dates
                                            );
                                            if (picked != null) {
                                              controller
                                                      .fieldControllers[
                                                          field.fieldName]
                                                      ?.text =
                                                  DateFormat('yyyy-MM-dd')
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
                                          // labelText: label,
                                        )
                                      : field.fieldName!.toString().toLowerCase().contains("receivercontactnumber")
                              ?                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Receiver Mobile *",
                                    style: FontUtilities.style(
                                      fontSize:  14,
                                      fontWeight: FWT.semiBold,
                                      fontFamily: FontFamily.poppins,
                                      fontColor: VariableUtilities.theme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 5,),



                                  Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: CustomTextField(
                                                          onTap: () {},
                                                          hintText: addBankBeneficiaryController
                                                                      .selectedCountry
                                                                      .value !=
                                                                  null
                                                              ? "+${addBankBeneficiaryController.selectedCountry.value!.isdcode}"
                                                              : '+255',
                                                          textInputType:
                                                              TextInputType.phone,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          onChange: (value) =>
                                                              addBankBeneficiaryController.fieldErrors
                                                                  .remove(
                                                                      'receivercontactnumber'),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 6,
                                                      child: CustomTextField(
                                                        controller: addBankBeneficiaryController
                                                                .fieldControllers[
                                                            field.fieldName],
                                                        hintText: 'Mobile No.',
                                                        textInputType:
                                                            TextInputType.phone,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        onChange: (value) =>
                                                            addBankBeneficiaryController.fieldErrors
                                                                .remove(field
                                                                    .fieldName),
                                                        prefixIcon: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 12.0),
                                                          child: SvgPicture.asset(
                                                              AssetUtilities.phone),
                                                        ),
                                                        errorWidget: addBankBeneficiaryController
                                                                        .fieldErrors[
                                                                    field
                                                                        .fieldName] !=
                                                                null
                                                            ? Text(
                                                          addBankBeneficiaryController
                                                                        .fieldErrors[
                                                                    field
                                                                        .fieldName]!,
                                                                style:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12),
                                                              )
                                                            : Container(),
                                                       /* suffixIcon: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 12.0),
                                                          child: SvgPicture.asset(
                                                              AssetUtilities
                                                                  .phoneBook),
                                                        ),*/
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                ],
                              )
                                          : CustomTextField(
                                              controller:
                                                  controller.fieldControllers[
                                                      field.fieldName],
                                              textInputType:
                                                  field.inputType == 'text'
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
                                              errorWidget: controller
                                                              .fieldErrors[
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
                          }).toList(),
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

                final params = addBankBeneficiaryController.buildFieldParams();
                if (addBankBeneficiaryController.fieldErrors.values
                    .any((error) => error != "")) {
                  print("dfsdfsdfsdfsdf");
                  print(addBankBeneficiaryController.fieldErrors);

                  Get.snackbar(
                      "Validation Error", "Please fill all required fields.");
                  return;
                }

                if (addBankBeneficiaryController.isbtnClick.value) return;
                addBankBeneficiaryController.isbtnClick.value = true;
                addBankBeneficiaryController.update();
                if (widget.isEdit) {
                  await addBankBeneficiaryController.getTMtoMBeneUpdateStore(
                      widget.mtmBeneficiaryModel!.id!.toString());
                } else {
                  await addBankBeneficiaryController.getStoreTransaction();
                }
                EasyLoading.dismiss();
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
