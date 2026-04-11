import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/forget_password/model/forget_password_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ForgetPasswordApi {
  static final ForgetPasswordApi _singleton = ForgetPasswordApi._internal();
  ForgetPasswordApi._internal();
  static ForgetPasswordApi get instance => _singleton;

  Future<ForgetPasswordModel> forgetPasswordApi({
    required String email,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.forgetPassword(), data);

      if (response.statusCode == 200) {
        final data =
            ForgetPasswordModel.fromRawJson(json.encode(response.data));
        ToastUtil.showShortToast(data.message ?? "OTP Code Sent Successfully");
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
