import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/add_favourite_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class AddFavouriteApi {
  static final AddFavouriteApi _singleton = AddFavouriteApi._internal();
  AddFavouriteApi._internal();
  static AddFavouriteApi get instance => _singleton;

  Future<AddFavouriteModel> addFavourite(int opportunityId) async {
    try {
      Map<String, dynamic> body = {
        "opportunity_id": opportunityId,
      };
      
      Response response = await postHttp(Endpoints.addFavourites(), body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = AddFavouriteModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
