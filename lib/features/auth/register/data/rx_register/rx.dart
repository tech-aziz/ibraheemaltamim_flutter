import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/auth/register/model/register_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class RegisterRx extends RxResponseInt<RegisterModel> {
  final api = RegisterApi.instance;

  RegisterRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<RegisterModel?> registerRx({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final data = await api.registerApi(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
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
      if ((statusCode == 422 || statusCode == 401) &&
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
