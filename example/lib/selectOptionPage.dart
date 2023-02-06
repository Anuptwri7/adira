import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login/loginScreen.dart';
import 'Login/wareHouseLoginPage.dart';


class OptionPage extends StatefulWidget {
  const OptionPage({Key key}) : super(key: key);

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  bool toggleValue = true;
  bool isFinished = false;
  bool isChecked = false;
  bool _passwordVisible = false;
  String dropdownValueBranch = "Select Branch";



  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xfff9fdff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width:MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height,
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top:30),
                      child: Image.asset("assets/logo.png"),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top:100),
                      child: CupertinoSwitch(
                        activeColor: Colors.grey.shade300,
                        thumbColor: Colors.indigo,
                        trackColor: Colors.grey,
                        value: toggleValue,
                        onChanged: (value) => setState(() => toggleValue = value),
                      ),
                    ),
                  ),
                  Row(
                    children: [

                    ],
                  ),
                  Visibility(
                    visible: toggleValue==true?true:false,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: const EdgeInsets.only(top:50),
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>InventoryLoginPage()) );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo.shade300,
                              minimumSize: const Size.fromHeight(30),
                              // maximumSize: const Size.fromHeight(56),
                            ),
                            child: const Text(
                              "Continue to Inventory",
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: toggleValue==false?true:false,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: const EdgeInsets.only(top:50),
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>WareHouseLoginPage()) );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo.shade300,
                              minimumSize: const Size.fromHeight(30),
                              // maximumSize: const Size.fromHeight(56),
                            ),
                            child: const Text(
                              "Continue to Warehouse",
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )),
                      ),
                    ),
                  ),






                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//   Future<void> login() async {
//     List<String> getCodeName =[];
//     List<String> getSuperUser = [];
//     log(nametextEditingController.text.toString());
//     log(passwordtextEditingController.text.toString());
//     var response = await http.post(
//       Uri.parse(ApiConstant.baseUrl + ApiConstant.login),
//       body: (json.encode({
//         'username': nametextEditingController.text,
//         'password': passwordtextEditingController.text,
//       })),
//     );
// log(response.body);
//     if (response.statusCode == 200) {
//       final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();
//       sharedPreferences.setString("access_token",
//           json.decode(response.body)['tokens']['access_token'] ?? '#');
//       sharedPreferences.setString("refresh_token",
//           json.decode(response.body)['tokens']['refresh_token'] ?? '#');
//
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const TabPage()));
//     } else {
//       Fluttertoast.showToast(msg: "${json.decode(response.body)}");
//     }
//   }
}

