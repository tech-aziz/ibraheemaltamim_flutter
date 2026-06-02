import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../../constants/app_constants.dart';
import '../../helpers/all_routes.dart';
import '../../helpers/di.dart';
import '../../helpers/navigation_service.dart';
import '../exception_handler/data_source.dart';
import '../stream_cleaner.dart';
import 'dio.dart';

final class Logger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("= = = Dio Request = = =");
    log("${options.headers}");
    log("${options.data}");
    log("${options.contentType}");
    log("${options.extra}");
    log("${options.baseUrl}${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("= = = Dio Success Response = = =");
    log(json.encode(response.data));
    log("${response.requestOptions}");
    log("${response.statusCode}");
    log("${response.statusMessage}");
    log("${response.headers}");
    log("${response.extra}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log("= = = Dio Error Response = = =");
      log('Error Response: ${err.response}');
      log('Error Message: ${err.message}');
      log('Error Type: ${err.type}');
      log('Error: ${err.error}');
      log('Error Req option: ${err.requestOptions}');
    }

    // Check for unauthenticated error response (token expired or unauthorized)
    bool isUnauthenticated = false;
    if (err.response != null) {
      if (err.response?.statusCode == 401) {
        isUnauthenticated = true;
      } else if (err.response?.data != null) {
        final data = err.response?.data;
        if (data is Map && data['message'] == 'Unauthenticated.') {
          isUnauthenticated = true;
        } else if (data is String && data.contains('Unauthenticated.')) {
          isUnauthenticated = true;
        }
      }
    }

    if (isUnauthenticated) {
      _handleSessionExpired();
    }

    ErrorHandler.handle(err).failure;
    return super.onError(err, handler);
  }

  void _handleSessionExpired() async {
    final token = appData.read(kKeyAccessToken);
    if (token != null && token.toString().isNotEmpty) {
      await totalDataClean();
      appData.remove(kKeyAccessToken);
      appData.remove(kKeyUserRole);
      DioSingleton.instance.update('');
      if (NavigationService.navigatorKey.currentState != null) {
        NavigationService.navigateToUntilReplacement(Routes.loginScreen);
      }
    }
  }
}

