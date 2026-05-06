import 'dart:convert';

class ChatShowModel {
    bool? status;
    String? message;
    int? code;
    Data? data;
    Pagination? pagination;

    ChatShowModel({
        this.status,
        this.message,
        this.code,
        this.data,
        this.pagination,
    });

    ChatShowModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
        Pagination? pagination,
    }) => 
        ChatShowModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory ChatShowModel.fromRawJson(String str) => ChatShowModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatShowModel.fromJson(Map<String, dynamic> json) => ChatShowModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data?.toJson(),
        "pagination": pagination?.toJson(),
    };
}

class Data {
    Chat? chat;
    List<Message>? messages;

    Data({
        this.chat,
        this.messages,
    });

    Data copyWith({
        Chat? chat,
        List<Message>? messages,
    }) => 
        Data(
            chat: chat ?? this.chat,
            messages: messages ?? this.messages,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chat": chat?.toJson(),
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class Chat {
    int? id;
    String? chatableType;
    int? chatableId;
    String? type;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Chatable? chatable;
    List<UserElement>? users;

    Chat({
        this.id,
        this.chatableType,
        this.chatableId,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.chatable,
        this.users,
    });

    Chat copyWith({
        int? id,
        String? chatableType,
        int? chatableId,
        String? type,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Chatable? chatable,
        List<UserElement>? users,
    }) => 
        Chat(
            id: id ?? this.id,
            chatableType: chatableType ?? this.chatableType,
            chatableId: chatableId ?? this.chatableId,
            type: type ?? this.type,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            chatable: chatable ?? this.chatable,
            users: users ?? this.users,
        );

    factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        chatableType: json["chatable_type"],
        chatableId: json["chatable_id"],
        type: json["type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        chatable: json["chatable"] == null ? null : Chatable.fromJson(json["chatable"]),
        users: json["users"] == null ? [] : List<UserElement>.from(json["users"]!.map((x) => UserElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chatable_type": chatableType,
        "chatable_id": chatableId,
        "type": type,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "chatable": chatable?.toJson(),
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class Chatable {
    int? id;
    String? title;
    String? thumbnail;

    Chatable({
        this.id,
        this.title,
        this.thumbnail,
    });

    Chatable copyWith({
        int? id,
        String? title,
        String? thumbnail,
    }) => 
        Chatable(
            id: id ?? this.id,
            title: title ?? this.title,
            thumbnail: thumbnail ?? this.thumbnail,
        );

    factory Chatable.fromRawJson(String str) => Chatable.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Chatable.fromJson(Map<String, dynamic> json) => Chatable(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
    };
}

class UserElement {
    int? id;
    int? chatId;
    int? userId;
    dynamic lastSeenMessageId;
    String? role;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    UserUser? user;

    UserElement({
        this.id,
        this.chatId,
        this.userId,
        this.lastSeenMessageId,
        this.role,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    UserElement copyWith({
        int? id,
        int? chatId,
        int? userId,
        dynamic lastSeenMessageId,
        String? role,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        UserUser? user,
    }) => 
        UserElement(
            id: id ?? this.id,
            chatId: chatId ?? this.chatId,
            userId: userId ?? this.userId,
            lastSeenMessageId: lastSeenMessageId ?? this.lastSeenMessageId,
            role: role ?? this.role,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
        );

    factory UserElement.fromRawJson(String str) => UserElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        lastSeenMessageId: json["last_seen_message_id"],
        role: json["role"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "last_seen_message_id": lastSeenMessageId,
        "role": role,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class UserUser {
    int? id;
    String? name;
    String? avatar;

    UserUser({
        this.id,
        this.name,
        this.avatar,
    });

    UserUser copyWith({
        int? id,
        String? name,
        String? avatar,
    }) => 
        UserUser(
            id: id ?? this.id,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
        );

    factory UserUser.fromRawJson(String str) => UserUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
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

class Message {
    int? id;
    int? chatId;
    int? userId;
    String? message;
    dynamic file;
    DateTime? seenAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    MessageUser? user;

    Message({
        this.id,
        this.chatId,
        this.userId,
        this.message,
        this.file,
        this.seenAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
    });

    Message copyWith({
        int? id,
        int? chatId,
        int? userId,
        String? message,
        dynamic file,
        DateTime? seenAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
        MessageUser? user,
    }) => 
        Message(
            id: id ?? this.id,
            chatId: chatId ?? this.chatId,
            userId: userId ?? this.userId,
            message: message ?? this.message,
            file: file ?? this.file,
            seenAt: seenAt ?? this.seenAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            user: user ?? this.user,
        );

    factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        message: json["message"],
        file: json["file"],
        seenAt: json["seen_at"] == null ? null : DateTime.parse(json["seen_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        user: json["user"] == null ? null : MessageUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "message": message,
        "file": file,
        "seen_at": seenAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "user": user?.toJson(),
    };
}

class MessageUser {
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
    DateTime? lastSeen;
    int? isAgreedTerms;
    dynamic deletedAt;

    MessageUser({
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

    MessageUser copyWith({
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
        DateTime? lastSeen,
        int? isAgreedTerms,
        dynamic deletedAt,
    }) => 
        MessageUser(
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

    factory MessageUser.fromRawJson(String str) => MessageUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageUser.fromJson(Map<String, dynamic> json) => MessageUser(
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
        lastSeen: json["last_seen"] == null ? null : DateTime.parse(json["last_seen"]),
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
        "last_seen": lastSeen?.toIso8601String(),
        "is_agreed_terms": isAgreedTerms,
        "deleted_at": deletedAt,
    };
}

class Pagination {
    int? currentPage;
    int? lastPage;
    int? perPage;
    int? total;
    String? firstPageUrl;
    String? lastPageUrl;
    dynamic nextPageUrl;
    dynamic prevPageUrl;
    int? from;
    int? to;
    String? path;

    Pagination({
        this.currentPage,
        this.lastPage,
        this.perPage,
        this.total,
        this.firstPageUrl,
        this.lastPageUrl,
        this.nextPageUrl,
        this.prevPageUrl,
        this.from,
        this.to,
        this.path,
    });

    Pagination copyWith({
        int? currentPage,
        int? lastPage,
        int? perPage,
        int? total,
        String? firstPageUrl,
        String? lastPageUrl,
        dynamic nextPageUrl,
        dynamic prevPageUrl,
        int? from,
        int? to,
        String? path,
    }) => 
        Pagination(
            currentPage: currentPage ?? this.currentPage,
            lastPage: lastPage ?? this.lastPage,
            perPage: perPage ?? this.perPage,
            total: total ?? this.total,
            firstPageUrl: firstPageUrl ?? this.firstPageUrl,
            lastPageUrl: lastPageUrl ?? this.lastPageUrl,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
            from: from ?? this.from,
            to: to ?? this.to,
            path: path ?? this.path,
        );

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        from: json["from"],
        to: json["to"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "first_page_url": firstPageUrl,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "from": from,
        "to": to,
        "path": path,
    };
}
