import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/resend_otp_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class ResendOtpRx extends RxResponseInt<ResendOtpModel> {
  final api = ResendOtpApi.instance;

  ResendOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<ResendOtpModel?> resendOtpRx({
    required String email,
  }) async {
    try {
      final data = await api.resendOtpApi(email: email);
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
      } else {
         ToastUtil.showShortToast(error.message ?? "An error occurred");
      }
    } else {
       ToastUtil.showShortToast(error.toString());
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}
