import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/service/model/service_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ServiceApi {
  static final ServiceApi _singleton = ServiceApi._internal();
  ServiceApi._internal();
  static ServiceApi get instance => _singleton;

  Future<ServiceModel> getServices({int perPage = 10, int page = 1}) async {
    try {
      Response response = await getHttp("${Endpoints.services()}?per_page=$perPage&page=$page");

      if (response.statusCode == 200) {
        final data = ServiceModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
