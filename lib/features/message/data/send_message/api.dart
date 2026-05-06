import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/send_message_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class SendMessageApi {
  static final SendMessageApi _singleton = SendMessageApi._internal();
  SendMessageApi._internal();
  static SendMessageApi get instance => _singleton;

  Future<SendMessageModel> sendMessage({
    required String chatId,
    String? message,
    File? file,
  }) async {
    try {
      FormData formData = FormData();
      if (message != null && message.isNotEmpty) {
        formData.fields.add(MapEntry('message', message));
      }
      if (file != null && file.path.isNotEmpty) {
        formData.files.add(
          MapEntry('file', await MultipartFile.fromFile(file.path)),
        );
      }

      Response response = await postHttp(
        Endpoints.sendMessage(chatId),
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = SendMessageModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
