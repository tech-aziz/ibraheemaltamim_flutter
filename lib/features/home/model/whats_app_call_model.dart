import 'dart:convert';

class WhatsAppCallModel {
    bool? status;
    String? message;
    int? code;
    Data? data;

    WhatsAppCallModel({
        this.status,
        this.message,
        this.code,
        this.data,
    });

    WhatsAppCallModel copyWith({
        bool? status,
        String? message,
        int? code,
        Data? data,
    }) => 
        WhatsAppCallModel(
            status: status ?? this.status,
            message: message ?? this.message,
            code: code ?? this.code,
            data: data ?? this.data,
        );

    factory WhatsAppCallModel.fromRawJson(String str) => WhatsAppCallModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WhatsAppCallModel.fromJson(Map<String, dynamic> json) => WhatsAppCallModel(
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
    String? systemName;
    String? logo;
    String? favicon;
    String? copyrightText;
    dynamic address;
    String? companyOpenHour;
    String? description;
    String? contactNumber;
    String? email;
    String? whatsappNumber;
    String? calendlySchedulingUrl;

    Data({
        this.id,
        this.systemName,
        this.logo,
        this.favicon,
        this.copyrightText,
        this.address,
        this.companyOpenHour,
        this.description,
        this.contactNumber,
        this.email,
        this.whatsappNumber,
        this.calendlySchedulingUrl,
    });

    Data copyWith({
        int? id,
        String? systemName,
        String? logo,
        String? favicon,
        String? copyrightText,
        dynamic address,
        String? companyOpenHour,
        String? description,
        String? contactNumber,
        String? email,
        String? whatsappNumber,
        String? calendlySchedulingUrl,
    }) => 
        Data(
            id: id ?? this.id,
            systemName: systemName ?? this.systemName,
            logo: logo ?? this.logo,
            favicon: favicon ?? this.favicon,
            copyrightText: copyrightText ?? this.copyrightText,
            address: address ?? this.address,
            companyOpenHour: companyOpenHour ?? this.companyOpenHour,
            description: description ?? this.description,
            contactNumber: contactNumber ?? this.contactNumber,
            email: email ?? this.email,
            whatsappNumber: whatsappNumber ?? this.whatsappNumber,
            calendlySchedulingUrl: calendlySchedulingUrl ?? this.calendlySchedulingUrl,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        systemName: json["system_name"],
        logo: json["logo"],
        favicon: json["favicon"],
        copyrightText: json["copyright_text"],
        address: json["address"],
        companyOpenHour: json["company_open_hour"],
        description: json["description"],
        contactNumber: json["contact_number"],
        email: json["email"],
        whatsappNumber: json["whatsapp_number"],
        calendlySchedulingUrl: json["calendly_scheduling_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "system_name": systemName,
        "logo": logo,
        "favicon": favicon,
        "copyright_text": copyrightText,
        "address": address,
        "company_open_hour": companyOpenHour,
        "description": description,
        "contact_number": contactNumber,
        "email": email,
        "whatsapp_number": whatsappNumber,
        "calendly_scheduling_url": calendlySchedulingUrl,
    };
}
