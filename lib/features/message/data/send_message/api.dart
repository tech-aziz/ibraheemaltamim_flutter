import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
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
        final fileExtension = file.path.split('.').last;
        log('==== SENDING VOICE/FILE ====');
        log('File path: ${file.path}');
        log('File extension: $fileExtension');
        log('============================');
        MediaType? mediaType;
        if ([
          'mp3',
          'wav',
          'ogg',
          'm4a',
          'aac',
          'webm',
        ].contains(fileExtension.toLowerCase())) {
          mediaType = MediaType(
            'audio',
            fileExtension.toLowerCase() == 'm4a'
                ? 'mp4'
                : fileExtension.toLowerCase(),
          );
        }
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
              contentType: mediaType,
            ),
          ),
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
