// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:saam/features/auth/presentation/login/model/login_model.dart';
// import 'package:saam/helpers/di.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/dio/dio.dart';
// import 'package:saam/networks/endpoints.dart';
// import 'package:saam/networks/exception_handler/data_source.dart';
// import 'package:saam/constants/app_constants.dart';

// final class LoginApi {
//   static final LoginApi _singleton = LoginApi._internal();
//   LoginApi._internal();
//   static LoginApi get instance => _singleton;

//   Future<LoginModel> loginApi({
//     required String phone,
//     required String password,
//   }) async {
//     try {
//       Map<String, dynamic> formDataMap = {
//         "phone": phone,
//         "password": password,
//       };

//       FormData data = FormData.fromMap(formDataMap);

//       Response response = await postHttp(Endpoints.login(), data);

//       if (response.statusCode == 200) {
//         final data = LoginModel.fromRawJson(json.encode(response.data));
//         // Save token and login state
//         if (data.token != null) {
//           appData.write(kKeyIsLoggedIn, true);
//           appData.write(kKeyAccessToken, data.token);
//           if (data.role != null) {
//             appData.write(kKeyUserRole, data.role);
//           }
//         }
//         ToastUtil.showShortToast(data.message ?? "Logged in successfully.");
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       // Handle generic errors
//       rethrow;
//     }
//   }
// }
