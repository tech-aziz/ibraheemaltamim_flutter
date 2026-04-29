import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/mark_as_read_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class MarkAsReadApi {
  static final MarkAsReadApi _singleton = MarkAsReadApi._internal();
  MarkAsReadApi._internal();
  static MarkAsReadApi get instance => _singleton;

  Future<MarkAsReadModel> markAsRead(List<String> notificationIds) async {
    try {
      Response response = await postHttp(
        Endpoints.markAsReadNotifications(),
        {
          "notification_ids": notificationIds,
        },
      );

      if (response.statusCode == 200) {
        final data = MarkAsReadModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
