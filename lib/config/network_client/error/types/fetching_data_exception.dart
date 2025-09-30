part of '../exception_utilities.dart';

/// Class to handle Exceptions Based on Fetchind Data.
class FetchingDataException implements Exception {
  /// Constructor of FetchinfData Exceptions.
  FetchingDataException();

  final String _message = '''Fetching Data!''';

  /// getter of message.
  String getMessage() => _message;

  /// show snackbar.
  void showToast(BuildContext context) {


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
                child:  Text(  _message,
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
