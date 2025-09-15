import 'package:flutter/material.dart';

import '../core.dart';

/// all the validations are stored in this class.
class Validator {
  /// email validation.
  static String? validateEmail(BuildContext context,
      {required String email, required bool showSnack}) {
    if (email.isEmpty) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please fill the email field!",
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }

      return 'Please fill the email field !';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter valid email address !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return 'Please enter valid email address !';
    }

    return null;
  }

  /// password validation is managed in this function.
  static String? validatePassword(String value) {
    List<String> errors = [];

    if (value.isEmpty) {
      return 'Please enter password';
    }

    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      errors.add('• At least one uppercase letter');
    }

    if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
      errors.add('• At least one digit');
    }

    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
      errors.add('• At least one special character (!@#\$&*~)');
    }

    if (!RegExp(r'^.{8,}').hasMatch(value)) {
      errors.add('• Minimum 8 characters');
    }

    if (errors.isEmpty) {
      return null;
    } else {
      return errors.join('\n'); // Combine all errors into one string
    }
  }


  /// match password and confirm-password.
  static String? validateConfirmPassword(BuildContext context,
      {required String password,
      required String confirmPassword,
      required bool showSnack}) {
    if (confirmPassword.isEmpty) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fill the confirm password field!',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return 'Please fill the confirm password field!';
    } else if (password != confirmPassword) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Confirm Password does not match !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return 'Confirm Password does not match !';
    }
    return null;
  }

  /// validate phone number.
  static String? validatePhoneNumber(BuildContext context,
      {required String phoneNumber, required bool showSnack}) {
    if (phoneNumber.isEmpty) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fill the phone number field !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return 'Please fill the phone number field !';
    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber)) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter valid phone number !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return 'Please enter valid phone number !';
    } else if (phoneNumber.trim().length != 10) {
      if (showSnack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Mobile number length must be 10 digit long',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return "Mobile number length must be 10 digit long";
    }
    return null;
  }

  static bool isNotNullOrEmpty(String? str) =>
      str != null && str.trim().isNotEmpty;

  /// username validation.
  static bool validateUserName(BuildContext context,
      {required String name, required bool showSnack}) {
    if (name.trim().isEmpty) {
      if (showSnack) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fill the name field !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return false;
    }
    return true;
  }

  /// image validation.
  static bool validateImage(BuildContext context,
      {required dynamic image, required showSnack}) {
    if (image == null || image.isEmpty) {
      if (showSnack) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please Select Image !',
              style: TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
      return false;
    }
    return true;
  }
}
