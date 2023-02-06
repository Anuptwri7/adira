import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Financial Report/Credit Report/credit_report_page.dart';
import '../Financial Report/CustomerOrderReport/customerOrderReportUi.dart';
import '../Financial Report/Party Report/partyReportScreen.dart';

class StockAnaysisTabPage extends StatefulWidget {
  const StockAnaysisTabPage({Key key}) : super(key: key);

  @override
  _StockAnaysisTabPageState createState() => _StockAnaysisTabPageState();
}

class _StockAnaysisTabPageState extends State<StockAnaysisTabPage> {
  bool isVisibleCredit = false;
  bool isVisibleParty = false;
  bool isSuperUser;
  List<String> permission_code_name = [];
  String username = '';

  @override
  void initState() {
    setState(() {
      getSuperUser();
      getAllowedFuctions();
      isSuperUser;
      log(permission_code_name.toString());
    });

    super.initState();
  }

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isSuperUser = pref.getBool("is_super_user");
    });
    log("final superuser for report" + isSuperUser.toString());
  }

  Future<void> getAllowedFuctions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (isSuperUser == false) {
        permission_code_name = pref.getStringList("permission_code_name");
      }
    });
    log("final codes" + permission_code_name.toString());
  }

  Future<void> catchUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("user_name").toString();
    });

    log("codes name" + pref.getString("user_name").toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, -0.94),
                        end: Alignment(0.968, 1.0),
                        colors: [Color(0xff2c51a4), Color(0xff6b88e8)],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: Colors.blue),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 200.0),
                      child: Text(
                        'Financial Report',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x155665df),
                        spreadRadius: 5,
                        blurRadius: 17,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Visibility(
                            // visible: permission_code_name.contains(
                            //             "view_customer_order_report") ||
                            //         isSuperUser == true
                            //     ? true
                            //     : false,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                (context),
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreditReportPage(),
                                ),
                              ),
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/selfReport.png",
                                          height: 80),
                                      Text(
                                        "Credit Report",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Color(0xff2C51A4)),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffeff3ff),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffeff3ff),
                                      offset: Offset(-2, -2),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // ),

                          Visibility(
                            // visible: permission_code_name.contains(
                            //             "view_customer_order_report") ||
                            //         isSuperUser == true
                            //     ? true
                            //     : false,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PartyReportPage())),
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/selfReport.png",
                                          height: 80),
                                      Text(
                                        "Party Report",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Color(0xff2C51A4)),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffeff3ff),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffeff3ff),
                                      offset: Offset(-2, -2),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerOrderReport()));
                        },
                        // onTap: () => permission_code_name
                        //             .contains("self_customer_order") ||
                        //         isSuperUser == true
                        //     ?
                        // Navigator.push(
                        //         (context),
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const CustomerOrderReport()))
                        //     : Fluttertoast.showToast(
                        //         msg: "You don't have permission to view"),
                        child: Container(
                          height: 125,
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset("assets/selfReport.png",
                                    height: 80),
                                Text(
                                  "Customer Order\nReport",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xff2C51A4)),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffeff3ff),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffeff3ff),
                                offset: Offset(-2, -2),
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
