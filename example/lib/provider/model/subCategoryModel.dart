// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  SubCategory({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<ResultSubCategory> results;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<ResultSubCategory>.from(json["results"].map((x) => ResultSubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultSubCategory {
  ResultSubCategory({
    this.id,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.name,
    this.active,
    this.createdBy,
    this.assetCategory,
  });

  int id;
  DateTime createdDateAd;
  DateTime createdDateBs;
  int deviceType;
  int appType;
  String name;
  bool active;
  int createdBy;
  AssetCategory assetCategory;

  factory ResultSubCategory.fromJson(Map<String, dynamic> json) => ResultSubCategory(
    id: json["id"],
    createdDateAd: DateTime.parse(json["created_date_ad"]),
    createdDateBs: DateTime.parse(json["created_date_bs"]),
    deviceType: json["device_type"],
    appType: json["app_type"],
    name: json["name"],
    active: json["active"],
    createdBy: json["created_by"],
    assetCategory: AssetCategory.fromJson(json["asset_category"]),
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
    "asset_category": assetCategory.toJson(),
  };
}

class AssetCategory {
  AssetCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory AssetCategory.fromJson(Map<String, dynamic> json) => AssetCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
