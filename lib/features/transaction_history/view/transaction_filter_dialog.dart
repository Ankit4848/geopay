import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/transaction_history/controller/transaction_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TransactionFilterDialog extends StatelessWidget {
  final controller = Get.find<TransactionHistoryController>();

  TransactionFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: VariableUtilities.theme.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
              Text('Filter', style: FontUtilities.style(fontSize: 20, fontWeight: FWT.medium)),

              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: controller.startDateCtrl,
                      onTap: () => controller.selectStartDate(context),
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset(AssetUtilities.loop),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: controller.endDateCtrl,
                      onTap: () => controller.selectEndDate(context),
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() => Container(

                child: DropdownButtonFormField<String>(
                  dropdownColor: VariableUtilities
                      .theme.textFieldFilledColor,
                  menuMaxHeight: 250,
                  isDense: false,
                  isExpanded: true,
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
                    fillColor: VariableUtilities
                        .theme.textFieldFilledColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
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
                   // labelText: 'Payment Status',
                    hintText: 'Payment Status',


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

                  value: controller.selectedStatus.value.isEmpty ? null : controller.selectedStatus.value,
                  items: controller.mainTranscationModel.value!.txnStatuses!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e


                  )))
                      .toList(),
                  onChanged: (value) => controller.selectedStatus.value = value ?? '',
                ),
              )),
              const SizedBox(height: 16),

              Obx(() => Container(

                child: DropdownButtonFormField<String>(
                  dropdownColor: VariableUtilities
                      .theme.textFieldFilledColor,
                  menuMaxHeight: 250,
                  isDense: false,
                  isExpanded: true,
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
                    fillColor: VariableUtilities
                        .theme.textFieldFilledColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
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
                    // labelText: 'Payment Status',
                    hintText: 'Service',

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

                  value: controller.selectedService.value.isEmpty ? null : controller.selectedService.value,
                  items: controller.mainTranscationModel.value!.transactionTypes!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => controller.selectedService.value = value ?? '',
                ),
              )),





              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => controller.clearFilters(),
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.applyFilters();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VariableUtilities.theme.secondaryColor,
                      ),
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
