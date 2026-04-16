import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class UpdateProfileRx extends RxResponseInt<Map> {
  final api = UpdateProfileApi.instance;

  UpdateProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> updateProfile({
    required String name,
    String? gender,
    String? birthdate,
    File? avatar,
  }) async {
    try {
      Map data = await api.updateProfile(
        name: name,
        gender: gender,
        birthdate: birthdate,
        avatar: avatar,
      );
      ToastUtil.showShortToast(data["message"]);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      // ToastUtil.showShortToast('Error occured');
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException && error.response != null) {
      final message = error.response!.data["message"];
      if (message is String) {
        ToastUtil.showShortToast(message);
        return false;
      }

      if (message is Map) {
        final errorMessage =
            message.values.whereType<List>().map((e) => e.first).join("\n");
        ToastUtil.showShortToast(errorMessage);
        return false;
      }
    }
    const defaultMessage = "Something went wrong";
    ToastUtil.showShortToast(defaultMessage);
    return false;
  }
}
