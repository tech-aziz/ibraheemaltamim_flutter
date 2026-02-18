import 'dart:convert';

class RegisterPropertyInfoModel {
  bool? status;
  String? message;
  int? code;
  String? role;
  String? tokenType;
  String? token;
  Data? data;

  RegisterPropertyInfoModel({
    this.status,
    this.message,
    this.code,
    this.role,
    this.tokenType,
    this.token,
    this.data,
  });

  factory RegisterPropertyInfoModel.fromRawJson(String str) =>
      RegisterPropertyInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterPropertyInfoModel.fromJson(Map<String, dynamic> json) =>
      RegisterPropertyInfoModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        role: json["role"],
        tokenType: json["token_type"],
        token: json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "role": role,
        "token_type": tokenType,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? avatar;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.avatar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "avatar": avatar,
      };
}
