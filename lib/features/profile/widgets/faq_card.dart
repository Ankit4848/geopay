import 'package:geopay/core/core.dart';
import 'package:geopay/features/home/model/CommonModel.dart';
import 'package:geopay/features/profile/model/faq_model.dart';
import 'package:flutter/material.dart';

class FAQCard extends StatelessWidget {
  final Faqs faqModel;
  const FAQCard({super.key, required this.faqModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: faqModel.isExpanded.stream,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF434343),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        faqModel.title!,
                        style: FontUtilities.style(
                          fontSize: 14,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        faqModel.isExpanded.value = !faqModel.isExpanded.value;
                        faqModel.isExpanded.refresh();
                      },
                      icon: faqModel.isExpanded.value
                          ? Container(
                              height: 2,
                              width: 12,
                              color: VariableUtilities.theme.secondaryColor,
                            )
                          : Icon(
                              Icons.add,
                              color: VariableUtilities.theme.secondaryColor,
                            ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Visibility(
                  visible: faqModel.isExpanded.value,
                  child: Text(
                    faqModel.description!,
                    style: FontUtilities.style(
                      fontSize: 14,
                      fontColor: const Color(0xFF7C7C7C),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
