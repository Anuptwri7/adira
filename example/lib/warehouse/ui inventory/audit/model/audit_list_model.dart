// To parse this JSON data, do
//
//     final auditGetData = auditGetDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AuditGetData auditGetDataFromJson(String str) => AuditGetData.fromJson(json.decode(str));

String auditGetDataToJson(AuditGetData data) => json.encode(data.toJson());

class AuditGetData {
  AuditGetData({
     this.count,
     this.next,
     this.previous,
     this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory AuditGetData.fromJson(Map<String, dynamic> json) => AuditGetData(
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
     this.auditNo,
     this.remarks,
     this.isFinished,
     this.auditDetails,
  });

  int id;
  String auditNo;
  String remarks;
  bool isFinished;
  List<dynamic> auditDetails;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    auditNo: json["audit_no"],
    remarks: json["remarks"],
    isFinished: json["is_finished"],
    auditDetails: List<dynamic>.from(json["audit_details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "audit_no": auditNo,
    "remarks": remarks,
    "is_finished": isFinished,
    "audit_details": List<dynamic>.from(auditDetails.map((x) => x)),
  };
}
