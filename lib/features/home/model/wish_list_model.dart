import 'dart:convert';

class WishListModel {
  bool? status;
  String? message;
  int? code;
  List<Datum>? data;

  WishListModel({this.status, this.message, this.code, this.data});

  WishListModel copyWith({
    bool? status,
    String? message,
    int? code,
    List<Datum>? data,
  }) => WishListModel(
    status: status ?? this.status,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory WishListModel.fromRawJson(String str) =>
      WishListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    List<Datum> parsedData = [];
    if (json["data"] != null) {
      if (json["data"] is List) {
        parsedData = List<Datum>.from(
          json["data"].map((x) => Datum.fromJson(x)),
        );
      } else if (json["data"] is Map && json["data"]["data"] is List) {
        parsedData = List<Datum>.from(
          json["data"]["data"].map((x) => Datum.fromJson(x)),
        );
      }
    }
    return WishListModel(
      status: json["status"],
      message: json["message"]?.toString(),
      code: json["code"],
      data: parsedData,
    );
  }

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
  int? id;
  int? userId;
  String? favouriteableType;
  int? favouriteableId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Favouriteable? favouriteable;

  Datum({
    this.id,
    this.userId,
    this.favouriteableType,
    this.favouriteableId,
    this.createdAt,
    this.updatedAt,
    this.favouriteable,
  });

  Datum copyWith({
    int? id,
    int? userId,
    String? favouriteableType,
    int? favouriteableId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Favouriteable? favouriteable,
  }) => Datum(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    favouriteableType: favouriteableType ?? this.favouriteableType,
    favouriteableId: favouriteableId ?? this.favouriteableId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    favouriteable: favouriteable ?? this.favouriteable,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    favouriteableType: json["favouriteable_type"]?.toString(),
    favouriteableId: json["favouriteable_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"].toString()),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"].toString()),
    favouriteable: json["favouriteable"] == null
        ? null
        : Favouriteable.fromJson(json["favouriteable"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "favouriteable_type": favouriteableType,
    "favouriteable_id": favouriteableId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "favouriteable": favouriteable?.toJson(),
  };
}

class Favouriteable {
  int? id;
  int? mentorId;
  List<int>? categoryIds;
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
  List<int>? specialityIds;
  List<int>? studydesignTypeIds;
  List<int>? contributionTypeIds;
  List<int>? universityHospitalIds;
  List<int>? placeIds;
  List<int>? experienceLevelIds;
  bool? isFuture;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Favouriteable({
    this.id,
    this.mentorId,
    this.categoryIds,
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
    this.specialityIds,
    this.studydesignTypeIds,
    this.contributionTypeIds,
    this.universityHospitalIds,
    this.placeIds,
    this.experienceLevelIds,
    this.isFuture,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Favouriteable copyWith({
    int? id,
    int? mentorId,
    List<int>? categoryIds,
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
    List<int>? specialityIds,
    List<int>? studydesignTypeIds,
    List<int>? contributionTypeIds,
    List<int>? universityHospitalIds,
    List<int>? placeIds,
    List<int>? experienceLevelIds,
    bool? isFuture,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Favouriteable(
    id: id ?? this.id,
    mentorId: mentorId ?? this.mentorId,
    categoryIds: categoryIds ?? this.categoryIds,
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
    specialityIds: specialityIds ?? this.specialityIds,
    studydesignTypeIds: studydesignTypeIds ?? this.studydesignTypeIds,
    contributionTypeIds: contributionTypeIds ?? this.contributionTypeIds,
    universityHospitalIds: universityHospitalIds ?? this.universityHospitalIds,
    placeIds: placeIds ?? this.placeIds,
    experienceLevelIds: experienceLevelIds ?? this.experienceLevelIds,
    isFuture: isFuture ?? this.isFuture,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Favouriteable.fromRawJson(String str) =>
      Favouriteable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Favouriteable.fromJson(Map<String, dynamic> json) => Favouriteable(
    id: json["id"],
    mentorId: json["mentor_id"],
    categoryIds: json["category_ids"] == null
        ? []
        : List<int>.from(
            json["category_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    title: json["title"]?.toString(),
    slug: json["slug"]?.toString(),
    overview: json["overview"]?.toString(),
    price: json["price"]?.toString(),
    thumbnail: json["thumbnail"],
    desciptions: json["desciptions"] == null
        ? []
        : List<Desciption>.from(
            json["desciptions"]!.map((x) => Desciption.fromJson(x)),
          ),
    deadLine: json["dead_line"] == null
        ? null
        : DateTime.tryParse(json["dead_line"].toString()),
    durations: json["durations"]?.toString(),
    startDate: json["start_date"] == null
        ? null
        : DateTime.tryParse(json["start_date"].toString()),
    endDate: json["end_date"] == null
        ? null
        : DateTime.tryParse(json["end_date"].toString()),
    specialityIds: json["speciality_ids"] == null
        ? []
        : List<int>.from(
            json["speciality_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    studydesignTypeIds: json["studydesign_type_ids"] == null
        ? []
        : List<int>.from(
            json["studydesign_type_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    contributionTypeIds: json["contribution_type_ids"] == null
        ? []
        : List<int>.from(
            json["contribution_type_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    universityHospitalIds: json["university_hospital_ids"] == null
        ? []
        : List<int>.from(
            json["university_hospital_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    placeIds: json["place_ids"] == null
        ? []
        : List<int>.from(
            json["place_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    experienceLevelIds: json["experience_level_ids"] == null
        ? []
        : List<int>.from(
            json["experience_level_ids"]!.map(
              (x) => x is int ? x : int.tryParse(x.toString()) ?? 0,
            ),
          ),
    isFuture: json["is_future"],
    status: json["status"]?.toString(),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"].toString()),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mentor_id": mentorId,
    "category_ids": categoryIds == null
        ? []
        : List<dynamic>.from(categoryIds!.map((x) => x)),
    "title": title,
    "slug": slug,
    "overview": overview,
    "price": price,
    "thumbnail": thumbnail,
    "desciptions": desciptions == null
        ? []
        : List<dynamic>.from(desciptions!.map((x) => x.toJson())),
    "dead_line": deadLine?.toIso8601String(),
    "durations": durations,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "speciality_ids": specialityIds == null
        ? []
        : List<dynamic>.from(specialityIds!.map((x) => x)),
    "studydesign_type_ids": studydesignTypeIds == null
        ? []
        : List<dynamic>.from(studydesignTypeIds!.map((x) => x)),
    "contribution_type_ids": contributionTypeIds == null
        ? []
        : List<dynamic>.from(contributionTypeIds!.map((x) => x)),
    "university_hospital_ids": universityHospitalIds == null
        ? []
        : List<dynamic>.from(universityHospitalIds!.map((x) => x)),
    "place_ids": placeIds == null
        ? []
        : List<dynamic>.from(placeIds!.map((x) => x)),
    "experience_level_ids": experienceLevelIds == null
        ? []
        : List<dynamic>.from(experienceLevelIds!.map((x) => x)),
    "is_future": isFuture,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Desciption {
  String? title;
  String? description;

  Desciption({this.title, this.description});

  Desciption copyWith({String? title, String? description}) => Desciption(
    title: title ?? this.title,
    description: description ?? this.description,
  );

  factory Desciption.fromRawJson(String str) =>
      Desciption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Desciption.fromJson(Map<String, dynamic> json) =>
      Desciption(title: json["title"], description: json["description"]);

  Map<String, dynamic> toJson() => {"title": title, "description": description};
}
