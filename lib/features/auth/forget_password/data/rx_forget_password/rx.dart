// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:saam/features/auth/presentation/forget_password/model/forget_password_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/rx_base.dart';
// import 'api.dart';

// final class ForgetPasswordRx extends RxResponseInt<ForgetPasswordModel> {
//   final api = ForgetPasswordApi.instance;

//   ForgetPasswordRx({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   Future<bool> forgetPasswordRx({
//     required String phone,
//   }) async {
//     try {
//       final data = await api.forgetPasswordApi(
//         phone: phone,
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
//       if ((statusCode == 422 || statusCode == 401 || statusCode == 400) &&
//           responseData is Map<String, dynamic>) {
//         if (responseData['message'] != null) {
//           ToastUtil.showShortToast(responseData['message']);
//         }
//       }
//     }
//     log(error.toString());
//     dataFetcher.sink.addError(error);
//   }
// }
