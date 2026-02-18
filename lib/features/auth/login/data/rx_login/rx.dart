// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:saam/features/auth/presentation/login/model/login_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/rx_base.dart';
// import 'api.dart';

// final class LoginRx extends RxResponseInt<LoginModel> {
//   final api = LoginApi.instance;

//   LoginRx({required super.empty, required super.dataFetcher});

//   ValueStream get getFileData => dataFetcher.stream;

//   Future<LoginModel?> loginRx({
//     required String phone,
//     required String password,
//   }) async {
//     try {
//       final data = await api.loginApi(
//         phone: phone,
//         password: password,
//       );

//       handleSuccessWithReturn(data);
//       return data;
//     } catch (error) {
//       handleErrorWithReturn(error);
//       return null;
//     }
//   }

//   @override
//   handleErrorWithReturn(dynamic error) {
//     if (error is DioException) {
//       final statusCode = error.response?.statusCode;
//       final responseData = error.response?.data;
//       if ((statusCode == 422 || statusCode == 401) &&
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
