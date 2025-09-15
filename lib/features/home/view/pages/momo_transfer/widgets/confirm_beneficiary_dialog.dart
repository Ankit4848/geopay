import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/view/add_mobile_beneficiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/momo_transfer_controller.dart';
import '../model/MTMBeneficiaryModel.dart';

class ConfirmBeneficiaryDialog extends StatelessWidget {
  MTMBeneficiaryModel mtmBeneficiaryModel;

  ConfirmBeneficiaryDialog({super.key, required this.mtmBeneficiaryModel});

  @override
  Widget build(BuildContext context) {
    MomoTransferController momoTransferController = Get.find();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(),
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Confirm Beneficiary Detail',
                style: FontUtilities.style(
                    fontSize: 13,
                    fontColor: VariableUtilities.theme.secondaryColor,
                    fontWeight: FWT.semiBold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Service Name',
              style: FontUtilities.style(
                fontSize: 9,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Transfer To Mobile Money',
              style: FontUtilities.style(
                fontSize: 13,
                fontWeight: FWT.medium,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 0.5,
              color: VariableUtilities.theme.primaryColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Country Name',
              style: FontUtilities.style(
                fontSize: 9,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                /* Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(AssetUtilities.ivory),
                ),*/
                //   const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "${mtmBeneficiaryModel.data!.recipientCountryName??""} (${mtmBeneficiaryModel.data!.recipientCountryCode??""})",
                    style: FontUtilities.style(
                      fontSize: 13,
                      fontWeight: FWT.medium,
                      fontColor: VariableUtilities.theme.primaryColor,
                    ),
                  ),
                ),
                // SvgPicture.asset(AssetUtilities.dropDown),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 0.5,
              color: VariableUtilities.theme.primaryColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operator Name',
                      style: FontUtilities.style(
                        fontSize: 9,
                        fontColor: const Color(0xFF808080),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      mtmBeneficiaryModel.data!.channelName??"",
                      style: FontUtilities.style(
                        fontSize: 13,
                        fontWeight: FWT.medium,
                        fontColor: VariableUtilities.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 0.5,
                      width: Get.width * 0.2,
                      color: VariableUtilities.theme.primaryColor,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile No.',
                      style: FontUtilities.style(
                        fontSize: 9,
                        fontColor: const Color(0xFF808080),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          mtmBeneficiaryModel.data!.recipientMobile??"",
                          style: FontUtilities.style(
                            fontSize: 13,
                            fontWeight: FWT.medium,
                            fontColor: VariableUtilities.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 0.5,
                      width: Get.width * 0.4,
                      color: VariableUtilities.theme.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name',
                      style: FontUtilities.style(
                        fontSize: 9,
                        fontColor: const Color(0xFF808080),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      mtmBeneficiaryModel.data!.recipientName??"",
                      style: FontUtilities.style(
                        fontSize: 13,
                        fontWeight: FWT.medium,
                        fontColor: VariableUtilities.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 0.5,
                      width: Get.width * 0.2,
                      color: VariableUtilities.theme.primaryColor,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Name',
                      style: FontUtilities.style(
                        fontSize: 9,
                        fontColor: const Color(0xFF808080),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      mtmBeneficiaryModel.data!.recipientSurname??"",
                      style: FontUtilities.style(
                        fontSize: 13,
                        fontWeight: FWT.medium,
                        fontColor: VariableUtilities.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 0.3,
                      width: Get.width * 0.4,
                      color: VariableUtilities.theme.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Receiver Address',
              style: FontUtilities.style(
                fontSize: 9,
                fontColor: const Color(0xFF808080),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              mtmBeneficiaryModel.data!.recipientAddress!,
              style: FontUtilities.style(
                fontSize: 13,
                fontWeight: FWT.medium,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 0.5,
              color: VariableUtilities.theme.primaryColor,
            ),
            const SizedBox(
              height: 22,
            ),
            CustomFlatButton(
              onPressed: () {
                Get.back();
                momoTransferController.changeSelectedBene(mtmBeneficiaryModel);
              },
              width: Get.width,
              title: 'Confirm',
              backColor: VariableUtilities.theme.secondaryColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomFlatButton(
                    onPressed: () {
                      Get.back();

                      Get.to(AddMobileBeneficiaryScreen(
                        isEdit: true,
                        mtmBeneficiaryModel: mtmBeneficiaryModel,
                      ));
                    },
                    width: Get.width,
                    title: 'Edit',
                    backColor: const Color(0xFF1C1E28),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: CustomFlatButton(
                    onPressed: () {
                      Get.back();
                      Get.dialog(
                        ConfirmationDialog(
                          description: 'you want to delete this beneficiary?',
                          onPositveTap: () {
                            momoTransferController.getTMtoMBeneDeleteStore(
                                mtmBeneficiaryModel.id!.toString());
                            Get.back();
                          },
                        ),
                      );
                    },
                    width: Get.width,
                    title: 'Delete',
                    backColor: const Color(0xFFD92D20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
