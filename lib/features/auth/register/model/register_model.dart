import 'dart:convert';

class RegisterModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    RegisterModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    RegisterModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        RegisterModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
    String? phone;
    String? otpExpiresIn;

    Data({
        this.phone,
        this.otpExpiresIn,
    });

    Data copyWith({
        String? phone,
        String? otpExpiresIn,
    }) => 
        Data(
            phone: phone ?? this.phone,
            otpExpiresIn: otpExpiresIn ?? this.otpExpiresIn,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
        otpExpiresIn: json["otp_expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "otp_expires_in": otpExpiresIn,
    };
}
