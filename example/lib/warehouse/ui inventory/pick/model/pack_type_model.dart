// To parse this JSON data, do
//
//     final packTypeList = packTypeListFromJson(jsonString);

import 'dart:convert';

PackTypeList packTypeListFromJson(String str) =>
    PackTypeList.fromJson(json.decode(str));

String packTypeListToJson(PackTypeList data) => json.encode(data.toJson());

class PackTypeList {
  PackTypeList({
     this.count,
     this.next,
     this.previous,
     this.results,
  });

  int count;
  String next;
  String previous;
  List<Result> results;

  factory PackTypeList.fromJson(Map<String, dynamic> json) => PackTypeList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
     this.code,
     this.locationCode,
    this.remainingQty,
  });

  int id;
  String code;
  String locationCode;
  double remainingQty;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      id: json["id"],
      code: json["code"],
      locationCode: json["location_code"],
      remainingQty:json['remaining_qty']
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "location_code": locationCode,
    "remaining_qty":remainingQty
      };
}
