import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/dashboard/controller/dashboard_controller.dart';
import 'package:geopay/features/notification_history/controller/notification_history_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});

  @override
  State<NotificationHistoryScreen> createState() =>
      _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  DashboardController dashboardController = Get.find();
  NotificationHistoryController transactionHistoryController =
      Get.put(NotificationHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    transactionHistoryController.getNotificationList().then(
      (value) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          CustomAppBar(
            title: 'Notifications',
            onBackTap: () {
              Get.back();
            },
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: transactionHistoryController.searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),



          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [




                  FadeSlideTransition(
                    seconds: 1,
                    child: Obx(() => transactionHistoryController.filteredList.isEmpty?

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height*0.4,),
                        Center(child: Text('No data found.', style: FontUtilities.style(fontSize: 20, fontWeight: FWT.medium))),
                      ],
                    )
                        :ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount:
                              transactionHistoryController.filteredList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item =
                                transactionHistoryController.filteredList[index];
                            return Bounce(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFF5F4F4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      item.data!.comment!,
                                      style: FontUtilities.style(
                                        fontSize: 12,
                                        fontWeight: FWT.semiBold,
                                        fontColor: VariableUtilities.theme.blackColor,
                                      ),
                                    ),
                                    Text(
                                      timeago.format(DateTime.parse(item.createdAt!)),
                                      style: FontUtilities.style(
                                        fontSize: 12,
                                        fontColor: VariableUtilities.theme.thirdColor.withValues(alpha: 0.7),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateFromString(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy HH:mm:ss').format(dateTime);
    } catch (e) {
      return '-'; // or return the original string if parse fails
    }
  }

  Widget _buildTextRow(String label, String value) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontUtilities.style(
              fontSize: 10,
              fontWeight: FWT.semiBold,
              fontColor: VariableUtilities.theme.blackColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: FontUtilities.style(
                fontSize: 10,
                fontWeight: FWT.regular,
                fontColor: VariableUtilities.theme.blackColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
