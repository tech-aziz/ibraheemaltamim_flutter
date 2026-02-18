// import 'dart:convert';

// class LoginModel {
//   bool? status;
//   String? message;
//   int? code;
//   String? role;
//   String? tokenType;
//   String? token;
//   Data? data;

//   LoginModel({
//     this.status,
//     this.message,
//     this.code,
//     this.role,
//     this.tokenType,
//     this.token,
//     this.data,
//   });

//   factory LoginModel.fromRawJson(String str) =>
//       LoginModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         status: json["status"],
//         message: json["message"],
//         code: json["code"],
//         role: json["role"],
//         tokenType: json["token_type"],
//         token: json["token"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "code": code,
//         "role": role,
//         "token_type": tokenType,
//         "token": token,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   int? id;
//   String? name;
//   String? phone;
//   String? email;
//   String? role;

//   Data({
//     this.id,
//     this.name,
//     this.phone,
//     this.email,
//     this.role,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         name: json["name"],
//         phone: json["phone"],
//         email: json["email"],
//         role: json["role"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone": phone,
//         "email": email,
//         "role": role,
//       };
// }
