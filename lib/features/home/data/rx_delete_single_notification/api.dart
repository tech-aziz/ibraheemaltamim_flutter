import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/delete_single_notification_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class DeleteSingleNotificationApi {
  static final DeleteSingleNotificationApi _singleton = DeleteSingleNotificationApi._internal();
  DeleteSingleNotificationApi._internal();
  static DeleteSingleNotificationApi get instance => _singleton;

  Future<DeleteSingleNotificationModel> deleteNotification(String id) async {
    try {
      Response response = await deleteHttp(
        Endpoints.deleteNotifications(id),
      );

      if (response.statusCode == 200) {
        final data = DeleteSingleNotificationModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
