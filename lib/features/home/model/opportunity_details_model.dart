import 'dart:convert';

class OpportunityDetailsModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    OpportunityDetailsModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    OpportunityDetailsModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        OpportunityDetailsModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory OpportunityDetailsModel.fromRawJson(String str) => OpportunityDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OpportunityDetailsModel.fromJson(Map<String, dynamic> json) => OpportunityDetailsModel(
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
    String? status;
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

    Data({
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

    Data copyWith({
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
        String? status,
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
        Data(
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

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        status: json["status"],
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
        "status": status,
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
    String? title;
    String? description;

    Desciption({
        this.title,
        this.description,
    });

    Desciption copyWith({
        String? title,
        String? description,
    }) => 
        Desciption(
            title: title ?? this.title,
            description: description ?? this.description,
        );

    factory Desciption.fromRawJson(String str) => Desciption.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Desciption.fromJson(Map<String, dynamic> json) => Desciption(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}

class Mentor {
    int? id;
    int? userId;
    dynamic bio;
    dynamic university;
    dynamic department;
    dynamic socialLinks;
    String? status;
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
        String? status,
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
        status: json["status"],
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
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
    };
}
