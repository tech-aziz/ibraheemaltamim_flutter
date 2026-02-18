// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:saam/features/auth/presentation/register/model/register_property_info_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/rx_base.dart';
// import 'api.dart';

// final class RegisterPropertyInfoRx
//     extends RxResponseInt<RegisterPropertyInfoModel> {
//   final api = RegisterPropertyInfoApi.instance;

//   RegisterPropertyInfoRx({required super.empty, required super.dataFetcher});
//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> registerPropertyInfoRx({
//     required String role,
//     required String phone,
//     required String name,
//     required String email,
//     required String password,
//     required String passwordConfirmation,
//     String? address,
//     XFile? avatar,
//   }) async {
//     try {
//       final data = await api.registerPropertyInfoApi(
//         role: role,
//         phone: phone,
//         name: name,
//         email: email,
//         password: password,
//         passwordConfirmation: passwordConfirmation,
//         address: address,
//         avatar: avatar,
//       );

//       handleSuccessWithReturn(data);
//       return true;
//     } catch (error) {
//       handleErrorWithReturn(error);
//       return false;
//     }
//   }

//   @override
//   handleErrorWithReturn(dynamic error) {
//     if (error is DioException) {
//       final statusCode = error.response?.statusCode;
//       final responseData = error.response?.data;
//       if (statusCode == 422 && responseData is Map<String, dynamic>) {
//         if (responseData['message'] != null) {
//           ToastUtil.showShortToast(responseData['message']);
//         }

//         final errorMap = responseData['errors'];
//         if (errorMap is Map<String, dynamic>) {
//           for (var field in errorMap.entries) {
//             final messages = field.value;
//             if (messages is List && messages.isNotEmpty) {
//               // ToastUtil.showShortToast(messages[0]);
//             }
//           }
//         }
//       }
//     }
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//   }
// }
