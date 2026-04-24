import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';

final class FavouriteDetailsApi {
  FavouriteDetailsApi._();
  static final instance = FavouriteDetailsApi._();

  Future<OpportunityDetailsModel> fetchDetails(String favouriteId) async {
    try {
      Response response = await getHttp(Endpoints.favouritesDetails(favouriteId));
      if (response.statusCode == 200) {
        var responseData = response.data;
        // Check if the data is nested inside 'favouriteable'
        if (responseData != null &&
            responseData['data'] != null &&
            responseData['data']['favouriteable'] != null) {
          var favouriteable = responseData['data']['favouriteable'];
          // Also try to get the mentor from the parent if available, or keep it in the mapped data
          var mappedData = {
            "status": responseData['status'],
            "message": responseData['message'],
            "code": responseData['code'],
            "data": favouriteable
          };
          return OpportunityDetailsModel.fromJson(mappedData);
        }
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
