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
                child:  Text( message ?? _message,
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
