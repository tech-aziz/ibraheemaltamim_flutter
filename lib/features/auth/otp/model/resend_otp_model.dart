import 'dart:convert';

class ResendOtpModel {
    bool? status;
    String? message;
    int? code;

    ResendOtpModel({
        this.status,
        this.message,
        this.code,
    });

    ResendOtpModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        ResendOtpModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory ResendOtpModel.fromRawJson(String str) => ResendOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
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
