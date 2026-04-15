import 'dart:convert';

class ForgetPasswordModel {
    bool? status;
    String? message;
    int? code;

    ForgetPasswordModel({
        this.status,
        this.message,
        this.code,
    });

    ForgetPasswordModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        ForgetPasswordModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory ForgetPasswordModel.fromRawJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
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
