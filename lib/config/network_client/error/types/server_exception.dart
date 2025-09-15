part of '../exception_utilities.dart';

/// Class to handle Server Based Exceptions.
class ServerException implements Exception {
  /// Constructor of Server Based Exception.
  ServerException();

  final String _title = '''Error!''';
  final String _message =
      '''Please Check After Some time.\nServer is not up!''';

  /// getter of message.
  String getMessage() => _message;

  /// show snackbar.
  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(
          message ,
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
                child:  Text( message,
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
