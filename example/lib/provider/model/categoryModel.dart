// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.name,
    this.active,
    this.createdBy,
  });

  int id;
  DateTime createdDateAd;
  DateTime createdDateBs;
  int deviceType;
  int appType;
  String name;
  bool active;
  int createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    createdDateAd: DateTime.parse(json["created_date_ad"]),
    createdDateBs: DateTime.parse(json["created_date_bs"]),
    deviceType: json["device_type"],
    appType: json["app_type"],
    name: json["name"],
    active: json["active"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_date_ad": createdDateAd.toIso8601String(),
    "created_date_bs": "${createdDateBs.year.toString().padLeft(4, '0')}-${createdDateBs.month.toString().padLeft(2, '0')}-${createdDateBs.day.toString().padLeft(2, '0')}",
    "device_type": deviceType,
    "app_type": appType,
    "name": name,
    "active": active,
    "created_by": createdBy,
  };
}
