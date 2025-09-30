import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/home/model/drop_down_model.dart';
import 'package:geopay/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';

class CompanyDetailForm extends StatefulWidget {
  const CompanyDetailForm({super.key});

  @override
  State<CompanyDetailForm> createState() => _CompanyDetailFormState();
}

class _CompanyDetailFormState extends State<CompanyDetailForm> {





  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.find();
    KycController kycController = Get.find();
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [

        FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Business Type *',
            hintText: registerController.selectedBusiness.value?.businessType ?? 'Select Business Type ',
            onTap: () {
              Get.dialog(DropdownBottomsheet(
                label: 'Business Type *',
                dropDownItemList: registerController.businessTypeList
                    .map((business) => DropDownModel(title: business.businessType !))
                    .toList(),
                onTap: (index) {
                 registerController.changeSelectedCountry(registerController.businessTypeList[index]);
                 registerController.numberOfDirectorCntrl.text="1";
                 registerController.updateDirectorCount("1");
                 setState(() {

                 });
                },
              ));
            },
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.arrow_drop_down_sharp,color: VariableUtilities.theme.primaryColor,size: 20,),
            ),

          ),
        ),
        Obx(() {
          return  FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Number of Directors *',

            onTap: registerController.selectedBusiness.value!=null&&registerController.selectedBusiness.value!.isDirector==0?(){}:null,
            controller: registerController.numberOfDirectorCntrl,
            errorWidget: kycController.fieldErrors['no_of_director'] != null?Text(
              kycController.fieldErrors['no_of_director']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Number of Directors Can't be empty";
              }
              return null;
            },
            onChange: (value) {

              registerController.updateDirectorCount(value!);
            },
          ),
        );}),
        Obx(() {
          return FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Company Registration Number *',
            controller: registerController.comanyNameCtrl,
            errorWidget: kycController.fieldErrors['business_licence'] != null?Text(
              kycController.fieldErrors['business_licence']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Company Registration Number Can't be empty";
              }
              return null;
            },
          ),
        );}),

    Obx(() {
    return FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Postal Code/Zip Code *',
            controller: registerController.businessLicenceCtrl,
            errorWidget: kycController.fieldErrors['postcode'] != null?Text(
              kycController.fieldErrors['postcode']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Postal Code/Zip Code Can't be empty";
              }
              return null;
            },
          ),
        );}),

    Obx(() {
    return  FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Legal registered Company Address *',
            controller: registerController.tinCtrl,
            errorWidget: kycController.fieldErrors['company_address'] != null?Text(
              kycController.fieldErrors['company_address']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Legal registered Corporate/Company Address Can't be empty";
              }
              return null;
            },
          )
        );
    }),

        Obx(() {
          return Column(
            children: List.generate(registerController.directorCount.value, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: CustomTextField(
                  labelText: 'Director ${index + 1} *',
                  controller: registerController.directorNameControllers[index],

                  errorWidget: kycController.fieldErrors['director_name.${index}'] != null?Text(
                    kycController.fieldErrors['director_name.${index}']!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ):Container(),

                  validator: (value) {
                    if (!Validator.isNotNullOrEmpty(value)) {
                      return "Director ${index + 1} name can't be empty";
                    }
                    return null;
                  },
                ),
              );
            }),
          );
        }),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
