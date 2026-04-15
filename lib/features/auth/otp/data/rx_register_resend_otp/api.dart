import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/register_resend_otp_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class RegisterResendOtpApi {
  static final RegisterResendOtpApi _singleton = RegisterResendOtpApi._internal();
  RegisterResendOtpApi._internal();
  static RegisterResendOtpApi get instance => _singleton;

  Future<ResendRegisterOtpModel> resendRegisterOtpApi({
    required String email,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.resendOtp(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = ResendRegisterOtpModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
