import 'dart:developer';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_favourite_details/api.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

final class FavouriteDetailsRx extends RxResponseInt<OpportunityDetailsModel> {
  final api = FavouriteDetailsApi.instance;

  FavouriteDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream<OpportunityDetailsModel> get getFileData => dataFetcher.stream;

  Future<void> fetchDetails(String favouriteId) async {
    try {
      final data = await api.fetchDetails(favouriteId);
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

final getFavouriteDetailsRx = FavouriteDetailsRx(
  empty: OpportunityDetailsModel(),
  dataFetcher: BehaviorSubject<OpportunityDetailsModel>(),
);
