import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/home/model/CommonModel.dart';
import 'package:geopay/features/profile/data/profile_data.dart';
import 'package:geopay/features/profile/widgets/faq_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/faq_model.dart';

class FAQSCreen extends StatelessWidget {
  FAQSCreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final RxList<Faqs> filteredFaqs = <Faqs>[].obs;

  @override
  Widget build(BuildContext context) {
    final CommonController commonController = Get.find();

    // Initialize search listener
    searchController.addListener(() {
      String query = searchController.text.toLowerCase();
      final allFaqs = commonController.common.value?.faqs ?? [];
      if (query.isEmpty) {
        filteredFaqs.value = allFaqs;
      } else {
        filteredFaqs.value = allFaqs.where((faq) {
          final question = faq.title?.toLowerCase() ?? '';
          final answer = faq.description?.toLowerCase() ?? '';
          return question.contains(query) || answer.contains(query);
        }).toList();
      }
    });

    // Initially set filteredFaqs
    if (filteredFaqs.isEmpty && commonController.common.value?.faqs != null) {
      filteredFaqs.value = commonController.common.value!.faqs!;
    }

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         CustomAppBar(title: 'FAQ'),
          Center(
            child: Text(
              'How can we help you?',
              style: FontUtilities.style(
                fontSize: 16,
                fontWeight: FWT.semiBold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomTextField(
              hintText: 'Enter your keyword',
              hintStyle: FontUtilities.style(
                fontSize: 14,
                fontColor: Colors.grey.shade700,
                fontWeight: FWT.medium,
              ),
              controller: searchController,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  color: Colors.grey.shade700,
                  CupertinoIcons.search,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Top Questions',
              style: FontUtilities.style(
                fontSize: 14,
                fontColor: VariableUtilities.theme.blackColor,
                fontWeight: FWT.semiBold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                physics: const BouncingScrollPhysics(),
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  return FAQCard(
                    faqModel: filteredFaqs[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

