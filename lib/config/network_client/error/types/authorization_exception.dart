part of '../exception_utilities.dart';

/// Class to handle Authorization Based Exception.
class AuthorizationException implements Exception {
  /// Constructor of Authorization Based Exception.
  AuthorizationException();

  final String _message =
      '''You have insufficient Permissions for this request.\nPlease request with proper permission!''';

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
