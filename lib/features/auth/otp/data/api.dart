import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/verify_register_otp_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class VerifyRegisterOtpApi {
  static final VerifyRegisterOtpApi _singleton = VerifyRegisterOtpApi._internal();
  VerifyRegisterOtpApi._internal();
  static VerifyRegisterOtpApi get instance => _singleton;

  Future<VerifyRegisterOtpModel> verifyRegisterOtpApi({
    required String email,
    required String otp,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
        "otp": otp,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.verifyEmail(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = VerifyRegisterOtpModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
