part of '../exception_utilities.dart';

/// Class to handle DataToModel Conversion Based Exceptions.
class DataToModelConversionException implements Exception {
  /// Constructor of DataToModelConversion Based Exceptions.
  DataToModelConversionException({this.message});

  /// message to show with this exceptions.
  String? message;

  /// getter of messgae
  String? getMessage() => message;

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
                child:  Text( message ?? 'Data To Model Conversion Exception',
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
