import 'dart:convert';

class ChatListModel {
    bool? status;
    String? message;
    int? code;
    List<Datum>? data;
    Pagination? pagination;

    ChatListModel({
        this.status,
        this.message,
        this.code,
        this.data,
        this.pagination,
    });

    ChatListModel copyWith({
        bool? status,
        String? message,
        int? code,
        List<Datum>? data,
        Pagination? pagination,
    }) => 
        ChatListModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory ChatListModel.fromRawJson(String str) => ChatListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class Datum {
    int? id;
    String? chatableType;
    int? chatableId;
    String? type;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? unseenCount;
    Chatable? chatable;
    LastMessage? lastMessage;
    List<Participant>? users;

    Datum({
        this.id,
        this.chatableType,
        this.chatableId,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.unseenCount,
        this.chatable,
        this.lastMessage,
        this.users,
    });

    Datum copyWith({
        int? id,
        String? chatableType,
        int? chatableId,
        String? type,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? unseenCount,
        Chatable? chatable,
        LastMessage? lastMessage,
        List<Participant>? users,
    }) => 
        Datum(
            id: id ?? this.id,
            chatableType: chatableType ?? this.chatableType,
            chatableId: chatableId ?? this.chatableId,
            type: type ?? this.type,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            unseenCount: unseenCount ?? this.unseenCount,
            chatable: chatable ?? this.chatable,
            lastMessage: lastMessage ?? this.lastMessage,
            users: users ?? this.users,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        chatableType: json["chatable_type"],
        chatableId: json["chatable_id"],
        type: json["type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        unseenCount: json["unseen_count"],
        chatable: json["chatable"] == null ? null : Chatable.fromJson(json["chatable"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
        users: json["users"] == null ? [] : List<Participant>.from(json["users"]!.map((x) => Participant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chatable_type": chatableType,
        "chatable_id": chatableId,
        "type": type,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "unseen_count": unseenCount,
        "chatable": chatable?.toJson(),
        "last_message": lastMessage?.toJson(),
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

class LastMessage {
    int? id;
    int? chatId;
    int? userId;
    String? message;
    dynamic file;
    dynamic seenAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    LastMessage({
        this.id,
        this.chatId,
        this.userId,
        this.message,
        this.file,
        this.seenAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    LastMessage copyWith({
        int? id,
        int? chatId,
        int? userId,
        String? message,
        dynamic file,
        dynamic seenAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
    }) => 
        LastMessage(
            id: id ?? this.id,
            chatId: chatId ?? this.chatId,
            userId: userId ?? this.userId,
            message: message ?? this.message,
            file: file ?? this.file,
            seenAt: seenAt ?? this.seenAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory LastMessage.fromRawJson(String str) => LastMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        message: json["message"],
        file: json["file"],
        seenAt: json["seen_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "message": message,
        "file": file,
        "seen_at": seenAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Participant {
    int? id;
    int? chatId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    ChatUser? user;

    Participant({
        this.id,
        this.chatId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    Participant copyWith({
        int? id,
        int? chatId,
        int? userId,
        DateTime? createdAt,
        DateTime? updatedAt,
        ChatUser? user,
    }) => 
        Participant(
            id: id ?? this.id,
            chatId: chatId ?? this.chatId,
            userId: userId ?? this.userId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
        );

    factory Participant.fromRawJson(String str) => Participant.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        chatId: json["chat_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : ChatUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class ChatUser {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? avatar;
    String? role;

    ChatUser({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.avatar,
        this.role,
    });

    ChatUser copyWith({
        int? id,
        String? name,
        String? email,
        String? phone,
        String? avatar,
        String? role,
    }) => 
        ChatUser(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            avatar: avatar ?? this.avatar,
            role: role ?? this.role,
        );

    factory ChatUser.fromRawJson(String str) => ChatUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "role": role,
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
