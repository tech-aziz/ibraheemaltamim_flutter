import 'dart:convert';

class VerifyRegisterOtpModel {
    bool? status;
    String? message;
    int? code;
    String? tokenType;
    String? token;
    Data? data;

    VerifyRegisterOtpModel({
        this.status,
        this.message,
        this.code,
        this.tokenType,
        this.token,
        this.data,
    });

    VerifyRegisterOtpModel copyWith({
        bool? status,
        String? message,
        int? code,
        String? tokenType,
        String? token,
        Data? data,
    }) => 
        VerifyRegisterOtpModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            tokenType: tokenType ?? this.tokenType,
            token: token ?? this.token,
            data: data ?? this.data,
        );

    factory VerifyRegisterOtpModel.fromRawJson(String str) => VerifyRegisterOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerifyRegisterOtpModel.fromJson(Map<String, dynamic> json) => VerifyRegisterOtpModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        tokenType: json["token_type"],
        token: json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "token_type": tokenType,
        "token": token,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic avatar;
    dynamic coverPhoto;
    dynamic birthdate;
    dynamic institution;
    dynamic gender;
    String? role;
    dynamic lastSeen;
    int? isAgreedTerms;
    dynamic deletedAt;

    Data({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.avatar,
        this.coverPhoto,
        this.birthdate,
        this.institution,
        this.gender,
        this.role,
        this.lastSeen,
        this.isAgreedTerms,
        this.deletedAt,
    });

    Data copyWith({
        int? id,
        String? name,
        String? email,
        dynamic phone,
        dynamic avatar,
        dynamic coverPhoto,
        dynamic birthdate,
        dynamic institution,
        dynamic gender,
        String? role,
        dynamic lastSeen,
        int? isAgreedTerms,
        dynamic deletedAt,
    }) => 
        Data(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            avatar: avatar ?? this.avatar,
            coverPhoto: coverPhoto ?? this.coverPhoto,
            birthdate: birthdate ?? this.birthdate,
            institution: institution ?? this.institution,
            gender: gender ?? this.gender,
            role: role ?? this.role,
            lastSeen: lastSeen ?? this.lastSeen,
            isAgreedTerms: isAgreedTerms ?? this.isAgreedTerms,
            deletedAt: deletedAt ?? this.deletedAt,
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
        birthdate: json["birthdate"],
        institution: json["institution"],
        gender: json["gender"],
        role: json["role"],
        lastSeen: json["last_seen"],
        isAgreedTerms: json["is_agreed_terms"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "birthdate": birthdate,
        "institution": institution,
        "gender": gender,
        "role": role,
        "last_seen": lastSeen,
        "is_agreed_terms": isAgreedTerms,
        "deleted_at": deletedAt,
    };
}
