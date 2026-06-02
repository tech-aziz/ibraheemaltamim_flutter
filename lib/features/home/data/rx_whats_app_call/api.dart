
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/whats_app_call_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class WhatsAppCallApi {
  static final WhatsAppCallApi _singleton = WhatsAppCallApi._internal();
  WhatsAppCallApi._internal();
  static WhatsAppCallApi get instance => _singleton;

  Future<WhatsAppCallModel> fetchWhatsAppCall() async {
    try {
      Response response = await getHttp(Endpoints.whatsAppNumberCall());
      if (response.statusCode == 200) {
        final data = WhatsAppCallModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
