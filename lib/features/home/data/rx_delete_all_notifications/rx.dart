import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_delete_all_notifications/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/delete_single_notification_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class DeleteAllNotificationsRx
    extends RxResponseInt<DeleteSingleNotificationModel> {
  final api = DeleteAllNotificationsApi.instance;

  DeleteAllNotificationsRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream<DeleteSingleNotificationModel> get getFileData =>
      dataFetcher.stream;

  Future<DeleteSingleNotificationModel?> deleteAll() async {
    try {
      final data = await api.deleteAll();
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
