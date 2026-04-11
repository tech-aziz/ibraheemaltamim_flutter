import 'dart:convert';

class SetNewPasswordModel {
  bool? status;
  String? message;
  int? code;

  SetNewPasswordModel({
    this.status,
    this.message,
    this.code,
  });

  factory SetNewPasswordModel.fromRawJson(String str) =>
      SetNewPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SetNewPasswordModel.fromJson(Map<String, dynamic> json) =>
      SetNewPasswordModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
      };
}
