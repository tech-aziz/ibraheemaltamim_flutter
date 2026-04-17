import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class WishlistApi {
  static final WishlistApi _singleton = WishlistApi._internal();
  WishlistApi._internal();
  static WishlistApi get instance => _singleton;

  Future<WishListModel> getWishlist() async {
    try {
      Response response = await getHttp(Endpoints.favourites());

      if (response.statusCode == 200) {
        final data = WishListModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
