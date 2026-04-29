import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/get_all_notification_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class GetAllNotificationListApi {
  static final GetAllNotificationListApi _singleton = GetAllNotificationListApi._internal();
  GetAllNotificationListApi._internal();
  static GetAllNotificationListApi get instance => _singleton;

  Future<GetAllNotificationListModel> getNotifications() async {
    try {
      Response response = await getHttp(
        Endpoints.notificationsList(),
      );

      if (response.statusCode == 200) {
        final data = GetAllNotificationListModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
