import 'package:bounce/bounce.dart';
import 'package:fintech/config/navigation/app_route.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/notification_history/view/notification_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardAppbar extends StatelessWidget {
  final String name;
  final String? imageURl;
  const DashboardAppbar(
      {super.key, required this.name, required this.imageURl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Bounce(
          onTap: (){
            Get.toNamed(RouteUtilities.profileScreen)!.then((value) {

            },);
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VariableUtilities.theme.primaryColor,
            ),
            child: imageURl != null
                ? ClipOval(
                    child: CachedNetworkImageView(
                      imageUrl: imageURl!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: VariableUtilities.theme.whiteColor,
                  ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${getGreetingMessage()}!',
                style: FontUtilities.style(
                  fontSize: 12,
                  fontColor: const Color(0xFF7C7D81),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                name,
                style: FontUtilities.style(
                  fontSize: 16,
                  fontWeight: FWT.bold,
                  fontColor: const Color(0xFF404148),
                ),
              ),
            ],
          ),
        ),
        Bounce(
          onTap: (){
            Get.to(const NotificationHistoryScreen());

          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEBEBEB), width: 2),
            ),
            child: SvgPicture.asset(AssetUtilities.notification),
          ),
        ),
      ],
    );
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
