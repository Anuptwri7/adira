import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Constants/stringConst.dart';
import '../model/supplierListModel.dart';

class SupplierServices {
  //Customer Name

  List<supplierList> allSuppliers = [];

  Future fetchSupplierListFromUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${StringConst.supplierList}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    log(response.body);

    try {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        responseData['results'].forEach(
          (element) {
            allSuppliers.add(
              supplierList.fromJson(element),
            );
          },
        );
        return allSuppliers;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
