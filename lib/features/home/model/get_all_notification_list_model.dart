import 'dart:convert';

class GetAllNotificationListModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  GetAllNotificationListModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  GetAllNotificationListModel copyWith({
    bool? status,
    String? message,
    int? code,
    List<Datum>? data,
  }) => GetAllNotificationListModel(
    status: status ?? this.status,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory GetAllNotificationListModel.fromRawJson(String str) =>
      GetAllNotificationListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllNotificationListModel.fromJson(Map<String, dynamic> json) =>
      GetAllNotificationListModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  DatumData? data;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    String? id,
    String? type,
    String? notifiableType,
    int? notifiableId,
    DatumData? data,
    dynamic readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Datum(
    id: id ?? this.id,
    type: type ?? this.type,
    notifiableType: notifiableType ?? this.notifiableType,
    notifiableId: notifiableId ?? this.notifiableId,
    data: data ?? this.data,
    readAt: readAt ?? this.readAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: json["data"] == null ? null : DatumData.fromJson(json["data"]),
    readAt: json["read_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class DatumData {
  String? title;
  String? message;
  String? type;
  String? image;
  DeepLink? deepLink;
  DataData? data;
  String? footer;
  DateTime? timestamp;

  DatumData({
    this.title,
    this.message,
    this.type,
    this.image,
    this.deepLink,
    this.data,
    this.footer,
    this.timestamp,
  });

  DatumData copyWith({
    String? title,
    String? message,
    String? type,
    String? image,
    DeepLink? deepLink,
    DataData? data,
    String? footer,
    DateTime? timestamp,
  }) => DatumData(
    title: title ?? this.title,
    message: message ?? this.message,
    type: type ?? this.type,
    image: image ?? this.image,
    deepLink: deepLink ?? this.deepLink,
    data: data ?? this.data,
    footer: footer ?? this.footer,
    timestamp: timestamp ?? this.timestamp,
  );

  factory DatumData.fromRawJson(String str) =>
      DatumData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumData.fromJson(Map<String, dynamic> json) => DatumData(
    title: json["title"],
    message: json["message"],
    type: json["type"],
    image: json["image"],
    deepLink: json["deep_link"] == null
        ? null
        : DeepLink.fromJson(json["deep_link"]),
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    footer: json["footer"],
    timestamp: json["timestamp"] == null
        ? null
        : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "type": type,
    "image": image,
    "deep_link": deepLink?.toJson(),
    "data": data?.toJson(),
    "footer": footer,
    "timestamp": timestamp?.toIso8601String(),
  };
}

class DataData {
  int? userId;
  String? email;

  DataData({this.userId, this.email});

  DataData copyWith({int? userId, String? email}) =>
      DataData(userId: userId ?? this.userId, email: email ?? this.email);

  factory DataData.fromRawJson(String str) =>
      DataData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataData.fromJson(Map<String, dynamic> json) =>
      DataData(userId: json["user_id"], email: json["email"]);

  Map<String, dynamic> toJson() => {"user_id": userId, "email": email};
}

class DeepLink {
  String? app;
  String? web;

  DeepLink({this.app, this.web});

  DeepLink copyWith({String? app, String? web}) =>
      DeepLink(app: app ?? this.app, web: web ?? this.web);

  factory DeepLink.fromRawJson(String str) =>
      DeepLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeepLink.fromJson(Map<String, dynamic> json) =>
      DeepLink(app: json["app"], web: json["web"]);

  Map<String, dynamic> toJson() => {"app": app, "web": web};
}
