// // ignore_for_file: use_build_context_synchronously
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:saam/features/auth/presentation/register/model/register_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/rx_base.dart';
// import 'api.dart';

// final class RegisterRx extends RxResponseInt<RegisterModel> {
//   final api = RegisterApi.instance;

//   RegisterRx({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> registerRx({
//     required String phone,
//     String? role,
//   }) async {
//     try {
//       final data = await api.registerApi(phone: phone, role: role);

//       handleSuccessWithReturn(data);
//       return true;
//     } catch (error) {
//       handleErrorWithReturn(error);
//       rethrow;
//     }
//   }

//   @override
//   handleErrorWithReturn(dynamic error) {
//     if (error is DioException) {
//       final statusCode = error.response?.statusCode;
//       final responseData = error.response?.data;
//       if (statusCode == 422 && responseData is Map<String, dynamic>) {
//         // 1. Try to show the top-level message first (User preference)
//         if (responseData['message'] != null) {
//           ToastUtil.showShortToast(responseData['message']);
//         }

//         // 2. Or iterate through field-specific errors if needed
//         final errorMap =
//             responseData['errors']; // Corrected key from 'error' to 'errors'
//         if (errorMap is Map<String, dynamic>) {
//           for (var field in errorMap.entries) {
//             final messages = field.value;
//             if (messages is List && messages.isNotEmpty) {
//               // If we haven't shown the top-level message, or want to show specific details:
//               // ToastUtil.showShortToast(messages[0]);
//               // (keeping this optional/commented if top-level message is sufficient)
//             }
//           }
//         }
//       }
//     }
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//   }
// }
