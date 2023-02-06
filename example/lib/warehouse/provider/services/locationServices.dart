
import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Assets/availableCode/model.dart';
import 'package:classic_simra/Assets/enrollAssets.dart';
import 'package:classic_simra/Constants/stringConst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Location{
  Future fetchAvailableLocationList() async {

    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final baseUrl = sharedPreferences.getString('subDomain');

    final response = await http.get(
        Uri.parse('https://$baseUrl${StringConst.location}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        }
    );
    // log("codes"+response.body);
    List<ResultCodes> respond = [];
    final responseData = json.decode(response.body);
    responseData['results'].forEach(
          (element) {
        respond.add(
          ResultCodes.fromJson(element),
        );
      },
    );
    try {
      if (response.statusCode == 200||response.statusCode == 201) {
        // log(response.body);
        var messageData = json.decode(response.body);
        return messageData;
      }
    } catch (e) {
      throw Exception(e);
    }

  }
}




