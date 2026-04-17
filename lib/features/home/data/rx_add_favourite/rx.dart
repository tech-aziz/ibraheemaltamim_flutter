import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_add_favourite/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/add_favourite_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class AddFavouriteRx extends RxResponseInt<AddFavouriteModel> {
  final api = AddFavouriteApi.instance;

  AddFavouriteRx({required super.empty, required super.dataFetcher});

  ValueStream<AddFavouriteModel> get getFileData => dataFetcher.stream;

  Future<AddFavouriteModel?> addFavourite(int opportunityId) async {
    try {
      final data = await api.addFavourite(opportunityId);
      handleSuccessWithReturn(data);

      if (data.status == true) {
        ToastUtil.showShortToast(data.message ?? "Added to favourites.");
        // Refresh wishlist instantly to sync counts/badges
        getWishlistRx.fetchWishlist();
      }

      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;
      if ((statusCode == 422 || statusCode == 401 || statusCode == 400) &&
          responseData is Map<String, dynamic>) {
        if (responseData['message'] != null) {
          ToastUtil.showShortToast(responseData['message']);
        }
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}

final addFavouriteRx = AddFavouriteRx(
  empty: AddFavouriteModel(),
  dataFetcher: BehaviorSubject<AddFavouriteModel>(),
);
