import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/warehouse/homePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomNavBar/bottomNavBar.dart';
import '../Branch/branchServices.dart';
import '../Branch/model.dart';
import '../Constants/styleConst.dart';


class WareHouseLoginPage extends StatefulWidget {
  const WareHouseLoginPage({Key key}) : super(key: key);

  @override
  _WareHouseLoginPageState createState() => _WareHouseLoginPageState();
}

class _WareHouseLoginPageState extends State<WareHouseLoginPage> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  TextEditingController branchtextEditingController = TextEditingController();
  String dropdownvalueUser = 'Select Branch';
  int _selecteduser;
  var subDomain = '';
  bool isFinished = false;
  bool isChecked = false;
  bool _passwordVisible = false;
  String dropdownValueBranch = "Select Branch";

  void validateForm() async {
    if (kDebugMode) {
    }
    if (nametextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Email Address Invalid");

    } else if (passwordtextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is Required.");
    } else {
      // login();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xfff9fdff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Color(0xff8DAFD9),
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
                    padding: const EdgeInsets.only(top:50),
                    child:Text("Adira ims".toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.indigoAccent),)
                    // child: Image.asset("assets/logo.png"),
                  ),
                ),

                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: const Text(
                      "Please Sign in to your Warehouse account.",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 15,),

                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  decoration: dropDownDecoration,
                  width: MediaQuery.of(context).size.width,

                  child: FutureBuilder(

                    future: fetchBranchFromUrl(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.data==null){
                        return Text("Loading");
                      }

                      if(snapshot.hasError){
                        return Container(child: Text("loading"),);
                      }
                      if (snapshot.hasData) {
                        try {
                          final List<Result> snapshotData = snapshot.data;
                          return DropdownButton<Result>(
                            elevation: 24,
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child: Text("${dropdownvalueUser.isEmpty?"Select Branch":dropdownvalueUser}"),
                            ),
                            // value: snapshotData.first,
                            iconSize: 24.0,
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.grey,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.indigo.shade50,
                            ),
                            items: snapshotData
                                .map<DropdownMenuItem<Result>>((Result items) {
                              return DropdownMenuItem<Result>(
                                value: items,
                                child: Text(items.name.toString()),
                              );
                            }).toList(),
                            onChanged: (Result newValue) {
                              setState(
                                    () {
                                  dropdownvalueUser = newValue.name.toString();
                                  _selecteduser = newValue.id;
                                  subDomain = newValue.subDomain.toString();

                                },
                              );
                            },
                          );
                        } catch (e) {
                          throw Exception(e);
                        }
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        )
                      ]),
                  child: TextField(
                    controller: nametextEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      contentPadding: const EdgeInsets.all(15),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        )
                      ]),
                  child: TextField(
                    obscureText: !_passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordtextEditingController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_sharp),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),

                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(15),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),

                Container(
                  padding: const EdgeInsets.only(left: 120, right: 120),
                  child: ElevatedButton(
                      onPressed: () async {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff789cc8),
                        minimumSize: const Size.fromHeight(30),
                        // maximumSize: const Size.fromHeight(56),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Arial'
                      ),
                    ),
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> login() async {
    List<String> getCodeName =[];
    List<String> getSuperUser = [];
    log("http://${subDomain}/api/v1/login");
    var response = await http.post(
      Uri.parse('https://${subDomain}/api/v1/user-app/login'),
      body: ({
        'user_name': nametextEditingController.text,
        'password': passwordtextEditingController.text,
      }),
    );
    log(response.body);
    // log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token",
          json.decode(response.body)['tokens']['access'] ?? '#');
      sharedPreferences.setString("refresh_token",
          json.decode(response.body)['tokens']['refresh'] ?? '#');
      sharedPreferences.setString("user_name",
          json.decode(response.body)['user_name'] ?? '#');
      for(int i = 0 ; i<json.decode(response.body)["permissions"].length;i++){
        // sharedPreferences.setString("permissions",
        //     json.decode(response.body)['permissions'][i]['code_name']);
        getCodeName.add(json.decode(response.body)["permissions"][i]["code_name"]);
        sharedPreferences.setStringList("permission_code_name", getCodeName);
        log(json.decode(response.body)["permissions"].length.toString());
      }
      sharedPreferences.setString("subDomain" , subDomain);
      Fluttertoast.showToast(msg: "Successfull");
      sharedPreferences.setBool("is_super_user",
          json.decode(response.body)['is_superuser']);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    } else {
      Fluttertoast.showToast(msg: "${json.decode(response.body)}");
    }
  }
}

