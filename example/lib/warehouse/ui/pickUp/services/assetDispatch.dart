
import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Constants/stringConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/disptachModel.dart';



  Future <List<Results>>fetchDispatchList() async {
    // CustomerList? custom erList;
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.assetDispatch}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
    log(response.body);
    try {
      if (response.statusCode == 200) {
        return AssetDispatch.fromJson(jsonDecode(response.body)).results;
      } else {
        return <Results>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }