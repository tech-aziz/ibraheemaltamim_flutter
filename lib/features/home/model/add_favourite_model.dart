import 'dart:convert';

class AddFavouriteModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    AddFavouriteModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    AddFavouriteModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        AddFavouriteModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory AddFavouriteModel.fromRawJson(String str) => AddFavouriteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddFavouriteModel.fromJson(Map<String, dynamic> json) => AddFavouriteModel(
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
    int? userId;
    int? favouriteableId;
    String? favouriteableType;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.userId,
        this.favouriteableId,
        this.favouriteableType,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    Data copyWith({
        int? userId,
        int? favouriteableId,
        String? favouriteableType,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        Data(
            userId: userId ?? this.userId,
            favouriteableId: favouriteableId ?? this.favouriteableId,
            favouriteableType: favouriteableType ?? this.favouriteableType,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        favouriteableId: json["favouriteable_id"],
        favouriteableType: json["favouriteable_type"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "favouriteable_id": favouriteableId,
        "favouriteable_type": favouriteableType,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
