import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/set_new_password/model/set_new_password_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ResetPasswordApi {
  static final ResetPasswordApi _singleton = ResetPasswordApi._internal();
  ResetPasswordApi._internal();
  static ResetPasswordApi get instance => _singleton;

  Future<SetNewPasswordModel> resetPasswordApi({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
        "otp": otp,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.resetPassword(), data);

      if (response.statusCode == 200) {
        final data =
            SetNewPasswordModel.fromRawJson(json.encode(response.data));
        ToastUtil.showShortToast(data.message ?? "Password Reset Successfully");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
