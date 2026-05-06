import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class ChatListApi {
  static final ChatListApi _singleton = ChatListApi._internal();
  ChatListApi._internal();
  static ChatListApi get instance => _singleton;

  Future<ChatListModel> fetchChatList() async {
    try {
      Response response = await getHttp(Endpoints.chatList());

      if (response.statusCode == 200) {
        final data = ChatListModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
