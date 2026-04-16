import 'dart:convert';

class UserInfoModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    UserInfoModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    UserInfoModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        UserInfoModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory UserInfoModel.fromRawJson(String str) => UserInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
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
    String? name;
    String? email;
    dynamic phone;
    String? avatar;
    dynamic coverPhoto;
    String? gender;
    String? role;
    dynamic birthdate;

    Data({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.avatar,
        this.coverPhoto,
        this.gender,
        this.role,
        this.birthdate,
    });

    Data copyWith({
        int? id,
        String? name,
        String? email,
        dynamic phone,
        String? avatar,
        dynamic coverPhoto,
        String? gender,
        String? role,
        dynamic birthdate,
    }) => 
        Data(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            avatar: avatar ?? this.avatar,
            coverPhoto: coverPhoto ?? this.coverPhoto,
            gender: gender ?? this.gender,
            role: role ?? this.role,
            birthdate: birthdate ?? this.birthdate,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        coverPhoto: json["cover_photo"],
        gender: json["gender"],
        role: json["role"],
        birthdate: json["birthdate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "gender": gender,
        "role": role,
        "birthdate": birthdate,
    };
}
