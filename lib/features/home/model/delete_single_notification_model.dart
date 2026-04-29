import 'dart:convert';

class DeleteSingleNotificationModel {
    bool? status;
    String? message;
    int? code;

    DeleteSingleNotificationModel({
        this.status,
        this.message,
        this.code,
    });

    DeleteSingleNotificationModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        DeleteSingleNotificationModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory DeleteSingleNotificationModel.fromRawJson(String str) => DeleteSingleNotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteSingleNotificationModel.fromJson(Map<String, dynamic> json) => DeleteSingleNotificationModel(
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
