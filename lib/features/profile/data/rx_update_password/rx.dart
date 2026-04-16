import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_update_password/api.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class UpdatePasswordRx extends RxResponseInt<Map> {
  final api = UpdatePasswordApi.instance;
  ValueStream get updatePasswordStream => dataFetcher.stream;

  UpdatePasswordRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<Map?> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    isLoading.value = true;
    try {
      final data = await api.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      handleSuccessWithReturn(data);
      if (data['message'] != null) {
        ToastUtil.showShortToast(data['message']);
      }
      return data;
    } catch (e) {
      handleErrorWithReturn(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      if (error.response != null && (error.response!.statusCode == 422 || error.response!.statusCode == 400)) {
        final errorData = error.response!.data;
        final errorMessage = errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showShortToast(errorMessage);
      } else {
        final errorData = error.response?.data;
        final errorMessage = errorData?['message'] ?? "An unknown error occurred";
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      log("Error ====> $error");
    }
    dataFetcher.sink.addError(error);
  }
}
