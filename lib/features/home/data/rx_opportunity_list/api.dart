import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class OpportunityListApi {
  static final OpportunityListApi _singleton = OpportunityListApi._internal();
  OpportunityListApi._internal();
  static OpportunityListApi get instance => _singleton;

  Future<OpportunityListModel> getOpportunities({int page = 1, int perPage = 15}) async {
    try {
      Response response = await getHttp("${Endpoints.opportunitiesList()}?page=$page&per_page=$perPage");

      if (response.statusCode == 200) {
        final data = OpportunityListModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
