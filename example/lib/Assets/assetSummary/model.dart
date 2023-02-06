// To parse this JSON data, do
//
//     final assetRfidSummary = assetRfidSummaryFromJson(jsonString);

import 'dart:convert';

AssetRfidSummary assetRfidSummaryFromJson(String str) => AssetRfidSummary.fromJson(json.decode(str));

String assetRfidSummaryToJson(AssetRfidSummary data) => json.encode(data.toJson());

class AssetRfidSummary {
  AssetRfidSummary({
    this.id,
    this.registrationNo,
    this.assetDetails,
  });

  int id;
  String registrationNo;
  List<AssetDetail> assetDetails;

  factory AssetRfidSummary.fromJson(Map<String, dynamic> json) => AssetRfidSummary(
    id: json["id"],
    registrationNo: json["registration_no"],
    assetDetails: List<AssetDetail>.from(json["asset_details"].map((x) => AssetDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "registration_no": registrationNo,
    "asset_details": List<dynamic>.from(assetDetails.map((x) => x.toJson())),
  };
}

class AssetDetail {
  AssetDetail({
    this.id,
    this.serialNo,
    this.rfidTagCode,
    this.location,
  });

  int id;
  String serialNo;
  String rfidTagCode;
  dynamic location;

  factory AssetDetail.fromJson(Map<String, dynamic> json) => AssetDetail(
    id: json["id"],
    serialNo: json["serial_no"],
    rfidTagCode: json["rfid_tag_code"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serial_no": serialNo,
    "rfid_tag_code": rfidTagCode,
    "location": location,
  };
}
