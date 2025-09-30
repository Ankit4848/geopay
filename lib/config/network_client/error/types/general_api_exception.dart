part of '../exception_utilities.dart';

/// Class to handle General API Exception.
class GeneralAPIException implements Exception {
  /// Constructor of General Exceptions.
  GeneralAPIException({this.message});

  /// message to show with this exception.
  final String? message;

  /// getter of message.
  String? getMessage() => message;

  /// show snackbar.
  void showToast(BuildContext context, String? message) {

    Get.dialog(
        barrierDismissible: false,
        ResultDialog(
          title: "Error",
          positiveButtonText: "Dismiss",
          showCloseButton: false,
          onPositveTap: () async {
            Get.back(); // close dialog
          },
          descriptionWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              GestureDetector(
                child:  Text( message ?? 'API Request Failed!',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),),
              ),
            ],
          ), description: '',
        ));
  }
}
