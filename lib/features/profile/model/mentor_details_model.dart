import 'dart:convert';

class MentorDetailsModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    MentorDetailsModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    MentorDetailsModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        MentorDetailsModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory MentorDetailsModel.fromRawJson(String str) => MentorDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MentorDetailsModel.fromJson(Map<String, dynamic> json) => MentorDetailsModel(
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
    int? userId;
    String? bio;
    String? university;
    String? department;
    dynamic socialLinks;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Data({
        this.id,
        this.userId,
        this.bio,
        this.university,
        this.department,
        this.socialLinks,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    Data copyWith({
        int? id,
        int? userId,
        String? bio,
        String? university,
        String? department,
        dynamic socialLinks,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? user,
    }) => 
        Data(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            bio: bio ?? this.bio,
            university: university ?? this.university,
            department: department ?? this.department,
            socialLinks: socialLinks ?? this.socialLinks,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        bio: json["bio"],
        university: json["university"],
        department: json["department"],
        socialLinks: json["social_links"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bio": bio,
        "university": university,
        "department": department,
        "social_links": socialLinks,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? avatar;

    User({
        this.id,
        this.name,
        this.avatar,
    });

    User copyWith({
        int? id,
        String? name,
        String? avatar,
    }) => 
        User(
            id: id ?? this.id,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
    };
}
