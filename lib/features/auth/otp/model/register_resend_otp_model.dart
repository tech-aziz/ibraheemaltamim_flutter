import 'dart:convert';

class ResendRegisterOtpModel {
    bool? status;
    String? message;
    int? code;

    ResendRegisterOtpModel({
        this.status,
        this.message,
        this.code,
    });

    ResendRegisterOtpModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        ResendRegisterOtpModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory ResendRegisterOtpModel.fromRawJson(String str) => ResendRegisterOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResendRegisterOtpModel.fromJson(Map<String, dynamic> json) => ResendRegisterOtpModel(
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
