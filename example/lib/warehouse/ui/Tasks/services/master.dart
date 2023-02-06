import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/warehouse/ui/Tasks/model/taskMaster.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../Constants/stringConst.dart';

Future <List<Results>>fetchTaskList(String startDate,String endDate,String status) async {
  // CustomerList? custom erList;
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();
  final response = await http.get(
      Uri.parse('https://$finalUrl${StringConst.taskMaster}&date_after=${startDate.toString()}&date_before${endDate.toString()}=&status=${status.toString()}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });
  log(response.body);
  try {
    if (response.statusCode == 200) {
      return TaskMaster.fromJson(jsonDecode(response.body)).results;
    } else {
      return <Results>[];
    }
  } catch (e) {
    throw Exception(e);
  }
}

