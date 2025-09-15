import 'package:get/get.dart';

import '../model/faq_model.dart';

class ProfileData {
  static List<FAQModel> faqList = [
    FAQModel(
        title: 'How to create a account?',
        description:
            'Open the Tradebase app to get started and follow the steps. Tradebase doesn’t charge a fee to create or maintain your Tradebase account.',
        isExpanded: false.obs),
    FAQModel(
        title: 'How to add a payment method by this app?',
        description:
            'Open the Tradebase app to get started and follow the steps. Tradebase doesn’t charge a fee to create or maintain your Tradebase account.',
        isExpanded: false.obs),
    FAQModel(
        title: 'What Time Does The Stock Market Open?',
        description:
            'Open the Tradebase app to get started and follow the steps. Tradebase doesn’t charge a fee to create or maintain your Tradebase account.',
        isExpanded: false.obs),
    FAQModel(
        title: 'Is The Stock Market Open On Weekends?',
        description:
            'Open the Tradebase app to get started and follow the steps. Tradebase doesn’t charge a fee to create or maintain your Tradebase account.',
        isExpanded: false.obs),
  ];
}
