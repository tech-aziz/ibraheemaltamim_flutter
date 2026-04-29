import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_get_notification/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/get_all_notification_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class GetAllNotificationListRx extends RxResponseInt<GetAllNotificationListModel> {
  final api = GetAllNotificationListApi.instance;

  GetAllNotificationListRx({required super.empty, required super.dataFetcher});

  ValueStream<GetAllNotificationListModel> get getFileData => dataFetcher.stream;

  Future<GetAllNotificationListModel?> fetchNotifications() async {
    try {
      final data = await api.getNotifications();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    }
  }

  void deleteNotificationLocally(String id) {
    if (dataFetcher.hasValue) {
      final currentData = dataFetcher.value;
      final updatedList =
          currentData.data?.where((item) => item.id != id).toList();
      dataFetcher.sink.add(currentData.copyWith(data: updatedList));
    }
  }

  void clearAll() {
    if (dataFetcher.hasValue) {
      final currentData = dataFetcher.value;
      dataFetcher.sink.add(currentData.copyWith(data: []));
    }
  }

  void markAsReadLocally(List<String> ids) {
    if (dataFetcher.hasValue) {
      final currentData = dataFetcher.value;
      final updatedList = currentData.data?.map((item) {
        if (ids.contains(item.id)) {
          return item.copyWith(readAt: DateTime.now());
        }
        return item;
      }).toList();
      dataFetcher.sink.add(currentData.copyWith(data: updatedList));
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
