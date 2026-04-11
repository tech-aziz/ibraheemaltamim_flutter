import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/resend_otp_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ResendOtpApi {
  static final ResendOtpApi _singleton = ResendOtpApi._internal();
  ResendOtpApi._internal();
  static ResendOtpApi get instance => _singleton;

  Future<ResendOtpModel> resendOtpApi({
    required String email,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.resendOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ResendOtpModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
