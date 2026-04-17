import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_remove_favourite/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/delete_favourite_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class RemoveFavouriteRx extends RxResponseInt<DeleteFavouriteModel> {
  final api = RemoveFavouriteApi.instance;

  RemoveFavouriteRx({required super.empty, required super.dataFetcher});

  ValueStream<DeleteFavouriteModel> get getFileData => dataFetcher.stream;

  Future<bool> deleteFavourite(String favouriteId) async {
    try {
      final data = await api.deleteFavourite(favouriteId);
      handleSuccessWithReturn(data);
      if (data.status == true) {
        ToastUtil.showShortToast('Removed from favourites');
        // Refresh wishlist instantly to sync counts/badges
        getWishlistRx.fetchWishlist();
      } else if (data.message != null && data.message!.isNotEmpty) {
        ToastUtil.showShortToast(data.message!);
      }
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;
      if ((statusCode == 422 || statusCode == 401 || statusCode == 400 || statusCode == 404) &&
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

final removeFavouriteRx = RemoveFavouriteRx(
  empty: DeleteFavouriteModel(),
  dataFetcher: BehaviorSubject<DeleteFavouriteModel>(),
);
