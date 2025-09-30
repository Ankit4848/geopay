import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'About Us'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    data: commonController.common.value!.aboutus,
                    extensions: [
                      TagExtension(
                        tagsToExtend: {"flutter"},
                        child: const FlutterLogo(),
                      ),
                    ],
                    style: {
                      "p.fancy": Style(
                        textAlign: TextAlign.center,

                        backgroundColor: Colors.grey,
                        margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
                        width: Width(300, Unit.px),
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
