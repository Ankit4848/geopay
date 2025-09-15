import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/dashboard/controller/dashboard_controller.dart';
import 'package:fintech/features/profile/controller/profile_controller.dart';
import 'package:fintech/features/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find();
    ProfileController profileController = Get.find();
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Profile',
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileCard(),
                  const SizedBox(height: 16),
                  Image.asset(AssetUtilities.line),
                  const SizedBox(height: 20),
                  buildProfileRow(
                    icon: AssetUtilities.changePassword,
                    title: 'Change Password',
                    onTap: () {
                      Get.toNamed(RouteUtilities.changePasswordScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.info,
                    title: 'Basic Info',
                    onTap: () {
                      Get.toNamed(RouteUtilities.basicInfoScreen);
                    },
                  ),
                 /* const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.referral,
                    title: 'Referral Code',
                    onTap: () {},
                  ),*/
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.faq,
                    title: 'FAQ',
                    onTap: () {
                      Get.toNamed(RouteUtilities.faqScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.aboutUs,
                    title: 'About Us',
                    onTap: () {
                      Get.toNamed(RouteUtilities.aboutUsScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.contactUs,
                    title: 'Contact Us',
                    onTap: () {
                      Get.toNamed(RouteUtilities.contactUsScreen);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.deleteIcons,
                    title: 'Delete Account',
                    onTap: () {
                      _showDeleteAccountDialog(context, profileController);
                    },
                  ),
                  const SizedBox(height: 16),
                  buildProfileRow(
                    icon: AssetUtilities.logout,
                    title: 'Logout',
                    onTap: () {
                      _showLogoutDialog(context, profileController);
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

  Widget buildProfileRow({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Bounce(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFF5F4F4),
            ),
            child: SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              title,
              style: FontUtilities.style(
                fontSize: 14,
              ),
            ),
          ),
          Visibility(
            visible: title != "Logout",
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
          )
        ],
      ),
    );
  }


  void _showLogoutDialog(BuildContext context, ProfileController profileController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              profileController.logOutUser(context,true);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showDeleteAccountDialog(BuildContext context, ProfileController profileController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to delete your account?',style: TextStyle(
              fontSize: 15
            ),),
            Text('This action cannot be undone and you will lose all your data.',style: TextStyle(
                fontSize: 15
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {


              Get.back();
              Get.dialog(
                  barrierDismissible: false,
                  ResultDialog(
                    title: "Request Sent",
                    positiveButtonText: "Dismiss",
                    showCloseButton: false,
                    onPositveTap: () async {
                      Get.back(); // close dialog
                      profileController.logOutUser(context,false);
                    },
                    descriptionWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        GestureDetector(
                          child:  Text( " The support team will review your request and only after approval your account will be deleted",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),),
                        ),
                      ],
                    ), description: '',
                  ));

            },
            child: const Text('Delete'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }






}
