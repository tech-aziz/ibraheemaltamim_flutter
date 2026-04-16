import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class UserInfoApi {
  static final UserInfoApi _singleton = UserInfoApi._internal();
  UserInfoApi._internal();
  static UserInfoApi get instance => _singleton;

  Future<UserInfoModel> userInfoApi() async {
    try {
      Response response = await getHttp(Endpoints.getProfile());

      if (response.statusCode == 200) {
        final data = UserInfoModel.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
