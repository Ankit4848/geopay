part of '../exception_utilities.dart';

/// Class to handle PageNotFound Based Exceptions.
class PageNotFoundException implements Exception {
  /// Constructor of Server Based Exception.
  PageNotFoundException();

  final String _title = '''Page Not Found!''';
  final String _message = '''Requested Page is not found!''';

  /// getter of message.
  String getMessage() => _message;

  /// show snackbar.
  void showToast(BuildContext context, String? message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(
          message ?? _message,
          style: const TextStyle(color: Colors.white), // white font
        ),
        backgroundColor: Colors.red, // red background
        duration: const Duration(seconds: 5), // show for 3 seconds
        behavior: SnackBarBehavior.floating, // optional: floating snackbar
      ),
    );
/*
    Get.dialog(
        barrierDismissible: false,
        ResultDialog(
          title: "$_title",
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
                child:  Text( message ?? _message,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),),
              ),
            ],
          ), description: '',
        ));*/
  }
}
