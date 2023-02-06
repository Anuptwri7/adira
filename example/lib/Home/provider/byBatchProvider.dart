import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../model/byBatch.dart';
import '../services/customer_api.dart';

class BatchListProvider extends ChangeNotifier {
  List<ByBatchModel> _allBatch = [];
  List<ByBatchModel> get allBatch => [..._allBatch];
  Future<void> fetchAllBatch({BuildContext context, int itemId}) async {
    _allBatch = [];
    List<ByBatchModel> fetchAllBatchList = [];
    final result = await CustomerServices().fetchBatchFromUrl(itemId);
    ByBatchModel batchModel = ByBatchModel.fromJson(result);

    result['results'].forEach(
      (element) {
        fetchAllBatchList.add(
          ByBatchModel.fromJson(element),
        );
      },
    );
    _allBatch = fetchAllBatchList;
    log(_allBatch.toString());
    notifyListeners();
  }
}
