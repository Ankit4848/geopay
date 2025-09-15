part of '../exception_utilities.dart';

/// Class to handle Unknown or All API Exceptions.
class APIException implements Exception {
  /// Constructor of API Exceptions.
  APIException({required this.message});

  /// message to show with this exception.
  final String message;

  /// getter of message.
  String getMessage() => message;

  /// show snackbar.
  void showToast(BuildContext context) {





    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(
          message,
          style: const TextStyle(color: Colors.white), // white font
        ),
        backgroundColor: Colors.red, // red background
        duration: const Duration(seconds: 5), // show for 3 seconds
        behavior: SnackBarBehavior.floating, // optional: floating snackbar
      ),
    );


  }
}
