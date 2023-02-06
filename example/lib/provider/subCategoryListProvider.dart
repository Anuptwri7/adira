
import 'dart:developer';

import 'package:classic_simra/Assets/subCategory/services.dart';
import 'package:classic_simra/provider/model/subCategoryModel.dart';
import 'package:flutter/cupertino.dart';


class SubCategoryListProvider extends ChangeNotifier {

  SubCategoryClass subCategoryClass = SubCategoryClass();
  List<ResultSubCategory> _allSubCategory = [];

  List<ResultSubCategory> get allSubCategory => [..._allSubCategory];

  Future<void> fetchAllCategory(int categoryId) async {

    _allSubCategory = [];
    List<ResultSubCategory> fetchAllSubCategory = [];

    final result = await subCategoryClass.fetchSubCategory(categoryId);

    // ResultSubCategory itemListModel = ResultSubCategory.fromJson(result);

    result['results'].forEach(
          (element) {
        fetchAllSubCategory.add(
          ResultSubCategory.fromJson(element),

        );
      },
    );
    // log("fteching");

    _allSubCategory = fetchAllSubCategory;
    notifyListeners();
  }
}
