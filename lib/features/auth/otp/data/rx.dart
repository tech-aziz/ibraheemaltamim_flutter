import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/model/verify_register_otp_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class VerifyRegisterOtpRx extends RxResponseInt<VerifyRegisterOtpModel> {
  final api = VerifyRegisterOtpApi.instance;

  VerifyRegisterOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<VerifyRegisterOtpModel?> verifyRegisterOtpRx({
    required String email,
    required String otp,
  }) async {
    try {
      final data = await api.verifyRegisterOtpApi(email: email, otp: otp);
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
