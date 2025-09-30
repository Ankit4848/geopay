import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(title: 'Contact Us'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetUtilities.location,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        commonController.common.value!.siteName!,
                        style: FontUtilities.style(
                            fontSize: 12, fontWeight: FWT.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    commonController.common.value!.contactAddress!,
                    style: FontUtilities.style(
                      fontSize: 12,
                      fontWeight: FWT.regular,
                      fontColor: const Color(0xFF7B7B7B),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSocialCard(
                    icon: AssetUtilities.email,
                    title: 'Email :',
                    value: commonController.common.value!.contactEmail!,
                    onTap: () {
                      _launchEmail();
                    },
                  ),
                  buildSocialCard(
                    icon: AssetUtilities.website,
                    title: 'Visit us at :',
                    value: commonController.common.value!.contactWebsite!,
                    onTap: () async {
                      launchUrl(
                        Uri.parse(commonController.common.value!.contactWebsite!),
                      );
                    },
                  ),
                /*  buildSocialCard(
                    icon: AssetUtilities.call,
                    title: 'Call Support  :',
                    value: '+2305455615',
                    onTap: () {
                      _launchDialer();
                    },
                  ),*/
                  const SizedBox(height: 23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bounce(
                          onTap: () async {
                            await launchUrl(Uri.parse(commonController.common.value!.socialWhatsapp!));
                          },
                          child: SvgPicture.asset(AssetUtilities.whatsapp)),
                      const SizedBox(width: 14),
                      Bounce(
                          onTap: () async {
                            await launchUrl(
                              Uri.parse(commonController.common.value!.socialInstagram!),
                            );
                          },
                          child: SvgPicture.asset(AssetUtilities.instagram)),
                      const SizedBox(width: 14),
                      Bounce(
                          onTap: () async {
                            await launchUrl(
                              Uri.parse(commonController.common.value!.socialFacebook!),
                            );
                          },
                          child: SvgPicture.asset(AssetUtilities.facebook)),
                      const SizedBox(width: 14),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSocialCard({
    required String icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Bounce(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF9E9E9E),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 18),
            Text(
              "$title ",
              style: FontUtilities.style(
                fontSize: 12,
                fontWeight: FWT.black,
              ),
            ),
            Flexible(
              child: Text(
                "$value ",
                style: FontUtilities.style(
                  fontSize: 12,
                  fontWeight: FWT.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: "support@fintech.global",
    );
    var url = params.toString();

    await launch(url);
  }

  void _launchDialer() async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: '+2705455615',
    );

    await launch(telUri.toString());
  }


}
