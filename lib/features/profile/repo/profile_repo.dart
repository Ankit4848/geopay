import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:geopay/features/common/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';

class ProfileRepo {
  /// LogOut User
  Future<dynamic> logOutUser(BuildContext context,bool isLogout) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          url: APIUtilities.logOutUrl,
          showSuccessMessage:isLogout? true:false);
      if (response.isRight) {
        return response.right;
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  /// Edit Profile
  Future<UserModel?> editProfile(
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
          showErrorMessage: true,
          showSuccessMessage: false);
      if (response.isRight) {
        return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
}
