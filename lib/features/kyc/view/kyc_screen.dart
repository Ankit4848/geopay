import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/authentication/pages/register/widgets/upload_detail_form.dart';
import 'package:geopay/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../authentication/pages/register/widgets/bank_detail_form.dart';
import '../../authentication/pages/register/widgets/company_detail_form.dart';
import '../../authentication/pages/register/widgets/company_stepper_widget.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  RegisterController registerController=Get.find();
  KycController kycController = Get.find();
  @override
  void initState() {
    super.initState();
    _loadCompanyKycDetails();
  }

  Future<void> _loadCompanyKycDetails() async {
    await registerController.getCompanyKycDetails(Get.context!);
    print("adasdasdasdasdsadasd");
    print(kycController.currentStepIndex.value);

    final step = registerController.companyDisplayDataModel.value?.companyDetail?.stepNumber;
    if (step != null) {
      kycController.currentStepIndex.value = step;
      kycController.update();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {


    return  BgContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // Important: This makes it scrollable when keyboard opens
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [





                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          color: VariableUtilities.theme.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Bounce(
                                  onTap: (){
                                    registerController.logout();
                                  },
                                  child: Image.asset("assets/images/extra_image/logout.png",height: 30,
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Complete Your KYC",
                              style: FontUtilities.style(
                                fontSize: 14,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "To ensure a secure and compliant experience, please upload your KYC documents. Quick, secure, and hassle-free verification!",
                              style: FontUtilities.style(
                                fontSize: 12,
                                fontColor: VariableUtilities.theme.primaryColor,
                                fontWeight: FWT.regular,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(
                                  () => FadeSlideTransition(
                                child: CompanyStepperWidget(
                                  currentIndex: kycController.currentStepIndex.value,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Obx(
                                  () => FadeSlideTransition(
                                child: Center(
                                  child: Text(
                                    kycController.currentStepIndex.value == 0
                                        ? "Company Detail"
                                        : kycController.currentStepIndex.value == 1
                                        ? "Bank Detail"
                                        : "Upload Documents",
                                    style: FontUtilities.style(
                                      fontSize: 14,
                                      fontColor: VariableUtilities.theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: Get.height*0.5,
                              child: Obx(() {
                                if (kycController.currentStepIndex.value == 0) {
                                  return const CompanyDetailForm();
                                } else if (kycController.currentStepIndex.value == 1) {
                                  return const BankDetailForm();
                                } else if (kycController.currentStepIndex.value == 2) {
                                  return const UploadDetailsScreen();
                                }
                                return const Offstage();
                              }),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: FadeSlideTransition(
                                child: Obx(
                                      () => CustomFlatButton(
                                    width: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      kycController.changeCurrentStep();
                                    },
                                    backColor: VariableUtilities.theme.primaryColor,
                                    title: kycController.currentStepIndex.value == 2
                                        ? 'REGISTER'
                                        : 'NEXT',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    ;
  }
}
