import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_mark_as_read/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/mark_as_read_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class MarkAsReadRx extends RxResponseInt<MarkAsReadModel> {
  final api = MarkAsReadApi.instance;

  MarkAsReadRx({required super.empty, required super.dataFetcher});

  ValueStream<MarkAsReadModel> get getFileData => dataFetcher.stream;

  Future<MarkAsReadModel?> markAsRead(List<String> notificationIds) async {
    try {
      final data = await api.markAsRead(notificationIds);
      handleSuccessWithReturn(data);
      if (data.status == true) {
        ToastUtil.showShortToast(data.message ?? "Notifications marked as read");
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
