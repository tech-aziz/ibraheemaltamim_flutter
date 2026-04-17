import 'dart:convert';

class OpportunityListModel {
    bool? status;
    String? message;
    int? code;
    List<Datum>? data;
    Pagination? pagination;

    OpportunityListModel({
        this.status,
        this.message,
        this.code,
        this.data,
        this.pagination,
    });

    OpportunityListModel copyWith({
        bool? status,
        String? message,
        int? code,
        List<Datum>? data,
        Pagination? pagination,
    }) => 
        OpportunityListModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
            pagination: pagination ?? this.pagination,
        );

    factory OpportunityListModel.fromRawJson(String str) => OpportunityListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OpportunityListModel.fromJson(Map<String, dynamic> json) => OpportunityListModel(
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
    int? mentorId;
    String? title;
    String? slug;
    String? overview;
    String? price;
    dynamic thumbnail;
    List<Desciption>? desciptions;
    DateTime? deadLine;
    String? durations;
    DateTime? startDate;
    DateTime? endDate;
    bool? isFuture;
    Status? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Category>? categories;
    List<Category>? specialities;
    List<Category>? studydesignTypes;
    List<Category>? contributionTypes;
    List<Category>? universityHospitals;
    List<Category>? places;
    List<Category>? experienceLevels;
    Mentor? mentor;

    Datum({
        this.id,
        this.mentorId,
        this.title,
        this.slug,
        this.overview,
        this.price,
        this.thumbnail,
        this.desciptions,
        this.deadLine,
        this.durations,
        this.startDate,
        this.endDate,
        this.isFuture,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.categories,
        this.specialities,
        this.studydesignTypes,
        this.contributionTypes,
        this.universityHospitals,
        this.places,
        this.experienceLevels,
        this.mentor,
    });

    Datum copyWith({
        int? id,
        int? mentorId,
        String? title,
        String? slug,
        String? overview,
        String? price,
        dynamic thumbnail,
        List<Desciption>? desciptions,
        DateTime? deadLine,
        String? durations,
        DateTime? startDate,
        DateTime? endDate,
        bool? isFuture,
        Status? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Category>? categories,
        List<Category>? specialities,
        List<Category>? studydesignTypes,
        List<Category>? contributionTypes,
        List<Category>? universityHospitals,
        List<Category>? places,
        List<Category>? experienceLevels,
        Mentor? mentor,
    }) => 
        Datum(
            id: id ?? this.id,
            mentorId: mentorId ?? this.mentorId,
            title: title ?? this.title,
            slug: slug ?? this.slug,
            overview: overview ?? this.overview,
            price: price ?? this.price,
            thumbnail: thumbnail ?? this.thumbnail,
            desciptions: desciptions ?? this.desciptions,
            deadLine: deadLine ?? this.deadLine,
            durations: durations ?? this.durations,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            isFuture: isFuture ?? this.isFuture,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            categories: categories ?? this.categories,
            specialities: specialities ?? this.specialities,
            studydesignTypes: studydesignTypes ?? this.studydesignTypes,
            contributionTypes: contributionTypes ?? this.contributionTypes,
            universityHospitals: universityHospitals ?? this.universityHospitals,
            places: places ?? this.places,
            experienceLevels: experienceLevels ?? this.experienceLevels,
            mentor: mentor ?? this.mentor,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        mentorId: json["mentor_id"],
        title: json["title"],
        slug: json["slug"],
        overview: json["overview"],
        price: json["price"],
        thumbnail: json["thumbnail"],
        desciptions: json["desciptions"] == null ? [] : List<Desciption>.from(json["desciptions"]!.map((x) => Desciption.fromJson(x))),
        deadLine: json["dead_line"] == null ? null : DateTime.parse(json["dead_line"]),
        durations: json["durations"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        isFuture: json["is_future"],
        status: statusValues.map[json["status"]] ?? Status.ACTIVE,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        specialities: json["specialities"] == null ? [] : List<Category>.from(json["specialities"]!.map((x) => Category.fromJson(x))),
        studydesignTypes: json["studydesign_types"] == null ? [] : List<Category>.from(json["studydesign_types"]!.map((x) => Category.fromJson(x))),
        contributionTypes: json["contribution_types"] == null ? [] : List<Category>.from(json["contribution_types"]!.map((x) => Category.fromJson(x))),
        universityHospitals: json["university_hospitals"] == null ? [] : List<Category>.from(json["university_hospitals"]!.map((x) => Category.fromJson(x))),
        places: json["places"] == null ? [] : List<Category>.from(json["places"]!.map((x) => Category.fromJson(x))),
        experienceLevels: json["experience_levels"] == null ? [] : List<Category>.from(json["experience_levels"]!.map((x) => Category.fromJson(x))),
        mentor: json["mentor"] == null ? null : Mentor.fromJson(json["mentor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mentor_id": mentorId,
        "title": title,
        "slug": slug,
        "overview": overview,
        "price": price,
        "thumbnail": thumbnail,
        "desciptions": desciptions == null ? [] : List<dynamic>.from(desciptions!.map((x) => x.toJson())),
        "dead_line": deadLine?.toIso8601String(),
        "durations": durations,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "is_future": isFuture,
        "status": statusValues.reverse[status],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "specialities": specialities == null ? [] : List<dynamic>.from(specialities!.map((x) => x.toJson())),
        "studydesign_types": studydesignTypes == null ? [] : List<dynamic>.from(studydesignTypes!.map((x) => x.toJson())),
        "contribution_types": contributionTypes == null ? [] : List<dynamic>.from(contributionTypes!.map((x) => x.toJson())),
        "university_hospitals": universityHospitals == null ? [] : List<dynamic>.from(universityHospitals!.map((x) => x.toJson())),
        "places": places == null ? [] : List<dynamic>.from(places!.map((x) => x.toJson())),
        "experience_levels": experienceLevels == null ? [] : List<dynamic>.from(experienceLevels!.map((x) => x.toJson())),
        "mentor": mentor?.toJson(),
    };
}

class Category {
    int? id;
    String? name;

    Category({
        this.id,
        this.name,
    });

    Category copyWith({
        int? id,
        String? name,
    }) => 
        Category(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Desciption {
    Title? title;
    String? description;

    Desciption({
        this.title,
        this.description,
    });

    Desciption copyWith({
        Title? title,
        String? description,
    }) => 
        Desciption(
            title: title ?? this.title,
            description: description ?? this.description,
        );

    factory Desciption.fromRawJson(String str) => Desciption.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Desciption.fromJson(Map<String, dynamic> json) => Desciption(
        title: titleValues.map[json["title"]] ?? Title.BENEFITS,
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": titleValues.reverse[title],
        "description": description,
    };
}

enum Title {
    BENEFITS,
    REQUIREMENTS,
    RESPONSIBILITIES
}

final titleValues = EnumValues({
    "Benefits": Title.BENEFITS,
    "Requirements": Title.REQUIREMENTS,
    "Responsibilities": Title.RESPONSIBILITIES
});

class Mentor {
    int? id;
    int? userId;
    dynamic bio;
    dynamic university;
    dynamic department;
    dynamic socialLinks;
    Status? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic user;

    Mentor({
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

    Mentor copyWith({
        int? id,
        int? userId,
        dynamic bio,
        dynamic university,
        dynamic department,
        dynamic socialLinks,
        Status? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic user,
    }) => 
        Mentor(
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

    factory Mentor.fromRawJson(String str) => Mentor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        id: json["id"],
        userId: json["user_id"],
        bio: json["bio"],
        university: json["university"],
        department: json["department"],
        socialLinks: json["social_links"],
        status: statusValues.map[json["status"]] ?? Status.ACTIVE,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bio": bio,
        "university": university,
        "department": department,
        "social_links": socialLinks,
        "status": statusValues.reverse[status],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
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
    String? nextPageUrl;
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
        String? nextPageUrl,
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
