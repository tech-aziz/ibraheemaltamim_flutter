import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/mentor_details_model.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/networks/exception_handler/data_source.dart';

final class MentorDetailsApi {
  static final MentorDetailsApi _singleton = MentorDetailsApi._internal();
  MentorDetailsApi._internal();
  static MentorDetailsApi get instance => _singleton;

  Future<MentorDetailsModel> fetchMentorDetails(String mentorId) async {
    try {
      Response response = await getHttp(Endpoints.mentorsDetails(mentorId));

      if (response.statusCode == 200) {
        final data = MentorDetailsModel.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
