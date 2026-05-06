import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/send_message_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class SendMessageRx extends RxResponseInt<SendMessageModel> {
  final api = SendMessageApi.instance;

  SendMessageRx({required super.empty, required super.dataFetcher});

  ValueStream<SendMessageModel> get getFileData => dataFetcher.stream;

  Future<SendMessageModel?> sendMessage({
    required String chatId,
    String? message,
    File? file,
  }) async {
    try {
      final data = await api.sendMessage(
        chatId: chatId,
        message: message,
        file: file,
      );
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
