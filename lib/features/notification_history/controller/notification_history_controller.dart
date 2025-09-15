import 'package:fintech/features/common/repo/common_repo.dart';
import 'package:fintech/features/notification_history/model/NotificationModel.dart';
import 'package:fintech/features/transaction_history/model/TranscationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationHistoryController extends GetxController {
  RxList<String> selectedOption = <String>[].obs;

  final TextEditingController searchController = TextEditingController();

  RxList<NotificationModel> filteredList = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load your actual data here
  }



  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(transactionCollectionList);
    } else {
      filteredList.assignAll(transactionCollectionList.where((tx) =>
      tx.data!.receiverName!.toLowerCase().contains(query.toLowerCase()) ||
          tx.data!.comment!.toLowerCase().contains(query.toLowerCase()) ||
          tx.data!.transactionStatus!.toLowerCase().contains(query.toLowerCase()) ||
          tx.data!.notes!.toLowerCase().contains(query.toLowerCase())));
    }
    update();
  }

  RxList<NotificationModel> transactionCollectionList =
      <NotificationModel>[].obs;
  CommonRepo commonRepo = CommonRepo();

  Future<void> getNotificationList() async {
    try {
      EasyLoading.show();

      List<NotificationModel>? tranListAPI =
          await commonRepo.getNotificationList(Get.context!);
      print("transaction API :: ${tranListAPI}");
      if (tranListAPI != null && tranListAPI.isNotEmpty) {
        transactionCollectionList.value = tranListAPI;
        filteredList.assignAll(transactionCollectionList);
        searchController.addListener(() {
          filterList(searchController.text);
        });

        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }
}
