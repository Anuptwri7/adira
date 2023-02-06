import 'package:flutter/cupertino.dart';

class VerifiedController extends ChangeNotifier {
  List<String> serialId = [];
  List<int> index = [];

  updateSerialId({ List<String> newSerialId}) {
    serialId = newSerialId;
    notifyListeners();
  }

  updateIndex({ int pk}) {
    index.add(pk);
    notifyListeners();
  }
}
