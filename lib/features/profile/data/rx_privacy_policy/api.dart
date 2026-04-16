
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/privacy_policy_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class PrivacyPolicyApi {
  static final PrivacyPolicyApi _singleton = PrivacyPolicyApi._internal();
  PrivacyPolicyApi._internal();
  static PrivacyPolicyApi get instance => _singleton;

  Future<PrivacyPolicyModel> fetchPrivacyPolicy() async {
    try {
      Response response = await getHttp(Endpoints.privacyPolicy());
      if (response.statusCode == 200) {
        final json = response.data;
        return PrivacyPolicyModel.fromJson(json);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
