import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/view/pages/add_money/controller/add_money_controller.dart';
import 'package:geopay/features/home/view/pages/add_money/widgets/balance_card.dart';
import 'package:geopay/features/home/view/pages/add_money/widgets/select_money_option_widget.dart';
import 'package:geopay/features/home/view/pages/deposite_payment/controller/deposit_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../model/drop_down_model.dart';

class DepositPaymentScreen extends StatefulWidget {
  const DepositPaymentScreen({super.key});

  @override
  State<DepositPaymentScreen> createState() => _DepositPaymentScreenState();
}

class _DepositPaymentScreenState extends State<DepositPaymentScreen> {
  late DepositPaymentController controller;
  FocusNode amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Get.put(DepositPaymentController());
    controller.getCountryList();
    amountFocusNode.addListener(() {
      if (!amountFocusNode.hasFocus) {}
    });
  }

  @override
  void dispose() {
    controller.clearAllFields();
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

  Widget _buildCardDetailsSection() {
    return GetBuilder<DepositPaymentController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Card Details",
              style: FontUtilities.style(
                fontSize: 18,
                fontWeight: FWT.bold,
                fontFamily: FontFamily.poppins,
                fontColor: VariableUtilities.theme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            
            // Cardholder Name
            CustomTextField(
              controller: controller.cardHolderNameCtrl,
              hintText: 'Enter cardholder name',
              labelText: 'Cardholder Name *',

              onChange: (value) => controller.fieldErrors.remove('cardholder_name'),

              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(Icons.person, color: VariableUtilities.theme.primaryColor),
              ),
            ),
            if (controller.fieldErrors['cardholder_name'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  controller.fieldErrors['cardholder_name']!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 16),

            // Card Number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: controller.cardNumberCtrl,
                  hintText: '**** **** **** ****',
                  labelText: 'Card Number *',

                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberInputFormatter(),
                  ],
                  onChange: (value) {
                    controller.fieldErrors.remove('card_number');
                    controller.updateCardType(value ?? '');
                    controller.formatCardNumber(value!);
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(Icons.credit_card, color: VariableUtilities.theme.primaryColor),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _getCardIcon(controller.cardNumberCtrl.text),
                  ),
                ),
                // Show detected card type
              /*  if (controller.cardNumberCtrl.text.isNotEmpty && _getCardType(controller.cardNumberCtrl.text) != 'Unknown')
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Detected: ${_getCardType(controller.cardNumberCtrl.text)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),*/
                if (controller.fieldErrors['card_number'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      controller.fieldErrors['card_number']!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Expiry Date and CVV
            Row(
              children: [
                // Expiry Month
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry Month *",
                        style: FontUtilities.style(
                          fontSize: 14,
                          fontWeight: FWT.semiBold,
                          fontFamily: FontFamily.poppins,
                          fontColor: VariableUtilities.theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AppDropDown<String>(
                        hintText: 'Month',
                        hintStyle: FontUtilities.style(
                          fontSize: 13,
                          fontWeight: FWT.regular,
                          fontColor: Colors.grey,
                        ),
                        items: _getMonths().map((month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month,style: TextStyle(
                              color: VariableUtilities.theme.primaryColor,fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),),
                          );
                        }).toList(),
                        value: controller.selectedExpiryMonth.value,
                        onChange: (value) {
                          controller.changeExpiryMonth(value!);
                        },
                      ),
                      if (controller.fieldErrors['expiry_month'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            controller.fieldErrors['expiry_month']!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                
                // Expiry Year
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry Year *",
                        style: FontUtilities.style(
                          fontSize: 14,
                          fontWeight: FWT.semiBold,
                          fontFamily: FontFamily.poppins,
                          fontColor: VariableUtilities.theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AppDropDown<String>(
                        hintText: 'Year',
                        hintStyle: FontUtilities.style(
                          fontSize: 13,
                          fontWeight: FWT.regular,
                          fontColor: Colors.grey,
                        ),
                        items: _getYears().map((year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(year,style: TextStyle(
                                color: VariableUtilities.theme.primaryColor,fontSize: 13,
                                fontWeight: FontWeight.w500
                            ),),
                          );
                        }).toList(),
                        value: controller.selectedExpiryYear.value,
                        onChange: (value) {
                          controller.changeExpiryYear(value!);
                        },
                      ),
                      if (controller.fieldErrors['expiry_year'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            controller.fieldErrors['expiry_year']!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // CVV
            CustomTextField(
              controller: controller.cvvCtrl,
              hintText: '123',
              labelText: 'CVV / CVC *',
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              onChange: (value) => controller.fieldErrors.remove('cvv'),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(Icons.security, color: VariableUtilities.theme.primaryColor),
              ),
            ),
            if (controller.fieldErrors['cvv'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  controller.fieldErrors['cvv']!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 16),

            // Amount
            CustomTextField(
              controller: controller.amountCtrl,
              hintText: 'Enter Amount',
              labelText: 'Amount *',
              textInputType: const TextInputType.numberWithOptions(decimal: true),
              focusNode: amountFocusNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChange: (value) {
                controller.fieldErrors.remove('amount');
                if (value!.isNotEmpty) {
                  controller.fetchAmountBreakdown();
                } else {

                  controller.update();
                }
              },
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SvgPicture.asset(AssetUtilities.doller),
              ),
            ),
            if (controller.fieldErrors['amount'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  controller.fieldErrors['amount']!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            GetBuilder<DepositPaymentController>(
              builder: (controller) {
                if (controller.amountCtrl.text.isNotEmpty) {
                  return Container(

                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAmountInfo(
                          'Processing Fee (USD)',
                          controller
                              .processingFee.value!,
                        ),
                        _buildAmountInfo(
                          'Net Amount In USD',
                          controller
                              .netAmount.value!,
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getMonths() {
    return [
      '01', '02', '03', '04', '05', '06',
      '07', '08', '09', '10', '11', '12'
    ];
  }

  List<String> _getYears() {
    int currentYear = DateTime.now().year;
    List<String> years = [];
    for (int i = 0; i < 80; i++) {
      years.add((currentYear + i).toString());
    }
    return years;
  }

  Widget _getCardIcon(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    
    if (cardNumber.isEmpty) {
      return const Icon(Icons.credit_card, color: Colors.grey);
    }
    
    // Visa: starts with 4
    if (cardNumber.startsWith('4')) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'VISA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // Mastercard: starts with 5 or 2221-2720
    else if (cardNumber.startsWith('5') || 
             (cardNumber.length >= 4 && 
              int.tryParse(cardNumber.substring(0, 4)) != null &&
              int.parse(cardNumber.substring(0, 4)) >= 2221 && 
              int.parse(cardNumber.substring(0, 4)) <= 2720)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade700, Colors.orange.shade600],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'MC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // American Express: starts with 34 or 37
    else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'AMEX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // Discover: starts with 6011, 622126-622925, 644-649, 65
    else if (cardNumber.startsWith('6011') || 
             cardNumber.startsWith('65') ||
             (cardNumber.length >= 6 && 
              int.tryParse(cardNumber.substring(0, 6)) != null &&
              int.parse(cardNumber.substring(0, 6)) >= 622126 && 
              int.parse(cardNumber.substring(0, 6)) <= 622925) ||
             (cardNumber.length >= 3 && 
              int.tryParse(cardNumber.substring(0, 3)) != null &&
              int.parse(cardNumber.substring(0, 3)) >= 644 && 
              int.parse(cardNumber.substring(0, 3)) <= 649)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'DISC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // Diners Club: starts with 30, 36, 38
    else if (cardNumber.startsWith('30') || 
             cardNumber.startsWith('36') || 
             cardNumber.startsWith('38')) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.purple.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'DINER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // JCB: starts with 35
    else if (cardNumber.startsWith('35')) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.indigo.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'JCB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // Union Pay: starts with 62
    else if (cardNumber.startsWith('62')) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'UNION',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    
    // Unknown card type
    else {
      return const Icon(Icons.credit_card, color: Colors.grey);
    }
  }

  // Get card type as string for validation
  String _getCardType(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    
    if (cardNumber.isEmpty) return 'Unknown';
    
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5') || 
               (cardNumber.length >= 4 && 
                int.tryParse(cardNumber.substring(0, 4)) != null &&
                int.parse(cardNumber.substring(0, 4)) >= 2221 && 
                int.parse(cardNumber.substring(0, 4)) <= 2720)) {
      return 'Mastercard';
    } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return 'American Express';
    } else if (cardNumber.startsWith('6011') || 
               cardNumber.startsWith('65') ||
               (cardNumber.length >= 6 && 
                int.tryParse(cardNumber.substring(0, 6)) != null &&
                int.parse(cardNumber.substring(0, 6)) >= 622126 && 
                int.parse(cardNumber.substring(0, 6)) <= 622925)) {
      return 'Discover';
    } else if (cardNumber.startsWith('30') || 
               cardNumber.startsWith('36') || 
               cardNumber.startsWith('38')) {
      return 'Diners Club';
    } else if (cardNumber.startsWith('35')) {
      return 'JCB';
    } else if (cardNumber.startsWith('62')) {
      return 'Union Pay';
    } else {
      return 'Unknown';
    }
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

                  // Card Details Section
                  _buildCardDetailsSection(),

                  // Amount Breakdown

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Pay Button
          Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: GetBuilder<DepositPaymentController>(
              builder: (controller) => CustomFlatButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await controller.processCardPaymentWithWebView();
                  if (controller.isbtnClick.value) return;
                  // Validate card details before processing
                  if (controller.validateCardDetails()) {
                    controller.isbtnClick.value = true;
                    controller.update();
                   // await controller.processCardPaymentWithWebView();
                  }
                },
                backColor: VariableUtilities.theme.secondaryColor,
                title: "Pay",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card Number Formatter Class
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
