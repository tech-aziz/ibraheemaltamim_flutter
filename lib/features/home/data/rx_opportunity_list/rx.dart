import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_list/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';

final class OpportunityListRx extends RxResponseInt<OpportunityListModel> {
  final api = OpportunityListApi.instance;
  List<Datum> _allData = [];
  int _currentPage = 1;
  bool _isFetching = false;

  OpportunityListRx({required super.empty, required super.dataFetcher});

  ValueStream<OpportunityListModel> get getFileData => dataFetcher.stream;
  bool get hasMoreData => _allData.length < (dataFetcher.value.pagination?.total ?? 0);

  Future<OpportunityListModel?> fetchOpportunities({int perPage = 15, bool isRefresh = true}) async {
    if (_isFetching) return null;
    _isFetching = true;

    if (isRefresh) {
      _currentPage = 1;
      _allData.clear();
    }

    try {
      final data = await api.getOpportunities(page: _currentPage, perPage: perPage);
      handleSuccessWithReturn(data);
      
      if (data.data != null) {
        if (isRefresh) {
          _allData = List.from(data.data!);
        } else {
          _allData.addAll(data.data!);
        }
        
        // Update the stream with the accumulated list
        final updatedModel = data.copyWith(data: _allData);
        dataFetcher.sink.add(updatedModel);
        
        if (data.pagination?.lastPage != null && _currentPage < data.pagination!.lastPage!) {
          _currentPage++;
        }
      }
      _isFetching = false;
      return data;
    } catch (error) {
      _isFetching = false;
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

final getOpportunitiesRx = OpportunityListRx(
  empty: OpportunityListModel(),
  dataFetcher: BehaviorSubject<OpportunityListModel>(),
);
