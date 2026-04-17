import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';

final class OpportunityDetailsApi {
  OpportunityDetailsApi._();
  static final instance = OpportunityDetailsApi._();

  Future<OpportunityDetailsModel> fetchDetails(String opportunityId) async {
    try {
      Response response = await getHttp(Endpoints.opportunityDetails(opportunityId));
      if (response.statusCode == 200) {
        return OpportunityDetailsModel.fromJson(response.data);
      } else {
        return OpportunityDetailsModel(
          status: false,
          message: response.statusMessage,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
