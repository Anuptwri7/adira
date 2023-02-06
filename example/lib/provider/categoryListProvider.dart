
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../Assets/assetItem/categoryModel.dart';
import '../Assets/category/services.dart';

class CategoryListProvider extends ChangeNotifier {
  List<ResultCategory> _allCategory = [];

  List<ResultCategory> get allCategory => [..._allCategory];

  Future fetchAllCategory() async {

    _allCategory = [];
    List<ResultCategory> fetchAllCategoryList = [];

    final result = await fetchCategory();

    // ResultCategory itemListModel = ResultCategory.fromJson(result);

    result['results'].forEach(
          (element) {
            fetchAllCategoryList.add(
          ResultCategory.fromJson(element),

        );
      },
    );
    // log("fteching");

    _allCategory = fetchAllCategoryList;
    notifyListeners();
  }
}
