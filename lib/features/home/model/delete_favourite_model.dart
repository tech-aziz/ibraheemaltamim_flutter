import 'dart:convert';

class DeleteFavouriteModel {
    bool? status;
    String? message;
    int? code;

    DeleteFavouriteModel({
        this.status,
        this.message,
        this.code,
    });

    DeleteFavouriteModel copyWith({
        bool? status,
        String? message,
        int? code,
    }) => 
        DeleteFavouriteModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
        );

    factory DeleteFavouriteModel.fromRawJson(String str) => DeleteFavouriteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteFavouriteModel.fromJson(Map<String, dynamic> json) => DeleteFavouriteModel(
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
