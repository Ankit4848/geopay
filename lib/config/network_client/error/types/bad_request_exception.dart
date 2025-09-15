part of '../exception_utilities.dart';

/// Class to handle BadRequest Based Exceptions.
class BadRequestException implements Exception {
  /// Constructor for BadRequest Based Exceptions.
  BadRequestException();

  final String _message =
      '''Something is missing in request.\nPlease check your request and try again!''';

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

   /* Get.dialog(
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
