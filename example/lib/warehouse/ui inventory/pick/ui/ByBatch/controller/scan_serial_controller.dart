import 'package:flutter/cupertino.dart';

class SerialController with ChangeNotifier {
  List<String> serialCode = [];
  List<String> serialId = [];
  var customer_packing_types = [];
  List<String> scannnedPK = [];

  updateSerialCode({ List<String> newSerialCode}) {
    serialCode = newSerialCode;
    notifyListeners();
  }

  updateSerialId({ List<String> newSerialId}) {
    serialId = newSerialId;
    notifyListeners();
  }

  updatePackId(
      { String Id,
       List<dynamic> sale_packing_type_detail_code}) {
    customer_packing_types.add({
      "packing_type_code": Id,
      "sale_packing_type_detail_code": sale_packing_type_detail_code
    });

    notifyListeners();
  }

  updateIndex({ String pk}) {
    scannnedPK.add(pk);
    notifyListeners();
  }
}
