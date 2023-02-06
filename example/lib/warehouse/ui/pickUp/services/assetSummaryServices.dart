
import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Constants/stringConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/summaryModel.dart';

Future fetchAssetSummary(String id) async {
  // CustomerList? custom erList;
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();
  final response = await http.get(
      Uri.parse('https://$finalUrl${StringConst.assetSummary+id}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });
  log("hello"+response.body);
  List rfid = [];
  try {
    if (response.statusCode == 200) {
      var messageData = response.body;
      return messageData;
    } else {
      return <ResultsSummary>[];
    }
  } catch (e) {
    throw Exception(e);
  }
}