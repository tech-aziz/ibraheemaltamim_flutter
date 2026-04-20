import 'dart:convert';

class FilterListModel {
    bool? status;
    String? message;
    int? code;
    List<Datum>? data;
    Pagination? pagination;

    FilterListModel({
        this.status,
        this.message,
        this.code,
        this.data,
        this.pagination,
    });

    FilterListModel copyWith({
        bool? status,
        String? message,
        int? code,
        List<Datum>? data,
        Pagination? pagination,
    }) => 
        FilterListModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory FilterListModel.fromRawJson(String str) => FilterListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FilterListModel.fromJson(Map<String, dynamic> json) => FilterListModel(
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
    String? name;

    Datum({
        this.id,
        this.name,
    });

    Datum copyWith({
        int? id,
        String? name,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
