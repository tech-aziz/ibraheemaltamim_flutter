import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/service/data/api.dart';
import 'package:ibraheemaltamim_flutter/features/service/model/service_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class ServiceRx extends RxResponseInt<ServiceModel> {
  final api = ServiceApi.instance;

  ServiceRx({required super.empty, required super.dataFetcher});

  ValueStream<ServiceModel> get getFileData => dataFetcher.stream;

  Future<ServiceModel?> fetchServices({int perPage = 10, int page = 1}) async {
    try {
      final data = await api.getServices(perPage: perPage, page: page);
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

final getServicesRx = ServiceRx(
  empty: ServiceModel(),
  dataFetcher: BehaviorSubject<ServiceModel>(),
);
