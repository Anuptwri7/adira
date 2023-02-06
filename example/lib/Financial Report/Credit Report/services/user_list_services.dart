import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Constants/stringConst.dart';
import '../model/user_list_model.dart';

Future fetchUserListFromUrl() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http
      .get(Uri.parse('https://$finalUrl/${StringConst.userList}'), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  });
  log("the data" + response.statusCode.toString());
  List<UserList> allUser = [];

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    responseData['results'].forEach(
      (element) {
        allUser.add(
          UserList.fromJson(element),
        );
      },
    );
    return allUser;
  }
}
