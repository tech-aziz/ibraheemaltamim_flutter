import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class LogOutApi {
  static final LogOutApi _singleton = LogOutApi._internal();
  LogOutApi._internal();
  static LogOutApi get instance => _singleton;

  Future<Map> logout() async {
    try {
      Response response = await postHttp(
        Endpoints.logout(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(json.encode(response.data));
        ToastUtil.showShortToast(data['message']);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
