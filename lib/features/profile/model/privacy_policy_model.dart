import 'dart:convert';

class PrivacyPolicyModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    PrivacyPolicyModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    PrivacyPolicyModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        PrivacyPolicyModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory PrivacyPolicyModel.fromRawJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
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
    int? id;
    String? pageTitle;
    String? pageSlug;
    String? pageContent;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.pageTitle,
        this.pageSlug,
        this.pageContent,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Data copyWith({
        int? id,
        String? pageTitle,
        String? pageSlug,
        String? pageContent,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Data(
            id: id ?? this.id,
            pageTitle: pageTitle ?? this.pageTitle,
            pageSlug: pageSlug ?? this.pageSlug,
            pageContent: pageContent ?? this.pageContent,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        pageTitle: json["page_title"],
        pageSlug: json["page_slug"],
        pageContent: json["page_content"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "page_title": pageTitle,
        "page_slug": pageSlug,
        "page_content": pageContent,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
