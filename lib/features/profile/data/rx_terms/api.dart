import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/privacy_policy_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class TermsAndConditionsApi {
  static final TermsAndConditionsApi _singleton =
      TermsAndConditionsApi._internal();
  TermsAndConditionsApi._internal();
  static TermsAndConditionsApi get instance => _singleton;

  Future<PrivacyPolicyModel> fetchTerms() async {
    try {
      Response response = await getHttp(Endpoints.termsAndConditions());
      if (response.statusCode == 200) {
        return PrivacyPolicyModel.fromJson(response.data);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
