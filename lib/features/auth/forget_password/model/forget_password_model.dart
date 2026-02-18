import 'dart:convert';

class ForgetPasswordModel {
  bool? status;
  String? message;
  int? code;
  Data? data;

  ForgetPasswordModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory ForgetPasswordModel.fromRawJson(String str) =>
      ForgetPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
      };
}

class Data {
  String? otp;

  Data({
    this.otp,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
