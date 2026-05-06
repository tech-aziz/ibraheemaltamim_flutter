import 'dart:convert';

class SendMessageModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    SendMessageModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    SendMessageModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        SendMessageModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory SendMessageModel.fromRawJson(String str) => SendMessageModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SendMessageModel.fromJson(Map<String, dynamic> json) => SendMessageModel(
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
    int? chatId;
    int? userId;
    String? message;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    User? user;

    Data({
        this.chatId,
        this.userId,
        this.message,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.user,
    });

    Data copyWith({
        int? chatId,
        int? userId,
        String? message,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
        User? user,
    }) => 
        Data(
            chatId: chatId ?? this.chatId,
            userId: userId ?? this.userId,
            message: message ?? this.message,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
            user: user ?? this.user,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        chatId: json["chat_id"],
        userId: json["user_id"],
        message: json["message"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "user_id": userId,
        "message": message,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "user": user?.toJson(),
    };
}

class User {
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

    User({
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

    User copyWith({
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
        User(
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

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
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
