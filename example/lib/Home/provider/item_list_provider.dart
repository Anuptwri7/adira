import 'package:flutter/cupertino.dart';

import '../model/item_model.dart';
import '../services/customer_api.dart';

class CustomerItemListProvider extends ChangeNotifier {
  List<ItemModel> _allItem = [];

  List<ItemModel> get allItem => [..._allItem];

  Future<void> fetchAllItem(BuildContext context) async {
    _allItem = [];
    List<ItemModel> fetchAllItemList = [];

    final result = await CustomerServices().fetchItemsFromUrl();

    ItemListModel itemListModel = ItemListModel.fromJson(result);

    result['results'].forEach(
      (element) {
        fetchAllItemList.add(
          ItemModel.fromJson(element),
        );
      },
    );
    _allItem = fetchAllItemList;
    notifyListeners();
  }
}
