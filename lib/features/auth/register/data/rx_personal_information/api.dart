// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:saam/features/auth/presentation/register/model/register_property_info_model.dart';
// import 'package:saam/helpers/toast.dart';
// import 'package:saam/networks/dio/dio.dart';
// import 'package:saam/networks/endpoints.dart';
// import 'package:saam/networks/exception_handler/data_source.dart';

// final class RegisterPropertyInfoApi {
//   static final RegisterPropertyInfoApi _singleton =
//       RegisterPropertyInfoApi._internal();
//   RegisterPropertyInfoApi._internal();
//   static RegisterPropertyInfoApi get instance => _singleton;

//   Future<RegisterPropertyInfoModel> registerPropertyInfoApi({
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
//       Map<String, dynamic> formDataMap = {
//         "role": role,
//         "phone": phone,
//         "name": name,
//         "email": email,
//         "password": password,
//         "password_confirmation": passwordConfirmation,
//       };

//       if (address != null && address.isNotEmpty) {
//         formDataMap["address"] = address;
//       }

//       if (avatar != null) {
//         if (kDebugMode) {
//           print("Attaching avatar: ${avatar.path}");
//         }
//         formDataMap["avatar"] = await MultipartFile.fromFile(
//           avatar.path,
//           filename: avatar.name,
//           contentType:
//               MediaType("image", "jpeg"), // Adjust based on extension if needed
//         );
//       }

//       FormData data = FormData.fromMap(formDataMap);

//       Response response =
//           await postHttp(Endpoints.registerPropertyInfo(), data);

//       if (response.statusCode == 200) {
//         final data =
//             RegisterPropertyInfoModel.fromRawJson(json.encode(response.data));
//         ToastUtil.showShortToast(
//             data.message ?? "Personal info registered successfully.");
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
