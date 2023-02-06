class AssetDispatchReturn {
  int _count;
  Null _next;
  Null _previous;
  List<Results> _results;

  AssetDispatchReturn(
      {int count, Null next, Null previous, List<Results> results}) {
    this._count = count;
    this._next = next;
    this._previous = previous;
    this._results = results;
  }

  int get count => _count;
  set count(int count) => _count = count;
  Null get next => _next;
  set next(Null next) => _next = next;
  Null get previous => _previous;
  set previous(Null previous) => _previous = previous;
  List<Results> get results => _results;
  set results(List<Results> results) => _results = results;

  AssetDispatchReturn.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _results = new List<Results>();
      json['results'].forEach((v) {
        _results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['next'] = this._next;
    data['previous'] = this._previous;
    if (this._results != null) {
      data['results'] = this._results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int _id;
  String _dispatchInfoDisplay;
  String _dispatchTypeDisplay;
  Null _dispatchSubTypeDisplay;
  String _dispatchToUserName;
  String _dispatchByUserName;
  String _createdByUserName;
  String _createdDateAd;
  String _createdDateBs;
  int _deviceType;
  int _appType;
  String _receiverName;
  String _receiverIdNo;
  String _dispatchNo;
  int _dispatchType;
  int _dispatchInfo;
  Null _dispatchSubType;
  String _remarks;
  int _createdBy;
  int _dispatchBy;
  int _returnedBy;
  int _dispatchTo;
  int _refDispatch;

  Results(
      {int id,
        String dispatchInfoDisplay,
        String dispatchTypeDisplay,
        Null dispatchSubTypeDisplay,
        String dispatchToUserName,
        String dispatchByUserName,
        String createdByUserName,
        String createdDateAd,
        String createdDateBs,
        int deviceType,
        int appType,
        String receiverName,
        String receiverIdNo,
        String dispatchNo,
        int dispatchType,
        int dispatchInfo,
        Null dispatchSubType,
        String remarks,
        int createdBy,
        int dispatchBy,
        int returnedBy,
        int dispatchTo,
        int refDispatch}) {
    this._id = id;
    this._dispatchInfoDisplay = dispatchInfoDisplay;
    this._dispatchTypeDisplay = dispatchTypeDisplay;
    this._dispatchSubTypeDisplay = dispatchSubTypeDisplay;
    this._dispatchToUserName = dispatchToUserName;
    this._dispatchByUserName = dispatchByUserName;
    this._createdByUserName = createdByUserName;
    this._createdDateAd = createdDateAd;
    this._createdDateBs = createdDateBs;
    this._deviceType = deviceType;
    this._appType = appType;
    this._receiverName = receiverName;
    this._receiverIdNo = receiverIdNo;
    this._dispatchNo = dispatchNo;
    this._dispatchType = dispatchType;
    this._dispatchInfo = dispatchInfo;
    this._dispatchSubType = dispatchSubType;
    this._remarks = remarks;
    this._createdBy = createdBy;
    this._dispatchBy = dispatchBy;
    this._returnedBy = returnedBy;
    this._dispatchTo = dispatchTo;
    this._refDispatch = refDispatch;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get dispatchInfoDisplay => _dispatchInfoDisplay;
  set dispatchInfoDisplay(String dispatchInfoDisplay) =>
      _dispatchInfoDisplay = dispatchInfoDisplay;
  String get dispatchTypeDisplay => _dispatchTypeDisplay;
  set dispatchTypeDisplay(String dispatchTypeDisplay) =>
      _dispatchTypeDisplay = dispatchTypeDisplay;
  Null get dispatchSubTypeDisplay => _dispatchSubTypeDisplay;
  set dispatchSubTypeDisplay(Null dispatchSubTypeDisplay) =>
      _dispatchSubTypeDisplay = dispatchSubTypeDisplay;
  String get dispatchToUserName => _dispatchToUserName;
  set dispatchToUserName(String dispatchToUserName) =>
      _dispatchToUserName = dispatchToUserName;
  String get dispatchByUserName => _dispatchByUserName;
  set dispatchByUserName(String dispatchByUserName) =>
      _dispatchByUserName = dispatchByUserName;
  String get createdByUserName => _createdByUserName;
  set createdByUserName(String createdByUserName) =>
      _createdByUserName = createdByUserName;
  String get createdDateAd => _createdDateAd;
  set createdDateAd(String createdDateAd) => _createdDateAd = createdDateAd;
  String get createdDateBs => _createdDateBs;
  set createdDateBs(String createdDateBs) => _createdDateBs = createdDateBs;
  int get deviceType => _deviceType;
  set deviceType(int deviceType) => _deviceType = deviceType;
  int get appType => _appType;
  set appType(int appType) => _appType = appType;
  String get receiverName => _receiverName;
  set receiverName(String receiverName) => _receiverName = receiverName;
  String get receiverIdNo => _receiverIdNo;
  set receiverIdNo(String receiverIdNo) => _receiverIdNo = receiverIdNo;
  String get dispatchNo => _dispatchNo;
  set dispatchNo(String dispatchNo) => _dispatchNo = dispatchNo;
  int get dispatchType => _dispatchType;
  set dispatchType(int dispatchType) => _dispatchType = dispatchType;
  int get dispatchInfo => _dispatchInfo;
  set dispatchInfo(int dispatchInfo) => _dispatchInfo = dispatchInfo;
  Null get dispatchSubType => _dispatchSubType;
  set dispatchSubType(Null dispatchSubType) =>
      _dispatchSubType = dispatchSubType;
  String get remarks => _remarks;
  set remarks(String remarks) => _remarks = remarks;
  int get createdBy => _createdBy;
  set createdBy(int createdBy) => _createdBy = createdBy;
  int get dispatchBy => _dispatchBy;
  set dispatchBy(int dispatchBy) => _dispatchBy = dispatchBy;
  int get returnedBy => _returnedBy;
  set returnedBy(int returnedBy) => _returnedBy = returnedBy;
  int get dispatchTo => _dispatchTo;
  set dispatchTo(int dispatchTo) => _dispatchTo = dispatchTo;
  int get refDispatch => _refDispatch;
  set refDispatch(int refDispatch) => _refDispatch = refDispatch;

  Results.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _dispatchInfoDisplay = json['dispatch_info_display'];
    _dispatchTypeDisplay = json['dispatch_type_display'];
    _dispatchSubTypeDisplay = json['dispatch_sub_type_display'];
    _dispatchToUserName = json['dispatch_to_user_name'];
    _dispatchByUserName = json['dispatch_by_user_name'];
    _createdByUserName = json['created_by_user_name'];
    _createdDateAd = json['created_date_ad'];
    _createdDateBs = json['created_date_bs'];
    _deviceType = json['device_type'];
    _appType = json['app_type'];
    _receiverName = json['receiver_name'];
    _receiverIdNo = json['receiver_id_no'];
    _dispatchNo = json['dispatch_no'];
    _dispatchType = json['dispatch_type'];
    _dispatchInfo = json['dispatch_info'];
    _dispatchSubType = json['dispatch_sub_type'];
    _remarks = json['remarks'];
    _createdBy = json['created_by'];
    _dispatchBy = json['dispatch_by'];
    _returnedBy = json['returned_by'];
    _dispatchTo = json['dispatch_to'];
    _refDispatch = json['ref_dispatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['dispatch_info_display'] = this._dispatchInfoDisplay;
    data['dispatch_type_display'] = this._dispatchTypeDisplay;
    data['dispatch_sub_type_display'] = this._dispatchSubTypeDisplay;
    data['dispatch_to_user_name'] = this._dispatchToUserName;
    data['dispatch_by_user_name'] = this._dispatchByUserName;
    data['created_by_user_name'] = this._createdByUserName;
    data['created_date_ad'] = this._createdDateAd;
    data['created_date_bs'] = this._createdDateBs;
    data['device_type'] = this._deviceType;
    data['app_type'] = this._appType;
    data['receiver_name'] = this._receiverName;
    data['receiver_id_no'] = this._receiverIdNo;
    data['dispatch_no'] = this._dispatchNo;
    data['dispatch_type'] = this._dispatchType;
    data['dispatch_info'] = this._dispatchInfo;
    data['dispatch_sub_type'] = this._dispatchSubType;
    data['remarks'] = this._remarks;
    data['created_by'] = this._createdBy;
    data['dispatch_by'] = this._dispatchBy;
    data['returned_by'] = this._returnedBy;
    data['dispatch_to'] = this._dispatchTo;
    data['ref_dispatch'] = this._refDispatch;
    return data;
  }
}