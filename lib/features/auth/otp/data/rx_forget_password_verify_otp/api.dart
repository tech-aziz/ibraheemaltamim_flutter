import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/forget_password_otp_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class VerifyForgetPasswordOtpApi {
  static final VerifyForgetPasswordOtpApi _singleton = VerifyForgetPasswordOtpApi._internal();
  VerifyForgetPasswordOtpApi._internal();
  static VerifyForgetPasswordOtpApi get instance => _singleton;

  Future<ForgetPasswordOtpVerifyModel> verifyForgetPasswordOtpApi({
    required String email,
    required String otp,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
        "otp": otp,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.verifyForgetPasswordOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ForgetPasswordOtpVerifyModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
