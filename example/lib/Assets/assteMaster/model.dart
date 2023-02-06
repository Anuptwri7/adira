class AssetMaster {
  int count;
  String next;
  Null previous;
  List<Results> results;

  AssetMaster({this.count, this.next, this.previous, this.results});

  AssetMaster.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  List<AssetDetails> assetDetails;
  String assetItemName;
  String assetCategoryName;
  String assetSubCategoryName;
  String assetItemManufacturerName;
  String assetItemModelNo;
  Null assetLocationCode;
  bool issued;
  String createdDateAd;
  String createdDateBs;
  int deviceType;
  int appType;
  String registrationNo;
  bool scrapped;
  bool available;
  int qty;
  String adjustedBookValue;
  String netValue;
  String remarks;
  String salvageValue;
  String depreciationRate;
  String amcRate;
  int depreciationMethod;
  int endOfLifeInYears;
  String warrantyDuration;
  String maintenanceDuration;
  int createdBy;
  int category;
  int subCategory;
  int item;

  Results(
      {this.id,
        this.assetDetails,
        this.assetItemName,
        this.assetCategoryName,
        this.assetSubCategoryName,
        this.assetItemManufacturerName,
        this.assetItemModelNo,
        this.assetLocationCode,
        this.issued,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.registrationNo,
        this.scrapped,
        this.available,
        this.qty,
        this.adjustedBookValue,
        this.netValue,
        this.remarks,
        this.salvageValue,
        this.depreciationRate,
        this.amcRate,
        this.depreciationMethod,
        this.endOfLifeInYears,
        this.warrantyDuration,
        this.maintenanceDuration,
        this.createdBy,
        this.category,
        this.subCategory,
        this.item});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['asset_details'] != null) {
      assetDetails = new List<AssetDetails>();
      json['asset_details'].forEach((v) {
        assetDetails.add(new AssetDetails.fromJson(v));
      });
    }
    assetItemName = json['asset_item_name'];
    assetCategoryName = json['asset_category_name'];
    assetSubCategoryName = json['asset_sub_category_name'];
    assetItemManufacturerName = json['asset_item_manufacturer_name'];
    assetItemModelNo = json['asset_item_model_no'];
    assetLocationCode = json['asset_location_code'];
    issued = json['issued'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    registrationNo = json['registration_no'];
    scrapped = json['scrapped'];
    available = json['available'];
    qty = json['qty'];
    adjustedBookValue = json['adjusted_book_value'];
    netValue = json['net_value'];
    remarks = json['remarks'];
    salvageValue = json['salvage_value'];
    depreciationRate = json['depreciation_rate'];
    amcRate = json['amc_rate'];
    depreciationMethod = json['depreciation_method'];
    endOfLifeInYears = json['end_of_life_in_years'];
    warrantyDuration = json['warranty_duration'];
    maintenanceDuration = json['maintenance_duration'];
    createdBy = json['created_by'];
    category = json['category'];
    subCategory = json['sub_category'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.assetDetails != null) {
      data['asset_details'] = this.assetDetails.map((v) => v.toJson()).toList();
    }
    data['asset_item_name'] = this.assetItemName;
    data['asset_category_name'] = this.assetCategoryName;
    data['asset_sub_category_name'] = this.assetSubCategoryName;
    data['asset_item_manufacturer_name'] = this.assetItemManufacturerName;
    data['asset_item_model_no'] = this.assetItemModelNo;
    data['asset_location_code'] = this.assetLocationCode;
    data['issued'] = this.issued;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['registration_no'] = this.registrationNo;
    data['scrapped'] = this.scrapped;
    data['available'] = this.available;
    data['qty'] = this.qty;
    data['adjusted_book_value'] = this.adjustedBookValue;
    data['net_value'] = this.netValue;
    data['remarks'] = this.remarks;
    data['salvage_value'] = this.salvageValue;
    data['depreciation_rate'] = this.depreciationRate;
    data['amc_rate'] = this.amcRate;
    data['depreciation_method'] = this.depreciationMethod;
    data['end_of_life_in_years'] = this.endOfLifeInYears;
    data['warranty_duration'] = this.warrantyDuration;
    data['maintenance_duration'] = this.maintenanceDuration;
    data['created_by'] = this.createdBy;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['item'] = this.item;
    return data;
  }
}

class AssetDetails {
  int id;
  String serialNo;
  double purchaseCost;
  String purchaseDate;
  String assetSupplierName;
  double depreciationAmountTillNow;
  double depreciationAmountYearly;
  double assetCurrentValue;
  String createdDateAd;
  String createdDateBs;
  int deviceType;
  int appType;
  int createdBy;
  int packingTypeDetailCode;
  int location;

  AssetDetails(
      {this.id,
        this.serialNo,
        this.purchaseCost,
        this.purchaseDate,
        this.assetSupplierName,
        this.depreciationAmountTillNow,
        this.depreciationAmountYearly,
        this.assetCurrentValue,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.createdBy,
        this.packingTypeDetailCode,
        this.location});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    purchaseCost = json['purchase_cost'];
    purchaseDate = json['purchase_date'];
    assetSupplierName = json['asset_supplier_name'];
    depreciationAmountTillNow = json['depreciation_amount_till_now'];
    depreciationAmountYearly = json['depreciation_amount_yearly'];
    assetCurrentValue = json['asset_current_value'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    createdBy = json['created_by'];
    packingTypeDetailCode = json['packing_type_detail_code'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_no'] = this.serialNo;
    data['purchase_cost'] = this.purchaseCost;
    data['purchase_date'] = this.purchaseDate;
    data['asset_supplier_name'] = this.assetSupplierName;
    data['depreciation_amount_till_now'] = this.depreciationAmountTillNow;
    data['depreciation_amount_yearly'] = this.depreciationAmountYearly;
    data['asset_current_value'] = this.assetCurrentValue;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['created_by'] = this.createdBy;
    data['packing_type_detail_code'] = this.packingTypeDetailCode;
    data['location'] = this.location;
    return data;
  }
}
