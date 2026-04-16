import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/profile/data/rx_privacy_policy/api.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/privacy_policy_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class PrivacyPolicyRx extends RxResponseInt<PrivacyPolicyModel> {
  final api = PrivacyPolicyApi.instance;
  ValueStream<PrivacyPolicyModel> get privacyPolicyStream =>
      dataFetcher.stream;

  PrivacyPolicyRx({required super.empty, required super.dataFetcher});

  Future<void> fetchPrivacyPolicy() async {
    try {
      final data = await api.fetchPrivacyPolicy();
      handleSuccessWithReturn(data);
    } catch (e) {
      handleErrorWithReturn(e);
    }
  }

  @override
  void handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(error) async {
    if (error is DioException) {
      final errorData = error.response?.data;
      final errorMessage = errorData?['message'] ?? 'An unknown error occurred';
      ToastUtil.showShortToast(errorMessage);
    } else {
      log('Error ====> $error');
    }
    dataFetcher.sink.addError(error);
  }
}
