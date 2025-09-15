import 'package:bounce/bounce.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/dashboard/controller/dashboard_controller.dart';
import 'package:fintech/features/transaction_history/controller/transaction_history_controller.dart';
import 'package:fintech/features/transaction_history/view/transaction_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  DashboardController dashboardController = Get.find();
  TransactionHistoryController transactionHistoryController =
      Get.put(TransactionHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionHistoryController.clearFilterss();
    transactionHistoryController.getTransactionList().then(
      (value) {
        setState(() {});
      },
    );
  }


  Future<void> downloadFile(BuildContext context,String url) async {


    try {

      launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }


  String _twoDigits(int n) => n.toString().padLeft(2, '0');


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Transaction History',
          onBackTap: () {
            dashboardController.onBackTap();
          },
          action: [
            IconButton(
              onPressed: () async {
                transactionHistoryController.clearFilterss();
               await showDialog(
                  useSafeArea: true,
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return  TransactionFilterDialog();
                  },
                ).then(
                  (value) {
                    FocusScope.of(context).unfocus();
                    setState(() {

                    });
                  },
                );
                setState(() {

                });
              },
              icon: SvgPicture.asset(
                AssetUtilities.filter,
                height: 24,
                width: 24,
              ),
            )
          ],
        ),
        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: TextFormField(
            controller: transactionHistoryController.searchController,
            decoration: InputDecoration(
              hintText: 'Search by service, order ID, or type',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),


    Obx(() => transactionHistoryController.filteredList.isEmpty?

         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Center(child: Text('No data found.', style: FontUtilities.style(fontSize: 20, fontWeight: FWT.medium))),
             ],
           ),
         ) :  Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                FadeSlideTransition(
                  seconds: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount:
                    transactionHistoryController.filteredList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item =
                      transactionHistoryController.filteredList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFF5F4F4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                BuildRowWidget(
                                    title: 'Sr No.',
                                    value: '${index + 1}'),
                                const SizedBox(width: 22),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: VariableUtilities
                                        .theme.blackColor
                                        .withOpacity(0.1),
                                  ),
                                ),
                                const SizedBox(width: 22),
                                Text(
                                  item.transactionType!,
                                  style: FontUtilities.style(
                                    fontSize: 12,
                                    fontWeight: FWT.bold,
                                    fontColor:
                                    item.transactionType == "debit"
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            BuildRowWidget(
                                title: 'Service Name',
                                value: item.platformName!),
                            BuildRowWidget(
                                title: 'Order Id', value: item.orderId!),
                            Row(
                              children: [
                                BuildRowWidget(
                                    title: 'Fees',
                                    value: "${item.fees!} USD"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: BuildRowWidget(
                                      title: 'Total Amount',
                                      value: "${item.txnAmount!} USD"),
                                ),
                              ],
                            ),
                            BuildRowWidget(
                                title: 'Exchange Rate',
                                value: item.unitConvertExchange!),
                            _buildTextRow(
                                "Remark :", item.comments ?? "-"),
                            _buildTextRow("Notes :",
                                item.notes == "" ? "-" : item.notes!),
                            _buildTextRow(
                                "Refund Reason :",
                                item.refundReason == "null"
                                    ? "-"
                                    : item.refundReason!),
                            BuildRowWidget(
                                title: 'Status',
                                textColor: Colors.black,
                                value: item.txnStatus!),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BuildRowWidget(
                                      title: 'Created At',
                                      textColor: Colors.black,
                                      value: formatDateFromString(
                                          item.createdAt!)),
                                ),

                                Bounce(
                                  onTap: (){
                                    downloadFile(context,item.receiptUrl!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration:  BoxDecoration(
                                      color:VariableUtilities.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: SvgPicture.asset(
                                      AssetUtilities.download,
                                      height: 22,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),


                                /*Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF8F8F8),
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                                      ),
                                      child: CustomFlatButton(
                                        onPressed: () {
                                          downloadFile(context,item.receiptUrl!);
                                        },
                                        fontSize: 15,

                                        backColor: VariableUtilities.theme.secondaryColor,
                                        title: "Download Receipt",
                                      ),
                                    ),*/

                              ],
                            ),
                            const SizedBox(height: 10),








                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  String formatDateFromString(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
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
