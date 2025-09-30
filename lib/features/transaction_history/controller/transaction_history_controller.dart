import 'package:geopay/features/common/repo/common_repo.dart';
import 'package:geopay/features/transaction_history/model/TranscationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryController extends GetxController {
  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();
  Rxn<MainTranscationModel> mainTranscationModel = Rxn<MainTranscationModel>();
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  RxList<String> selectedOption = <String>[].obs;
  TextEditingController startDateCtrl =
      TextEditingController(text: "2025-04-01");
  TextEditingController endDateCtrl = TextEditingController(
      text: dateFormat.format(DateTime.now().add(const Duration(days: 30))));

  // Function to pick start date
  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: endDate.value ?? DateTime(2101),
    );
   // if (picked != null && picked != startDate.value) {
      startDate.value = picked;
      startDateCtrl.text = dateFormat.format(startDate.value!);
  //  }
  }

  final TextEditingController searchController = TextEditingController();

  RxList<TranscationModel> filteredList = <TranscationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load your actual data here
  }





  final selectedStatus = ''.obs;
  final selectedService = ''.obs;






  void clearFilters() {
    selectedOption.clear();
    selectedStatus.value = '';
    selectedService.value = '';
    startDateCtrl.text="2025-04-01";
    endDateCtrl.text=dateFormat.format(DateTime.now().add(const Duration(days: 30)));
    getTransactionList();
    Get.back();
  }

  void clearFilterss() {
    selectedOption.clear();

    selectedStatus.value = '';
    selectedService.value = '';
    startDateCtrl.text="2025-04-01";
    startDate.value=DateTime.now();
    endDate.value=DateTime.now().add(const Duration(days: 1));
    endDateCtrl.text=dateFormat.format(DateTime.now().add(const Duration(days: 30)));
    update();
  }

  void applyFilters() {
    print('Filter Start: ${startDateCtrl.text}');
    print('Filter End: ${endDateCtrl.text}');
    print('Status: ${selectedStatus.value}');
    print('Service: ${selectedService.value}');
    print('Type: ${selectedOption}');

    getTransactionList();
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(transactionCollectionList);
    } else {
      filteredList.assignAll(transactionCollectionList.where((tx) =>
          tx.platformName!.toLowerCase().contains(query.toLowerCase()) ||
          tx.orderId!.toLowerCase().contains(query.toLowerCase()) ||
          tx.transactionType!.toLowerCase().contains(query.toLowerCase())));
    }
    update();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Function to pick end date
  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? (startDate.value ?? DateTime.now()),
      firstDate: startDate.value ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate.value) {
      endDate.value = picked;
      endDateCtrl.text = dateFormat.format(endDate.value!);
    }
  }

  void selectUnselectOption(String value) {
    if (selectedOption.contains(value)) {
      selectedOption.remove(value);
    } else {
      selectedOption.add(value);
    }
  }

  RxList<TranscationModel> transactionCollectionList = <TranscationModel>[].obs;
  CommonRepo commonRepo = CommonRepo();

  RxBool isLoading=false.obs;
  Future<void> getTransactionList() async {


    try {
      EasyLoading.show();
      isLoading.value=true;

      Map<String, dynamic> params = {
        "platform_name": selectedService.value.isEmpty?"":selectedService.value,
        "start_date": startDateCtrl.text.isNotEmpty?startDateCtrl.text:"2025-04-01",
        "end_date":endDateCtrl.text.isNotEmpty?endDateCtrl.text: "2025-04-30",
        "txn_status":selectedStatus.value.isEmpty?"":selectedStatus.value,
        "search": "",
        "start": 0,
        "limit": 50000
      };

      MainTranscationModel? tranListAPI =
          await commonRepo.getTranList(Get.context!, params);
      print("transaction API :: ${tranListAPI}");
      filteredList.clear();
      if (tranListAPI != null && tranListAPI.data!.isNotEmpty) {
        mainTranscationModel.value=tranListAPI;
        transactionCollectionList.value = tranListAPI.data!;
        filteredList.assignAll(transactionCollectionList);
        searchController.addListener(() {
          filterList(searchController.text);
        });
        update();
      }

    } catch (e) {
      print("Error: ${e}");
    } finally {
      isLoading.value=false;
      EasyLoading.dismiss();
    }
    update();
  }
}
