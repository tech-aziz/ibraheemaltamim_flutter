import 'dart:convert';

class MarkAsReadModel {
    bool? status;
    String? message;
    int? code;

    MarkAsReadModel({
        this.status,
        this.message,
        this.code,
    });

    MarkAsReadModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        MarkAsReadModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory MarkAsReadModel.fromRawJson(String str) => MarkAsReadModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MarkAsReadModel.fromJson(Map<String, dynamic> json) => MarkAsReadModel(
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
