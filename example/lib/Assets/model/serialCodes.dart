class SerialCode {
  int id;
  String registrationNo;
  List<AssetDetails> assetDetails;

  SerialCode({this.id, this.registrationNo, this.assetDetails});

  SerialCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationNo = json['registration_no'];
    if (json['asset_details'] != null) {
      assetDetails = <AssetDetails>[];
      json['asset_details'].forEach((v) {
        assetDetails.add(new AssetDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registration_no'] = this.registrationNo;
    if (this.assetDetails != null) {
      data['asset_details'] =
          this.assetDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssetDetails {
  String serialNo;
  RfidTag rfidTag;

  AssetDetails({this.serialNo, this.rfidTag});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    serialNo = json['serial_no'];
    rfidTag = json['rfid_tag'] != null
         ?new RfidTag.fromJson(json['rfid_tag'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial_no'] = this.serialNo;
    if (this.rfidTag != null) {
      data['rfid_tag'] = this.rfidTag.toJson();
    }
    return data;
  }
}

class RfidTag {
  int id;
  String code;

  RfidTag({this.id, this.code});

  RfidTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    return data;
  }
}