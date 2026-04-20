import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/mentor_details_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class MentorDetailsRx extends RxResponseInt<MentorDetailsModel> {
  final api = MentorDetailsApi.instance;

  MentorDetailsRx({required super.empty, required super.dataFetcher});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueStream get getFileData => dataFetcher.stream;

  Future<MentorDetailsModel?> fetchMentorDetails(String mentorId) async {
    isLoading.value = true;
    try {
      final data = await api.fetchMentorDetails(mentorId);
      handleSuccessWithReturn(data);
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
      if (error.response?.data is Map) {
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
