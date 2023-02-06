// To parse this JSON data, do
//
//     final enrollAssets = enrollAssetsFromJson(jsonString);

import 'dart:convert';

EnrollAssets enrollAssetsFromJson(String str) => EnrollAssets.fromJson(json.decode(str));

String enrollAssetsToJson(EnrollAssets data) => json.encode(data.toJson());

class EnrollAssets {
  EnrollAssets({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory EnrollAssets.fromJson(Map<String, dynamic> json) => EnrollAssets(
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
    this.name,
    this.purchaseCost,
  });

  int id;
  String name;
  String purchaseCost;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    purchaseCost: json["purchase_cost"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "purchase_cost": purchaseCost,
  };
}
