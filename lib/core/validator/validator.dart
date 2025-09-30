import 'package:flutter/material.dart';

import '../core.dart';

/// all the validations are stored in this class.
class Validator {
  /// email validation.
  static String? validateEmail(BuildContext context,
      {required String email, required bool showSnack}) {
    if (email.isEmpty) {
      if (showSnack) {

        DialogUtilities.showDialog(
          title: "Error",
          message:    "Please fill the email field!",
        );



      }

      return 'Please fill the email field !';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      if (showSnack) {
        DialogUtilities.showDialog(
          title: "Error",
          message:    'Please enter valid email address !',
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

        DialogUtilities.showDialog(
          title: "Error",
          message:   'Please fill the confirm password field!',
        );


      }
      return 'Please fill the confirm password field!';
    } else if (password != confirmPassword) {
      if (showSnack) {
        DialogUtilities.showDialog(
          title: "Error",
          message:  'Confirm Password does not match !',
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
        DialogUtilities.showDialog(
            title: "Error",
            message:  'Please fill the phone number field !',
        );

      }
      return 'Please fill the phone number field !';
    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber)) {
      if (showSnack) {
        DialogUtilities.showDialog(
            title: "Error",
            message:   'Please enter valid phone number !',
        );

      }
      return 'Please enter valid phone number !';
    } else if (phoneNumber.trim().length != 10) {
      if (showSnack) {
        DialogUtilities.showDialog(
          title: "Error",
          message:    'Mobile number length must be 10 digit long',
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

        DialogUtilities.showDialog(
          title: "Error",
          message:    'Please fill the name field !',
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
        DialogUtilities.showDialog(
          title: "Error",
          message: 'Please Select Image !',
        );

      }
      return false;
    }
    return true;
  }
}
