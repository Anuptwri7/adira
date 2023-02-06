class AssetSummary {
  int count;
  Null next;
  Null previous;
  List<ResultsSummary> results;

  AssetSummary({this.count, this.next, this.previous, this.results});

  AssetSummary.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<ResultsSummary>();
      json['results'].forEach((v) {
        results.add(new ResultsSummary.fromJson(v));
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

class ResultsSummary {
  int id;
  List<AssetDispatchInfo> assetDispatchInfo;
  String createdByUserName;
  String itemName;
  int itemCategory;
  String itemCategoryName;
  double remainingReturnableQty;
  int assetDispatchInfoCount;
  String qty;
  bool picked;
  int createdBy;
  int assetDispatch;
  int item;
  int pickedBy;
  Null refDispatchDetail;

  ResultsSummary(
      {this.id,
        this.assetDispatchInfo,
        this.createdByUserName,
        this.itemName,
        this.itemCategory,
        this.itemCategoryName,
        this.remainingReturnableQty,
        this.assetDispatchInfoCount,
        this.qty,
        this.picked,
        this.createdBy,
        this.assetDispatch,
        this.item,
        this.pickedBy,
        this.refDispatchDetail});

  ResultsSummary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['asset_dispatch_info'] != null) {
      assetDispatchInfo = new List<AssetDispatchInfo>();
      json['asset_dispatch_info'].forEach((v) {
        assetDispatchInfo.add(new AssetDispatchInfo.fromJson(v));
      });
    }
    createdByUserName = json['created_by_user_name'];
    itemName = json['item_name'];
    itemCategory = json['item_category'];
    itemCategoryName = json['item_category_name'];
    remainingReturnableQty = json['remaining_returnable_qty'];
    assetDispatchInfoCount = json['asset_dispatch_info_count'];
    qty = json['qty'];
    picked = json['picked'];
    createdBy = json['created_by'];
    assetDispatch = json['asset_dispatch'];
    item = json['item'];
    pickedBy = json['picked_by'];
    refDispatchDetail = json['ref_dispatch_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.assetDispatchInfo != null) {
      data['asset_dispatch_info'] =
          this.assetDispatchInfo.map((v) => v.toJson()).toList();
    }
    data['created_by_user_name'] = this.createdByUserName;
    data['item_name'] = this.itemName;
    data['item_category'] = this.itemCategory;
    data['item_category_name'] = this.itemCategoryName;
    data['remaining_returnable_qty'] = this.remainingReturnableQty;
    data['asset_dispatch_info_count'] = this.assetDispatchInfoCount;
    data['qty'] = this.qty;
    data['picked'] = this.picked;
    data['created_by'] = this.createdBy;
    data['asset_dispatch'] = this.assetDispatch;
    data['item'] = this.item;
    data['picked_by'] = this.pickedBy;
    data['ref_dispatch_detail'] = this.refDispatchDetail;
    return data;
  }
}

class AssetDispatchInfo {
  int id;
  int asset;
  String serialNo;
  int packingTypeCodeId;
  RfidTag rfidTag;
  String createdDateAd;
  String createdDateBs;
  int createdBy;
  int assetDetail;
  int assetDispatchDetail;
  Null refDispatchDetailInfo;

  AssetDispatchInfo(
      {this.id,
        this.asset,
        this.serialNo,
        this.packingTypeCodeId,
        this.rfidTag,
        this.createdDateAd,
        this.createdDateBs,
        this.createdBy,
        this.assetDetail,
        this.assetDispatchDetail,
        this.refDispatchDetailInfo});

  AssetDispatchInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asset = json['asset'];
    serialNo = json['serial_no'];
    packingTypeCodeId = json['packing_type_code_id'];
    rfidTag = json['rfid_tag'] != null
        ? new RfidTag.fromJson(json['rfid_tag'])
        : null;
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    createdBy = json['created_by'];
    assetDetail = json['asset_detail'];
    assetDispatchDetail = json['asset_dispatch_detail'];
    refDispatchDetailInfo = json['ref_dispatch_detail_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['asset'] = this.asset;
    data['serial_no'] = this.serialNo;
    data['packing_type_code_id'] = this.packingTypeCodeId;
    if (this.rfidTag != null) {
      data['rfid_tag'] = this.rfidTag.toJson();
    }
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['created_by'] = this.createdBy;
    data['asset_detail'] = this.assetDetail;
    data['asset_dispatch_detail'] = this.assetDispatchDetail;
    data['ref_dispatch_detail_info'] = this.refDispatchDetailInfo;
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