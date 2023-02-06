class TaskPickupModel {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  TaskPickupModel({this.count, this.next, this.previous, this.results});

  TaskPickupModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
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
  List<TaskLotPackingTypeCodes> taskLotPackingTypeCodes;
  String itemName;
  String itemCode;
  String itemCategoryName;
  String itemUnitName;
  String batchNo;
  bool itemIsSerializable;
  String pickedByUserName;
  String createdDateAd;
  String createdDateBs;
  String qty;
  bool picked;
  bool isCancelled;
  int createdBy;
  int lotMain;
  int taskDetail;
  int item;
  int pickedBy;
  int purchaseDetail;

  Results(
      {this.id,
        this.taskLotPackingTypeCodes,
        this.itemName,
        this.itemCode,
        this.itemCategoryName,
        this.itemUnitName,
        this.batchNo,
        this.itemIsSerializable,
        this.pickedByUserName,
        this.createdDateAd,
        this.createdDateBs,
        this.qty,
        this.picked,
        this.isCancelled,
        this.createdBy,
        this.lotMain,
        this.taskDetail,
        this.item,
        this.pickedBy,
        this.purchaseDetail});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['task_lot_packing_type_codes'] != null) {
      taskLotPackingTypeCodes = <TaskLotPackingTypeCodes>[];
      json['task_lot_packing_type_codes'].forEach((v) {
        taskLotPackingTypeCodes.add(new TaskLotPackingTypeCodes.fromJson(v));
      });
    }
    itemName = json['item_name'];
    itemCode = json['item_code'];
    itemCategoryName = json['item_category_name'];
    itemUnitName = json['item_unit_name'];
    batchNo = json['batch_no'];
    itemIsSerializable = json['item_is_serializable'];
    pickedByUserName = json['picked_by_user_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    qty = json['qty'];
    picked = json['picked'];
    isCancelled = json['is_cancelled'];
    createdBy = json['created_by'];
    lotMain = json['lot_main'];
    taskDetail = json['task_detail'];
    item = json['item'];
    pickedBy = json['picked_by'];
    purchaseDetail = json['purchase_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.taskLotPackingTypeCodes != null) {
      data['task_lot_packing_type_codes'] =
          this.taskLotPackingTypeCodes.map((v) => v.toJson()).toList();
    }
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['item_category_name'] = this.itemCategoryName;
    data['item_unit_name'] = this.itemUnitName;
    data['batch_no'] = this.batchNo;
    data['item_is_serializable'] = this.itemIsSerializable;
    data['picked_by_user_name'] = this.pickedByUserName;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['qty'] = this.qty;
    data['picked'] = this.picked;
    data['is_cancelled'] = this.isCancelled;
    data['created_by'] = this.createdBy;
    data['lot_main'] = this.lotMain;
    data['task_detail'] = this.taskDetail;
    data['item'] = this.item;
    data['picked_by'] = this.pickedBy;
    data['purchase_detail'] = this.purchaseDetail;
    return data;
  }
}

class TaskLotPackingTypeCodes {
  int id;
  String locationCode;
  int location;
  String code;
  String qty;
  Null saleDetail;
  int packingTypeCode;
  List<Null> salePackingTypeDetailCode;

  TaskLotPackingTypeCodes(
      {this.id,
        this.locationCode,
        this.location,
        this.code,
        this.qty,
        this.saleDetail,
        this.packingTypeCode,
        this.salePackingTypeDetailCode});

  TaskLotPackingTypeCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationCode = json['location_code'];
    location = json['location'];
    code = json['code'];
    qty = json['qty'];
    saleDetail = json['sale_detail'];
    packingTypeCode = json['packing_type_code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_code'] = this.locationCode;
    data['location'] = this.location;
    data['code'] = this.code;
    data['qty'] = this.qty;
    data['sale_detail'] = this.saleDetail;
    data['packing_type_code'] = this.packingTypeCode;

    return data;
  }
}