import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:fintech/features/common/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../../config/network_client/api/api.dart';

class ApiResponse {
  final bool success;
  final String? message;
  final dynamic data;

  ApiResponse({required this.success,this.message ,required this.data});
}

class HomeRepo {
  /// Register User
  ///
  Future<ApiResponse?> payWithoutQrMoney(
      BuildContext context, Map<String, dynamic> params,
      {bool isCompany = false}) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI1(context,
          type: APIType.tPost,
          url: APIUtilities.walletWithoutQR,
          body: params,
          showSuccessMessage: false);
      if (response.isRight) {

        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'], data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }

    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
}
