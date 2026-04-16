import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_delete_account/rx_delete_account/api.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:ibraheemaltamim_flutter/networks/stream_cleaner.dart';

final class DeleteAccountRx extends RxResponseInt<Map> {
  final api = DeleteAccountApi.instance;
  ValueStream get deleteAcccountSrteam => dataFetcher.stream;

  DeleteAccountRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<Map?> delete() async {
    isLoading.value = true;
    try {
      final data = await api.delete();
      handleSuccessWithReturn(data);
      log("Data ====> $data");
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
    if (data['message'] != null) {
      ToastUtil.showShortToast(data['message']);
    }
    appData.write(kKeyIsLoggedIn, false);
    totalDataClean();
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 422) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showShortToast(errorMessage);
      } else if (error.response!.statusCode == 404) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";

        ToastUtil.showShortToast(errorMessage);
      } else if (error.response!.statusCode == 401) {
        ToastUtil.showShortToast("Unauthenticate Login again.");
        await appData.write(kKeyIsLoggedIn, false);
        totalDataClean();
        NavigationService.popAndReplace(Routes.loginScreen);
      } else {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showShortToast(errorMessage);
      }
    } else {
      log("Error ====> $error");
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    throw error;
  }
}
