class Detail {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  Detail({this.count, this.next, this.previous, this.results});

  Detail.fromJson(Map<String, dynamic> json) {
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
  String itemName;
  String itemCategoryName;
  String itemUnitName;
  String batchNo;
  List departmentTransferPackingTypes;
  bool itemIsSerializable;
  String pickedByUserName;
  String createdDateAd;
  String createdDateBs;
  int deviceType;
  int appType;
  String purchaseCost;
  String qty;
  String packQty;
  bool expirable;
  Null expiryDateAd;
  String expiryDateBs;
  String netAmount;
  bool isCancelled;
  bool isPicked;
  String remarks;
  int createdBy;
  int departmentTransferMaster;
  int item;
  int itemCategory;
  int packingType;
  int packingTypeDetail;
  int refDepartmentTransferDetail;
  int refPurchaseDetail;
  int pickedBy;

  Results(
      {this.id,
        this.itemName,
        this.itemCategoryName,
        this.itemUnitName,
        this.batchNo,
        this.departmentTransferPackingTypes,
        this.itemIsSerializable,
        this.pickedByUserName,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.purchaseCost,
        this.qty,
        this.packQty,
        this.expirable,
        this.expiryDateAd,
        this.expiryDateBs,
        this.netAmount,
        this.isCancelled,
        this.isPicked,
        this.remarks,
        this.createdBy,
        this.departmentTransferMaster,
        this.item,
        this.itemCategory,
        this.packingType,
        this.packingTypeDetail,
        this.refDepartmentTransferDetail,
        this.refPurchaseDetail,
        this.pickedBy});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCategoryName = json['item_category_name'];
    itemUnitName = json['item_unit_name'];
    batchNo = json['batch_no'];
    itemIsSerializable = json['item_is_serializable'];
    pickedByUserName = json['picked_by_user_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    purchaseCost = json['purchase_cost'];
    qty = json['qty'];
    packQty = json['pack_qty'];
    expirable = json['expirable'];
    expiryDateAd = json['expiry_date_ad'];
    expiryDateBs = json['expiry_date_bs'];
    netAmount = json['net_amount'];
    isCancelled = json['is_cancelled'];
    isPicked = json['is_picked'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    departmentTransferMaster = json['department_transfer_master'];
    item = json['item'];
    itemCategory = json['item_category'];
    packingType = json['packing_type'];
    packingTypeDetail = json['packing_type_detail'];
    refDepartmentTransferDetail = json['ref_department_transfer_detail'];
    refPurchaseDetail = json['ref_purchase_detail'];
    pickedBy = json['picked_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_category_name'] = this.itemCategoryName;
    data['item_unit_name'] = this.itemUnitName;
    data['batch_no'] = this.batchNo;

    data['item_is_serializable'] = this.itemIsSerializable;
    data['picked_by_user_name'] = this.pickedByUserName;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['purchase_cost'] = this.purchaseCost;
    data['qty'] = this.qty;
    data['pack_qty'] = this.packQty;
    data['expirable'] = this.expirable;
    data['expiry_date_ad'] = this.expiryDateAd;
    data['expiry_date_bs'] = this.expiryDateBs;
    data['net_amount'] = this.netAmount;
    data['is_cancelled'] = this.isCancelled;
    data['is_picked'] = this.isPicked;
    data['remarks'] = this.remarks;
    data['created_by'] = this.createdBy;
    data['department_transfer_master'] = this.departmentTransferMaster;
    data['item'] = this.item;
    data['item_category'] = this.itemCategory;
    data['packing_type'] = this.packingType;
    data['packing_type_detail'] = this.packingTypeDetail;
    data['ref_department_transfer_detail'] = this.refDepartmentTransferDetail;
    data['ref_purchase_detail'] = this.refPurchaseDetail;
    data['picked_by'] = this.pickedBy;
    return data;
  }
}