import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';
import '/networks/dio/dio.dart';
import '/networks/endpoints.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();
  UpdateProfileApi._internal();
  static UpdateProfileApi get instance => _singleton;

  Future<Map> updateProfile({
    required String name,
    String? gender,
    String? birthdate,
    File? avatar,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "gender": gender ?? "male",
        "birthdate": birthdate,
      });

      if (avatar != null && await File(avatar.path).exists()) {
        data.files.add(
          MapEntry('avatar', await MultipartFile.fromFile(avatar.path)),
        );
      }

      Response response = await postHttp(Endpoints.updateProfile(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));

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
