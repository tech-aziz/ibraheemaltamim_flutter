// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class LogOutRx extends RxResponseInt<Map> {
  final api = LogOutApi.instance;

  LogOutRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> logout() async {
    isLoading.value = true;
    try {
      Map data = await api.logout();
      handleSuccessWithReturn(data);
      return true;
      
    } catch (error) {
      return handleErrorWithReturn(error);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        ToastUtil.showShortToast(
          "Network error. Please check your connection.",
        );
        return false;
      }

      if (error.response != null) {
        // Check for 401 first to treat as success
        if (error.response!.statusCode == 401) {
          ToastUtil.showShortToast("Logged out successfully.");
          return true;
        }

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

        // Handle specific HTTP status codes
        switch (error.response!.statusCode) {
          case 400:
            ToastUtil.showShortToast(
              "Invalid input. Please check your details.",
            );
            break;
          case 409:
            ToastUtil.showShortToast(
              "User already exists with this email or phone.",
            );
            break;
          default:
            ToastUtil.showShortToast("Server error. Please try again later.");
        }
        return false;
      }
    }

    final defaultMessage = "An unexpected error occurred. Please try again.";
    ToastUtil.showShortToast(defaultMessage);
    return false;
  }
}
