class AssetDispatch {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  AssetDispatch({this.count, this.next, this.previous, this.results});

  AssetDispatch.fromJson(Map<String, dynamic> json) {
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
  List<AssetDispatches> assetDispatches;
  String dispatchInfoDisplay;
  String dispatchTypeDisplay;
  String dispatchSubTypeDisplay;
  String dispatchToUserName;
  String dispatchByUserName;
  String createdByUserName;
  String createdDateAd;
  String createdDateBs;
  int deviceType;
  int appType;
  String receiverName;
  String receiverIdNo;
  String dispatchNo;
  int dispatchType;
  int dispatchInfo;
  int dispatchSubType;
  String remarks;
  int createdBy;
  int dispatchBy;
  Null returnedBy;
  int dispatchTo;
  Null refDispatch;

  Results(
      {this.id,
        this.assetDispatches,
        this.dispatchInfoDisplay,
        this.dispatchTypeDisplay,
        this.dispatchSubTypeDisplay,
        this.dispatchToUserName,
        this.dispatchByUserName,
        this.createdByUserName,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.receiverName,
        this.receiverIdNo,
        this.dispatchNo,
        this.dispatchType,
        this.dispatchInfo,
        this.dispatchSubType,
        this.remarks,
        this.createdBy,
        this.dispatchBy,
        this.returnedBy,
        this.dispatchTo,
        this.refDispatch});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['asset_dispatches'] != null) {
      assetDispatches = new List<AssetDispatches>();
      json['asset_dispatches'].forEach((v) {
        assetDispatches.add(new AssetDispatches.fromJson(v));
      });
    }
    dispatchInfoDisplay = json['dispatch_info_display'];
    dispatchTypeDisplay = json['dispatch_type_display'];
    dispatchSubTypeDisplay = json['dispatch_sub_type_display'];
    dispatchToUserName = json['dispatch_to_user_name'];
    dispatchByUserName = json['dispatch_by_user_name'];
    createdByUserName = json['created_by_user_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    receiverName = json['receiver_name'];
    receiverIdNo = json['receiver_id_no'];
    dispatchNo = json['dispatch_no'];
    dispatchType = json['dispatch_type'];
    dispatchInfo = json['dispatch_info'];
    dispatchSubType = json['dispatch_sub_type'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    dispatchBy = json['dispatch_by'];
    returnedBy = json['returned_by'];
    dispatchTo = json['dispatch_to'];
    refDispatch = json['ref_dispatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.assetDispatches != null) {
      data['asset_dispatches'] =
          this.assetDispatches.map((v) => v.toJson()).toList();
    }
    data['dispatch_info_display'] = this.dispatchInfoDisplay;
    data['dispatch_type_display'] = this.dispatchTypeDisplay;
    data['dispatch_sub_type_display'] = this.dispatchSubTypeDisplay;
    data['dispatch_to_user_name'] = this.dispatchToUserName;
    data['dispatch_by_user_name'] = this.dispatchByUserName;
    data['created_by_user_name'] = this.createdByUserName;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['receiver_name'] = this.receiverName;
    data['receiver_id_no'] = this.receiverIdNo;
    data['dispatch_no'] = this.dispatchNo;
    data['dispatch_type'] = this.dispatchType;
    data['dispatch_info'] = this.dispatchInfo;
    data['dispatch_sub_type'] = this.dispatchSubType;
    data['remarks'] = this.remarks;
    data['created_by'] = this.createdBy;
    data['dispatch_by'] = this.dispatchBy;
    data['returned_by'] = this.returnedBy;
    data['dispatch_to'] = this.dispatchTo;
    data['ref_dispatch'] = this.refDispatch;
    return data;
  }
}

class AssetDispatches {
  int id;
  List<AssetDispatchInfo> assetDispatchInfo;
  String createdByUserName;
  String itemName;
  int itemCategory;
  String itemCategoryName;
  String qty;
  bool picked;
  int createdBy;
  int assetDispatch;
  int item;
  Null pickedBy;
  Null refDispatchDetail;

  AssetDispatches(
      {this.id,
        this.assetDispatchInfo,
        this.createdByUserName,
        this.itemName,
        this.itemCategory,
        this.itemCategoryName,
        this.qty,
        this.picked,
        this.createdBy,
        this.assetDispatch,
        this.item,
        this.pickedBy,
        this.refDispatchDetail});

  AssetDispatches.fromJson(Map<String, dynamic> json) {
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
  String createdDateAd;
  String createdDateBs;
  int deviceType;
  int appType;
  int createdBy;
  int assetDetail;
  int assetDispatchDetail;
  Null refDispatchDetailInfo;

  AssetDispatchInfo(
      {this.id,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.createdBy,
        this.assetDetail,
        this.assetDispatchDetail,
        this.refDispatchDetailInfo});

  AssetDispatchInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    createdBy = json['created_by'];
    assetDetail = json['asset_detail'];
    assetDispatchDetail = json['asset_dispatch_detail'];
    refDispatchDetailInfo = json['ref_dispatch_detail_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['created_by'] = this.createdBy;
    data['asset_detail'] = this.assetDetail;
    data['asset_dispatch_detail'] = this.assetDispatchDetail;
    data['ref_dispatch_detail_info'] = this.refDispatchDetailInfo;
    return data;
  }
}