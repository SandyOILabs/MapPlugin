// To parse this JSON data, do
//
//     final getPoi = getPoiFromJson(jsonString);

import 'dart:convert';

GetPoi getPoiFromJson(String? str) => GetPoi.fromJson(json.decode(str!));

String? getPoiToJson(GetPoi data) => json.encode(data.toJson());

class GetPoi {
  GetPoi({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory GetPoi.fromJson(Map<String, dynamic> json) => GetPoi(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.geo,
    this.poiMultilingual,
    this.userId,
    this.offers,
    this.zoom,
    this.natureFlight,
    this.terminal,
    this.naturePresence,
    this.relevance,
    this.keywords,
    this.subcategoryList,
    this.subcategory,
    this.category,
    this.poiUrl,
    this.appname,
    this.sliceid,
    this.levelid,
    this.updated,
    this.lng,
    this.lat,
    this.locationText,
    this.description,
    this.mobileNumber,
    this.email,
    this.name,
  });

  String? id;
  List<double>? geo;
  PoiMultilingual? poiMultilingual;
  String? userId;
  List<dynamic>? offers;
  List<dynamic>? zoom;
  NatureFlight? natureFlight;
  String? terminal;
  NaturePresence? naturePresence;
  List<dynamic>? relevance;
  List<dynamic>? keywords;
  List<dynamic>? subcategoryList;
  String? subcategory;
  Category? category;
  String? poiUrl;
  Appname? appname;
  Sliceid? sliceid;
  String? levelid;
  bool? updated;
  double? lng;
  double? lat;
  String? locationText;
  String? description;
  String? mobileNumber;
  String? email;
  Name? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        geo: List<double>.from(json["geo"].map((x) => x.toDouble())),
        poiMultilingual: PoiMultilingual.fromJson(json["poi_multilingual"]),
        userId: json["user_id"],
        offers: List<dynamic>.from(json["offers"].map((x) => x)),
        zoom: List<dynamic>.from(json["zoom"].map((x) => x)),
        natureFlight: natureFlightValues.map[json["nature_flight"]],
        terminal: json["terminal"],
        naturePresence: naturePresenceValues.map[json["nature_presence"]],
        relevance: List<dynamic>.from(json["relevance"].map((x) => x)),
        keywords: List<dynamic>.from(json["keywords"].map((x) => x)),
        subcategoryList:
            List<dynamic>.from(json["subcategoryList"].map((x) => x)),
        subcategory: json["subcategory"],
        category: categoryValues.map[json["category"]],
        poiUrl: json["poi_url"],
        appname: appnameValues.map[json["appname"]],
        sliceid: sliceidValues.map[json["sliceid"]],
        levelid: json["levelid"],
        updated: json["updated"],
        lng: json["lng"].toDouble(),
        lat: json["lat"].toDouble(),
        locationText: json["location_text"],
        description: json["description"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "geo": List<dynamic>.from(geo!.map((x) => x)),
        "poi_multilingual": poiMultilingual!.toJson(),
        "user_id": userId,
        "offers": List<dynamic>.from(offers!.map((x) => x)),
        "zoom": List<dynamic>.from(zoom!.map((x) => x)),
        "nature_flight": natureFlightValues.reverse![natureFlight],
        "terminal": terminal,
        "nature_presence": naturePresenceValues.reverse![naturePresence],
        "relevance": List<dynamic>.from(relevance!.map((x) => x)),
        "keywords": List<dynamic>.from(keywords!.map((x) => x)),
        "subcategoryList": List<dynamic>.from(subcategoryList!.map((x) => x)),
        "subcategory": subcategory,
        "category": categoryValues.reverse![category],
        "poi_url": poiUrl,
        "appname": appnameValues.reverse![appname],
        "sliceid": sliceidValues.reverse![sliceid],
        "levelid": levelid,
        "updated": updated,
        "lng": lng,
        "lat": lat,
        "location_text": locationText,
        "description": description,
        "mobile_number": mobileNumber,
        "email": email,
        "name": nameValues.reverse![name],
      };
}

enum Appname { BOM }

final appnameValues = EnumValues({"bom": Appname.BOM});

enum Category { FOOD_DRINK, SERVICES, SHOPPING, UTILITIES }

final categoryValues = EnumValues({
  "Food & Drink": Category.FOOD_DRINK,
  "Services": Category.SERVICES,
  "Shopping": Category.SHOPPING,
  "Utilities": Category.UTILITIES
});

enum Name { TYPE_NAMED }

final nameValues = EnumValues({"Type Named": Name.TYPE_NAMED});

enum NatureFlight { I }

final natureFlightValues = EnumValues({"I": NatureFlight.I});

enum NaturePresence { A, D }

final naturePresenceValues =
    EnumValues({"A": NaturePresence.A, "D": NaturePresence.D});

class PoiMultilingual {
  PoiMultilingual({
    this.en,
  });

  En? en;

  factory PoiMultilingual.fromJson(Map<String, dynamic> json) =>
      PoiMultilingual(
        en: En.fromJson(json["en"]),
      );

  Map<String, dynamic> toJson() => {
        "en": en!.toJson(),
      };
}

class En {
  En({
    this.name,
    this.description,
    this.terminal,
  });

  String? name;
  String? description;
  String? terminal;

  factory En.fromJson(Map<String, dynamic> json) => En(
        name: json["name"],
        description: json["description"],
        terminal: json["terminal"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "terminal": terminal,
      };
}

enum Sliceid {
  LEVEL_4_DEPARTURES,
  LEVEL_3_DEPARTURES,
  LEVEL_2_ARRIVALS,
  GROUND_FLOOR,
  LEVEL_1,
  LEVEL_2_FOOD_COURT
}

final sliceidValues = EnumValues({
  "Ground floor": Sliceid.GROUND_FLOOR,
  "Level 1": Sliceid.LEVEL_1,
  "Level 2 arrivals": Sliceid.LEVEL_2_ARRIVALS,
  "Level 2 Food court": Sliceid.LEVEL_2_FOOD_COURT,
  "Level 3 Departures": Sliceid.LEVEL_3_DEPARTURES,
  "Level_4_Departures": Sliceid.LEVEL_4_DEPARTURES
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
