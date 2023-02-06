
import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Assets/enrollAssets.dart';
import 'package:classic_simra/Constants/stringConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

Future fetchAssetItems() async {

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  final baseUrl = sharedPreferences.getString('subDomain');
  // log(sharedPreferences.getString("access_token"));
  final response = await http.get(
      Uri.parse('https://$baseUrl${StringConst.enrollAssets}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      }
  );

  // List<Result> respond = [];
  // final responseData = json.decode(response.body);
  // responseData['content'].forEach(
  //       (element) {
  //     respond.add(
  //       Result.fromJson(element),
  //     );
  //   },
  // );
  try {
    if (response.statusCode == 200) {
      log(response.body);
      var messageData = json.decode(response.body);
      return messageData;
    }
  } catch (e) {
    throw Exception(e);
  }

}
