// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

List<Property> propertyFromJson(String str) => List<Property>.from(json.decode(str).map((x) => Property.fromJson(x)));

String propertyToJson(List<Property> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Property {
    int? id;
    DateTime? dateTime;
    String? title;
    String? location;
    String? description;
    String? projectProgress;
    String? introImage;
    String? photos;
    String? videoLink;
    String? brochure;
    String? installmentPlan;
    dynamic standardFacilities;
    String? projectType;
    String? mapLink;
    int? isfeatured;
    int? ispublished;
    String? status;
    String? availableUnits;
    String? subtitle;
    dynamic projectUnits;
    String? broucher;
    List<dynamic>? amenities;
    List<String>? images;
    List<PaymentPlan>? paymentPlans;
    List<Unit>? units;
    List<Update>? updates;
    List<Testimonial>? testimonials;

    Property({
        this.id,
        this.dateTime,
        this.title,
        this.location,
        this.description,
        this.projectProgress,
        this.introImage,
        this.photos,
        this.videoLink,
        this.brochure,
        this.installmentPlan,
        this.standardFacilities,
        this.projectType,
        this.mapLink,
        this.isfeatured,
        this.ispublished,
        this.status,
        this.availableUnits,
        this.subtitle,
        this.projectUnits,
        this.broucher,
        this.amenities,
        this.images,
        this.paymentPlans,
        this.units,
        this.updates,
        this.testimonials,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        title: json["title"],
        location: json["location"],
        description: json["Description"],
        projectProgress: json["project_progress"],
        introImage: json["intro_image"],
        photos: json["photos"],
        videoLink: json["video_link"],
        brochure: json["brochure"],
        installmentPlan: json["installment_plan"],
        standardFacilities: json["standard_facilities"],
        projectType: json["project_type"],
        mapLink: json["map_link"],
        isfeatured: json["isfeatured"],
        ispublished: json["ispublished"],
        status: json["status"],
        availableUnits: json["available_units"],
        subtitle: json["subtitle"],
        projectUnits: json["project_units"],
        broucher: json["broucher"],
        amenities: json["amenities"] == null ? [] : List<dynamic>.from(json["amenities"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        paymentPlans: json["payment_plans"] == null ? [] : List<PaymentPlan>.from(json["payment_plans"]!.map((x) => PaymentPlan.fromJson(x))),
        units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
        updates: json["updates"] == null ? [] : List<Update>.from(json["updates"]!.map((x) => Update.fromJson(x))),
        testimonials: json["testimonials"] == null ? [] : List<Testimonial>.from(json["testimonials"]!.map((x) => Testimonial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "title": title,
        "location": location,
        "Description": description,
        "project_progress": projectProgress,
        "intro_image": introImage,
        "photos": photos,
        "video_link": videoLink,
        "brochure": brochure,
        "installment_plan": installmentPlan,
        "standard_facilities": standardFacilities,
        "project_type": projectType,
        "map_link": mapLink,
        "isfeatured": isfeatured,
        "ispublished": ispublished,
        "status": status,
        "available_units": availableUnits,
        "subtitle": subtitle,
        "project_units": projectUnits,
        "broucher": broucher,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "payment_plans": paymentPlans == null ? [] : List<dynamic>.from(paymentPlans!.map((x) => x.toJson())),
        "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
        "updates": updates == null ? [] : List<dynamic>.from(updates!.map((x) => x.toJson())),
        "testimonials": testimonials == null ? [] : List<dynamic>.from(testimonials!.map((x) => x.toJson())),
    };
}



class PaymentPlan {
    int? id;
    int? parentId;
    String? title;
    String? description;

    PaymentPlan({
        this.id,
        this.parentId,
        this.title,
        this.description,
    });

    factory PaymentPlan.fromJson(Map<String, dynamic> json) => PaymentPlan(
        id: json["id"],
        parentId: json["parent_id"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "title": title,
        "description": description,
    };
}


class Testimonial {
    int? id;
    DateTime? dateTime;
    String? fullName;
    String? testimonial;
    String? profilePicture;
    int? ispublished;
    int? projects;
    String? videoLink;

    Testimonial({
        this.id,
        this.dateTime,
        this.fullName,
        this.testimonial,
        this.profilePicture,
        this.ispublished,
        this.projects,
        this.videoLink,
    });

    factory Testimonial.fromJson(Map<String, dynamic> json) => Testimonial(
        id: json["id"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        fullName: json["full_name"],
        testimonial: json["testimonial"],
        profilePicture: json["profile_picture"],
        ispublished: json["ispublished"],
        projects: json["projects"],
        videoLink: json["video_link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "full_name": fullName,
        "testimonial": testimonial,
        "profile_picture": profilePicture,
        "ispublished": ispublished,
        "projects": projects,
        "video_link": videoLink,
    };
}

class Unit {
    int? id;
    DateTime? dateTime;
    int? project;
    String? unitTitle;
    String? features;
    String? description;
    List<String>? floorPlans;
    int? availability;
    int? ispublished;
    List<String>? apartmentAmenities;
    dynamic fieldsApartmentsPhotos;
    String? introImage;
    List<String>? photos;

    Unit({
        this.id,
        this.dateTime,
        this.project,
        this.unitTitle,
        this.features,
        this.description,
        this.floorPlans,
        this.availability,
        this.ispublished,
        this.apartmentAmenities,
        this.fieldsApartmentsPhotos,
        this.introImage,
        this.photos,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        project: json["project"],
        unitTitle: json["unit_title"],
        features: json["features"],
        description: json["description"],
        floorPlans: json["floor_plans"] == null ? [] : List<String>.from(json["floor_plans"]!.map((x) => x)),
        availability: json["availability"],
        ispublished: json["ispublished"],
        apartmentAmenities: json["apartment_amenities"] == null ? [] : List<String>.from(json["apartment_amenities"]!.map((x) => x)),
        fieldsApartmentsPhotos: json["fields_apartments_photos"],
        introImage: json["intro_image"],
        photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "project": project,
        "unit_title": unitTitle,
        "features": features,
        "description": description,
        "floor_plans": floorPlans == null ? [] : List<dynamic>.from(floorPlans!.map((x) => x)),
        "availability": availability,
        "ispublished": ispublished,
        "apartment_amenities": apartmentAmenities == null ? [] : List<dynamic>.from(apartmentAmenities!.map((x) => x)),
        "fields_apartments_photos": fieldsApartmentsPhotos,
        "intro_image": introImage,
        "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    };
}

class Update {
    int? id;
    DateTime? dateTime;
    int? project;
    String? status;
    dynamic photos;
    String? introImages;
    int? ispublished;
    DateTime? dateOfUpdate;
    List<String>? images;
    String? youtubeLink;
    String? description;

    Update({
        this.id,
        this.dateTime,
        this.project,
        this.status,
        this.photos,
        this.introImages,
        this.ispublished,
        this.dateOfUpdate,
        this.images,
        this.youtubeLink,
        this.description,
    });

    factory Update.fromJson(Map<String, dynamic> json) => Update(
        id: json["id"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        project: json["project"],
        status: json["status"],
        photos: json["photos"],
        introImages: json["intro_images"],
        ispublished: json["ispublished"],
        dateOfUpdate: json["date_of_update"] == null ? null : DateTime.parse(json["date_of_update"]),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        youtubeLink: json["youtube_link"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "project": project,
        "status": status,
        "photos": photos,
        "intro_images": introImages,
        "ispublished": ispublished,
        "date_of_update": dateOfUpdate?.toIso8601String(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "youtube_link": youtubeLink,
        "description": description,
    };
}

