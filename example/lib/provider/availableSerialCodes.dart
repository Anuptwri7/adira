
import 'dart:developer';

import 'package:classic_simra/Assets/availableCode/model.dart';
import 'package:classic_simra/Assets/availableCode/services.dart';
import 'package:flutter/cupertino.dart';

import '../Assets/assetItem/categoryModel.dart';
import '../Assets/category/services.dart';

class AvailableSerialCodes extends ChangeNotifier {

  Codes codes = Codes();
  List<ResultCodes> _allCategory = [];

  List<ResultCodes> get allCategory => [..._allCategory];

  Future fetchAllAvailableCode(itemId) async {
log(itemId.toString());
    _allCategory = [];
    List<ResultCodes> fetchAllAvailableCodeList = [];

    final result = await codes.fetchAvailableCodes(itemId);

    // ResultCategory itemListModel = ResultCategory.fromJson(result);

    result['results'].forEach(
          (element) {
        fetchAllAvailableCodeList.add(
          ResultCodes.fromJson(element),

        );
      },
    );
    // log("fteching");

    _allCategory = fetchAllAvailableCodeList;
    notifyListeners();
  }
}
