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
        ));

  }
}
