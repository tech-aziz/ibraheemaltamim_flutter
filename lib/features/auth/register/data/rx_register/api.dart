// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:saam/features/auth/presentation/register/model/register_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/dio/dio.dart';
// import 'package:saam/networks/exception_handler/data_source.dart';
// import '/networks/endpoints.dart';

// final class RegisterApi {
//   static final RegisterApi _singleton = RegisterApi._internal();
//   RegisterApi._internal();
//   static RegisterApi get instance => _singleton;

//   Future<RegisterModel> registerApi({
//     required String phone,
//     String? role,
//   }) async {
//     try {
//       Map<String, dynamic> formDataMap = {
//         "phone": phone,
//       };

//       // Add role if provided
//       if (role != null && role.isNotEmpty) {
//         formDataMap["role"] = role;
//       }

//       FormData data = FormData.fromMap(formDataMap);

//       Response response = await postHttp(Endpoints.register(), data);

//       if (response.statusCode == 201) {
//         final data = RegisterModel.fromRawJson(json.encode(response.data));
//         ToastUtil.showShortToast(response.data['message']);
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
