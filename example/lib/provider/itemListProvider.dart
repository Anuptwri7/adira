
import 'package:classic_simra/Assets/assetItem/model.dart';

import 'package:flutter/cupertino.dart';

import '../Assets/assetItem/services.dart';




class ItemListProvider extends ChangeNotifier {
  List<Result> _allItem = [];

  List<Result> get allItem => [..._allItem];

  Future<void> fetchAllItem(BuildContext context) async {
    _allItem = [];
    List<Result> fetchAllItemList = [];

    final result = await fetchAssetItems();

    Result itemListModel = Result.fromJson(result);

    result['results'].forEach(
      (element) {
        fetchAllItemList.add(
          Result.fromJson(element),
        );
      },
    );
    _allItem = fetchAllItemList;
    notifyListeners();
  }
}
