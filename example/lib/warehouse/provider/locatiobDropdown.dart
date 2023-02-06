

import 'package:classic_simra/warehouse/provider/model/locationList.dart';
import 'package:classic_simra/warehouse/provider/services/locationServices.dart';

import 'package:flutter/cupertino.dart';


class LocationList extends ChangeNotifier {

Location location = Location();
  List<ResultsLocation> _allLocation = [];

  List<ResultsLocation> get allLocation => [..._allLocation];

  Future fetchAvailableLocationList() async {

    _allLocation = [];
    List<ResultsLocation> fetchAvailableLocationList = [];

    final result = await location.fetchAvailableLocationList();

    // ResultCategory itemListModel = ResultCategory.fromJson(result);

    result['results'].forEach(
          (element) {
        fetchAvailableLocationList.add(
          ResultsLocation.fromJson(element),

        );
      },
    );
    // log("fteching");

    _allLocation = fetchAvailableLocationList;
    notifyListeners();
  }
}
