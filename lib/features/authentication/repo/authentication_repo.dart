import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:fintech/features/common/model/user_model.dart';
import 'package:fintech/features/home/view/pages/repo/home_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';

class AuthenticationRepo {
  Future<UserModel?> loginWithEmailPass(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.loginUrl,
          body: params,
          showErrorMessage: true,
          showSuccessMessage: false);
      if (response.isRight) {
        return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error :: ${e}");
      }
    }
    return null;
  }

  /// Send VerificationEmail
  Future<ApiResponse?> sendVerificationEmail(
      BuildContext context, Map<String, dynamic> params,
      {bool isResend = false}) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          url: isResend
              ? APIUtilities.reSendVerificationEmail
              : APIUtilities.sendVerificationEmail,
          body: params,
          showErrorMessage: true,
          showSuccessMessage: false);
      if (response.isRight) {
        final data = response.right;
        print("response.right");
        print(response.right);
        print(response.right);

        return ApiResponse(success: data['success'] ?? true, message :data['message'] ,data: data);
      }
    } catch (e) {
      print(
          "Error in ${isResend ? "reSendVerificationEmail" : "sendVerificationEmail"} :: ${e}");
    }
    return null;
  }

  /// Verify Email
  Future<Map<String, dynamic>?> verifyEmail(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.verifyEmail,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Verify Forgot Email
  Future<Map<String, dynamic>?> verifyForgotEmail(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.verifyForgotEmail,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Send Phone OTP
  Future<ApiResponse?> sendOTPOnPhone(
      BuildContext context, Map<String, dynamic> params,
      {bool isResend = false}) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          url: isResend
              ? APIUtilities.reSendPhoneOTP
              : APIUtilities.sendPhoneOTP,
          body: params,
          showSuccessMessage: false);
      if (response.isRight) {
        final data = response.right;
        print("data $data");
        print(data);
        return ApiResponse(success: data['success'] ?? true, message :data['message'] ,data: data);
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Verify Phone OTP
  Future<Map<String, dynamic>?> verifyPhoneOTP(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.verifyMobile,
          body: params,
          showSuccessMessage: false);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Register User
  Future<ApiResponse?> registerUser(
      BuildContext context, Map<String, dynamic> params,
      {bool isCompany = false}) async {
  //  try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: isCompany
              ? APIUtilities.registerWithCompanyUrl
              : APIUtilities.registerUrl,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(  success: data is Map<String, dynamic>
            ? (data['success'] is bool ? data['success'] as bool : true)
            : true,
            data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }
    /*} catch (e) {
      print("Error :: ${e}");
    }*/
    return null;
  }
  /// Register User
  Future<UserModel?> editBasicInfo(
      BuildContext context,
      Map<String, dynamic> params, {
        List<File>? files,
      }) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.editProfile,
          body: params,
          fileList: files,
          fileKey: ["profile_image"],
          isFileUpload: files != null ? true : false,
          showSuccessMessage: true);
      if (response.isRight) {
        return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
  /// Edit Profile
  Future<ApiResponse?> addKycData(
      BuildContext context,
      Map<String, dynamic> params, {
        List<File>? files,
        List<String>? filesKeys,
      }) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          url: APIUtilities.companyKycDocumentStore,
          body: params,
          fileList: files,
          fileKey: filesKeys,
          isFileUpload: files != null ? true : false,
          showSuccessMessage: true);
      if (response.isRight) {
        final data = response.right;
        return ApiResponse(success: data['success'] ?? true, data: data);
     //   return ApiResponse.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
  /// Forgot Password
  Future<dynamic> forgotPassword(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.forgotPassword,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Forgot Password Resend OTP
  Future<dynamic> forgotPasswordResendOTP(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.forgotPasswordResendOTP,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Forgot Password Resend OTP
  Future<dynamic> resetPassword(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.resetPassword,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Get User Info
  Future<UserModel?> getUserInfo(BuildContext context) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(
        context,
        type: APIType.tPost,
        url: APIUtilities.getUserInfo,
        showSuccessMessage: false,
        showErrorMessage: false
      );
      if (response.isRight) {
        return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }


  /// Forgot Password Resend OTP
  Future<dynamic> profileResetPassword(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.userResetPassword,
          body: params,
          showSuccessMessage: true);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
}
