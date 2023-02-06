import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:developer';
import '../../../../Constants/stringConst.dart';

Future fetchTagKeys(int id) async {

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  final baseUrl = sharedPreferences.getString('subDomain');
  // log(sharedPreferences.getString("access_token"));
  final response = await http.get(
      Uri.parse('https://$baseUrl${StringConst.assetDispatchTags+id.toString()}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      }
  );
  // log("jhkjhkjhkh"+response.body);
  try {
    if (response.statusCode == 200) {

      var messageData = jsonDecode(response.body);
      return messageData;
    }
  } catch (e) {
    throw Exception(e);
  }

}