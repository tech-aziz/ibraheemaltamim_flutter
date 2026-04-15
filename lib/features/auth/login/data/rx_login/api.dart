import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/features/auth/login/model/login_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class LoginApi {
  static final LoginApi _singleton = LoginApi._internal();
  LoginApi._internal();
  static LoginApi get instance => _singleton;

  Future<LoginModel> loginApi({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "email": email,
        "password": password,
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.login(), data);

      if (response.statusCode == 200) {
        final data = LoginModel.fromRawJson(json.encode(response.data));
        if (data.token != null) {
          appData.write(kKeyIsLoggedIn, true);
          appData.write(kKeyAccessToken, data.token);
          if (data.data?.role != null) {
            appData.write(kKeyUserRole, data.data!.role);
          }
          DioSingleton.instance.update(data.token!);
        }
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
