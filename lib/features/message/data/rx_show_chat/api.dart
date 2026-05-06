import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_show_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ChatShowApi {
  static final ChatShowApi _singleton = ChatShowApi._internal();
  ChatShowApi._internal();
  static ChatShowApi get instance => _singleton;

  Future<ChatShowModel> fetchChatShow({required String chatId}) async {
    try {
      Response response = await getHttp(Endpoints.chatListDetails(chatId));

      if (response.statusCode == 200) {
        final data = ChatShowModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
