import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dialogs/result_dialog.dart';

class DialogUtilities {
  // Success Dialog
  static void showSuccess(String message, {String? title, VoidCallback? onOk}) {
    Get.dialog(
      barrierDismissible: false,
      ResultDialog(
        title: title ?? "Success",
        description: message,
        positiveButtonText: "Dismiss",
        showCloseButton: false,
        onPositveTap: () {
          Get.back();
          onOk?.call();
        },
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              title ?? "Success",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error Dialog  
  static void showError(String message, {String? title, VoidCallback? onOk}) {
    Get.dialog(
      barrierDismissible: false,
      ResultDialog(
        title: title ?? "Error",
        description: message,
        positiveButtonText: "Dismiss",
        showCloseButton: false,
        onPositveTap: () {
          Get.back();
          onOk?.call();
        },
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? "Error",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Warning Dialog
  static void showWarning(String message, {String? title, VoidCallback? onOk}) {
    Get.dialog(
      barrierDismissible: false,
      ResultDialog(
        title: title ?? "Warning",
        description: message,
        positiveButtonText: "Dismiss",
        showCloseButton: false,
        onPositveTap: () {
          Get.back();
          onOk?.call();
        },
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? "Warning",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info Dialog
  static void showInfo(String message, {String? title, VoidCallback? onOk}) {
    Get.dialog(
      barrierDismissible: false,
      ResultDialog(
        title: title ?? "Information",
        description: message,
        positiveButtonText: "Dismiss",
        showCloseButton: false,
        onPositveTap: () {
          Get.back();
          onOk?.call();
        },
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? "Information",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generic function that can replace any SnackBar
  static void showDialog({
    required String message,
    String? title,
    bool isError = false,
    bool isSuccess = false,
    bool isWarning = false,
    VoidCallback? onOk,
  }) {
    if (isSuccess) {
      showSuccess(message, title: title, onOk: onOk);
    } else if (isError){
      showError(message, title: title, onOk: onOk);
    } else {
      showSuccess(message, title: title, onOk: onOk);
    }
  }
}
