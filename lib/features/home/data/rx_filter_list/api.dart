import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/filter_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class FilterListApi {
  static final FilterListApi _singleton = FilterListApi._internal();
  FilterListApi._internal();
  static FilterListApi get instance => _singleton;

  Future<FilterListModel> fetchFilterList(String type) async {
    try {
      Response response = await postHttp(Endpoints.filterList(), {'type': type});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        final data = FilterListModel.fromJson(responseData);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
