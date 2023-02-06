class PackInfoGet {
  int id;
  String serialNo;
  double purchaseCost;
  String purchaseDate;
  String assetSupplierName;
  double depreciationAmountTillNow;
  double depreciationAmountYearly;
  double assetCurrentValue;
  int endOfLifeInYears;
  double amcRate;
  double depreciationRate;
  String locationCode;
  String registrationNo;
  Item item;
  String assetCategoryName;
  String assetSubCategoryName;
  String createdDateAd;
  String createdDateBs;
  int createdBy;
  int asset;
  int packingTypeDetailCode;
  int location;

  PackInfoGet(
      {this.id,
        this.serialNo,
        this.purchaseCost,
        this.purchaseDate,
        this.assetSupplierName,
        this.depreciationAmountTillNow,
        this.depreciationAmountYearly,
        this.assetCurrentValue,
        this.endOfLifeInYears,
        this.amcRate,
        this.depreciationRate,
        this.locationCode,
        this.registrationNo,
        this.item,
        this.assetCategoryName,
        this.assetSubCategoryName,
        this.createdDateAd,
        this.createdDateBs,
        this.createdBy,
        this.asset,
        this.packingTypeDetailCode,
        this.location});

  PackInfoGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    purchaseCost = json['purchase_cost'];
    purchaseDate = json['purchase_date'];
    assetSupplierName = json['asset_supplier_name'];
    depreciationAmountTillNow = json['depreciation_amount_till_now'];
    depreciationAmountYearly = json['depreciation_amount_yearly'];
    assetCurrentValue = json['asset_current_value'];
    endOfLifeInYears = json['end_of_life_in_years'];
    amcRate = json['amc_rate'];
    depreciationRate = json['depreciation_rate'];
    locationCode = json['location_code'];
    registrationNo = json['registration_no'];
    item = json['item'] = null ? new Item.fromJson(json['item']) : null;
    assetCategoryName = json['asset_category_name'];
    assetSubCategoryName = json['asset_sub_category_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    createdBy = json['created_by'];
    asset = json['asset'];
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
    data['end_of_life_in_years'] = this.endOfLifeInYears;
    data['amc_rate'] = this.amcRate;
    data['depreciation_rate'] = this.depreciationRate;
    data['location_code'] = this.locationCode;
    data['registration_no'] = this.registrationNo;
    if (this.item = null) {
      data['item'] = this.item.toJson();
    }
    data['asset_category_name'] = this.assetCategoryName;
    data['asset_sub_category_name'] = this.assetSubCategoryName;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['created_by'] = this.createdBy;
    data['asset'] = this.asset;
    data['packing_type_detail_code'] = this.packingTypeDetailCode;
    data['location'] = this.location;
    return data;
  }
}

class Item {
  int id;
  String name;
  String code;
  int category;
  String categoryName;

  Item({this.id, this.name, this.code, this.category, this.categoryName});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    category = json['category'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    return data;
  }
}