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

  Future<OpportunityListModel> getOpportunities({
    int page = 1,
    int perPage = 15,
    Map<String, dynamic>? filters,
  }) async {
    try {
      String queryString = "page=$page&per_page=$perPage";
      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null) {
            queryString += "&$key=$value";
          }
        });
      }
      Response response = await getHttp(
        "${Endpoints.opportunitiesList()}?$queryString",
      );

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
