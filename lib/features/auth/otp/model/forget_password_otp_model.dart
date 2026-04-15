import 'dart:convert';

class ForgetPasswordOtpVerifyModel {
    bool? status;
    String? message;
    int? code;
    String? token;

    ForgetPasswordOtpVerifyModel({
        this.status,
        this.message,
        this.code,
        this.token,
    });

    ForgetPasswordOtpVerifyModel copyWith({
        bool? status,
        String? message,
        int? code,
        String? token,
    }) => 
        ForgetPasswordOtpVerifyModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            token: token ?? this.token,
        );

    factory ForgetPasswordOtpVerifyModel.fromRawJson(String str) => ForgetPasswordOtpVerifyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ForgetPasswordOtpVerifyModel.fromJson(Map<String, dynamic> json) => ForgetPasswordOtpVerifyModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "token": token,
    };
}
