
import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Assets/enrollAssets.dart';
import 'package:classic_simra/Constants/stringConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future fetchDispatchReturnMaster() async {

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  final baseUrl = sharedPreferences.getString('subDomain');
  // log(sharedPreferences.getString("access_token"));
  final response = await http.get(
      Uri.parse('https://$baseUrl${StringConst.dispatchReturnMaster}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      }
  );

  try {
    if (response.statusCode == 200) {
      log(response.body);
      var messageData = response.body;
      return messageData;
    }
  } catch (e) {
    throw Exception(e);
  }

}
