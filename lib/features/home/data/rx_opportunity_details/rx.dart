import 'dart:developer';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_details/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class OpportunityDetailsRx extends RxResponseInt<OpportunityDetailsModel> {
  final api = OpportunityDetailsApi.instance;

  OpportunityDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream<OpportunityDetailsModel> get getFileData => dataFetcher.stream;

  Future<void> fetchDetails(String opportunityId) async {
    try {
      final data = await api.fetchDetails(opportunityId);
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}

final getOpportunityDetailsRx = OpportunityDetailsRx(
  empty: OpportunityDetailsModel(),
  dataFetcher: BehaviorSubject<OpportunityDetailsModel>(),
);
