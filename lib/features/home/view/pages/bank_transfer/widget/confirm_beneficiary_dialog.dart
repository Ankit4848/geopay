import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/controller/bank_transfer_controller.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBeneModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/view/add_bank_beneficiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ConfirmBeneficiaryDialog extends StatelessWidget {
  TTBBeneModel mtmBeneficiaryModel;

  ConfirmBeneficiaryDialog({super.key, required this.mtmBeneficiaryModel});

  @override
  Widget build(BuildContext context) {
    BankTransferController bankTransferController = Get.find();

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
              'Category Name',
              style: FontUtilities.style(
                fontSize: 9,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Transfer To Bank Money',
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
                    "${mtmBeneficiaryModel.data["payoutCountry"]}",
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank Name',
                        style: FontUtilities.style(
                          fontSize: 9,
                          fontColor: const Color(0xFF808080),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        mtmBeneficiaryModel.data["bankName"]??"",
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
                          mtmBeneficiaryModel.data["receivercontactnumber"]??"N/A",
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
            Text(
              'Bank Account No.',
              style: FontUtilities.style(
                fontSize: 9,
                fontColor: const Color(0xFF808080),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              mtmBeneficiaryModel.data["bankaccountnumber"]??"",
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
                      mtmBeneficiaryModel.data["receiverfirstname"]??"",
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
                      mtmBeneficiaryModel.data["receiverlastname"]??"",
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
              mtmBeneficiaryModel.data["senderaddress"]??"",
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
                bankTransferController.changeSelectedBene(mtmBeneficiaryModel);
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
                      Get.to(AddBankBeneficiaryScreen(
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
                          onPositveTap: () async {

                            Get.back();
                            bankTransferController.getTMtoMBeneDeleteStore(
                                mtmBeneficiaryModel.id.toString());
                            await bankTransferController.getTMtoMBeneListStore();

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
