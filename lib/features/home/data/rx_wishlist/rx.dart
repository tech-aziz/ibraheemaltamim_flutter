import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class WishlistRx extends RxResponseInt<WishListModel> {
  final api = WishlistApi.instance;

  WishlistRx({required super.empty, required super.dataFetcher});

  ValueStream<WishListModel> get getFileData => dataFetcher.stream;

  Future<WishListModel?> fetchWishlist() async {
    try {
      final data = await api.getWishlist();
      handleSuccessWithReturn(data);
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

final getWishlistRx = WishlistRx(
  empty: WishListModel(),
  dataFetcher: BehaviorSubject<WishListModel>(),
);
