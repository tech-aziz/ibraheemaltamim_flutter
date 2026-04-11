import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/auth/register/model/register_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class RegisterApi {
  static final RegisterApi _singleton = RegisterApi._internal();
  RegisterApi._internal();
  static RegisterApi get instance => _singleton;

  Future<RegisterModel> registerApi({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Map<String, dynamic> formDataMap = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "role": "researcher",
      };

      FormData data = FormData.fromMap(formDataMap);

      Response response = await postHttp(Endpoints.register(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = RegisterModel.fromRawJson(json.encode(response.data));
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
