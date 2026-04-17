import 'dart:convert';

class ServiceModel {
    bool? status;
    String? message;
    int? code;
    List<Datum>? data;
    Pagination? pagination;

    ServiceModel({
        this.status,
        this.message,
        this.code,
        this.data,
        this.pagination,
    });

    ServiceModel copyWith({
        bool? status,
        String? message,
        int? code,
        List<Datum>? data,
        Pagination? pagination,
    }) => 
        ServiceModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory ServiceModel.fromRawJson(String str) => ServiceModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
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
    String? title;
    dynamic icon;
    String? overview;
    String? description;
    String? startingPrice;
    String? whatsAppNum;
    bool? isFeatures;
    int? createdBy;
    Status? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? effectiveWhatsappNumber;

    Datum({
        this.id,
        this.title,
        this.icon,
        this.overview,
        this.description,
        this.startingPrice,
        this.whatsAppNum,
        this.isFeatures,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.effectiveWhatsappNumber,
    });

    Datum copyWith({
        int? id,
        String? title,
        dynamic icon,
        String? overview,
        String? description,
        String? startingPrice,
        String? whatsAppNum,
        bool? isFeatures,
        int? createdBy,
        Status? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? effectiveWhatsappNumber,
    }) => 
        Datum(
            id: id ?? this.id,
            title: title ?? this.title,
            icon: icon ?? this.icon,
            overview: overview ?? this.overview,
            description: description ?? this.description,
            startingPrice: startingPrice ?? this.startingPrice,
            whatsAppNum: whatsAppNum ?? this.whatsAppNum,
            isFeatures: isFeatures ?? this.isFeatures,
            createdBy: createdBy ?? this.createdBy,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            effectiveWhatsappNumber: effectiveWhatsappNumber ?? this.effectiveWhatsappNumber,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
        overview: json["overview"],
        description: json["description"],
        startingPrice: json["starting_price"],
        whatsAppNum: json["whats_app_num"],
        isFeatures: json["is_features"],
        createdBy: json["created_by"],
        status: statusValues.map[json["status"]]!,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        effectiveWhatsappNumber: json["effective_whatsapp_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "overview": overview,
        "description": description,
        "starting_price": startingPrice,
        "whats_app_num": whatsAppNum,
        "is_features": isFeatures,
        "created_by": createdBy,
        "status": statusValues.reverse[status],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "effective_whatsapp_number": effectiveWhatsappNumber,
    };
}

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "active": Status.ACTIVE
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
