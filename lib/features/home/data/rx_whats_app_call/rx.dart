import 'package:rxdart/rxdart.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/whats_app_call_model.dart';
import 'package:ibraheemaltamim_flutter/networks/rx_base.dart';
import 'api.dart';

final class WhatsAppCallRx extends RxResponseInt<WhatsAppCallModel> {
  final api = WhatsAppCallApi.instance;

  WhatsAppCallRx({required super.empty, required super.dataFetcher});

  ValueStream<WhatsAppCallModel> get getFileData => dataFetcher.stream;

  Future<void> fetchWhatsAppCall() async {
    try {
      final data = await api.fetchWhatsAppCall();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
