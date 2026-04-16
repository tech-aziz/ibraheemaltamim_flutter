import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class UserInfoRx extends RxResponseInt<UserInfoModel> {
  final api = UserInfoApi.instance;

  UserInfoRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream get getFileData => dataFetcher.stream;

  Future<UserInfoModel?> fetchUserInfo() async {
    isLoading.value = true;
    try {
      final data = await api.userInfoApi();

      handleSuccessWithReturn(data);
      if (data.data != null) {
        if (data.data!.name != null) appData.write(kKeyName, data.data!.name);
        if (data.data!.email != null) appData.write(kKeyEmail, data.data!.email);
        if (data.data!.avatar != null) appData.write(kKeyAvatar, data.data!.avatar);
      }

      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        // handle 401 maybe?
      } else if (error.response?.data is Map) {
        final errorData = error.response?.data;
        if (errorData['message'] != null) {
          ToastUtil.showShortToast(errorData['message']);
        }
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}
