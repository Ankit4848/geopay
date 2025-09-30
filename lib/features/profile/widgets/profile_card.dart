import 'package:bounce/bounce.dart';
import 'package:geopay/config/config.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CommonController>();
    return GetBuilder<CommonController>(builder: (commonController) {
      return Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
            child: commonController.userModel.value?.profileImage != null
                ? ClipOval(
                    child: CachedNetworkImageView(
                      imageUrl: commonController.userModel.value!.profileImage!,
                      fit: BoxFit.fill,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                  ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${commonController.userModel.value?.firstName ?? 'John'} ${commonController.userModel.value?.lastName ?? 'Wick'}",
                  style: FontUtilities.style(
                    fontSize: 16,
                    fontWeight: FWT.semiBold,
                  ),
                ),
                Text(
                  'User',
                  style: FontUtilities.style(
                    fontSize: 14,
                    fontWeight: FWT.regular,
                    fontColor: const Color(0xFF484848),
                  ),
                ),
              ],
            ),
          ),
          Bounce(
            onTap: () {
              Get.toNamed(RouteUtilities.editProfileScreen);
            },
            child: SvgPicture.asset(
              AssetUtilities.editProfile,
            ),
          )
        ],
      );
    });
  }
}
