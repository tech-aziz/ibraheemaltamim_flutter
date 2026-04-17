import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/delete_favourite_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class RemoveFavouriteApi {
  static final RemoveFavouriteApi _singleton = RemoveFavouriteApi._internal();
  RemoveFavouriteApi._internal();
  static RemoveFavouriteApi get instance => _singleton;

  Future<DeleteFavouriteModel> deleteFavourite(String favouriteId) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteFavourites(favouriteId));

      if (response.statusCode == 200) {
        final data = DeleteFavouriteModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
