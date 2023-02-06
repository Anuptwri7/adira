import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Credit Report/model/user_list_model.dart';
import '../Credit Report/services/user_list_services.dart';
import 'Services/reportApi.dart';
import 'Services/supplierAPI.dart';
import 'finanacialPdfDemo.dart';
import 'model/supplierListModel.dart';

TextEditingController StartdateController = TextEditingController();
TextEditingController EnddateController = TextEditingController();

class PartyReportPage extends StatefulWidget {
  const PartyReportPage({Key key}) : super(key: key);

  @override
  _PartyReportPageState createState() => _PartyReportPageState();
}

class _PartyReportPageState extends State<PartyReportPage> {
  DateTime pickedStart;
  DateTime pickedEnd;
  int _selectedUser;
  String _selectedUserName = "Select User";

  SupplierServices supplierServices = SupplierServices();
  int _selectedSupplier;
  String _selectedSupplierName = "Select Supplier";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
                color: Colors.blue),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Party Report',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "User",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        )
                      ]),
                  padding: const EdgeInsets.only(left: 10, right: 0, top: 2),
                  child: FutureBuilder(
                      future: fetchUserListFromUrl(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading");
                        } else {
                          try {
                            final List<UserList> snapshotData = snapshot.data;

                            return DropdownButton<UserList>(
                              elevation: 24,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    "${_selectedUserName.isEmpty ? "Select User" : _selectedUserName}"),
                              ),
                              iconSize: 24.0,
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.grey,
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.indigo.shade50,
                              ),
                              items: snapshotData
                                  .map<DropdownMenuItem<UserList>>(
                                      (UserList items) {
                                return DropdownMenuItem<UserList>(
                                  value: items,
                                  child: Text(items.userName.toString()),
                                );
                              }).toList(),
                              onChanged: (UserList value) {
                                setState(
                                  () {
                                    _selectedUser = value.id;
                                    _selectedUserName = value.userName;
                                  },
                                );
                              },
                            );
                          } catch (e) {
                            throw Exception(e);
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(4, 4),
                    )
                  ]),
              padding: const EdgeInsets.only(left: 10, right: 0, top: 2),
              child: FutureBuilder(
                future: supplierServices.fetchSupplierListFromUrl(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Text("Loading");
                  }
                  if (snapshot.hasData) {
                    try {
                      final List<supplierList> snapshotData = snapshot.data;
                      return DropdownButton<supplierList>(
                        elevation: 24,
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                              "${_selectedSupplierName.isEmpty ? "Select Branch" : _selectedSupplierName}"),
                        ),
                        // value: snapshotData.first,
                        iconSize: 24.0,
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.grey,
                        ),
                        underline: Container(
                          height: 0,
                          color: Colors.indigo.shade50,
                        ),
                        items: snapshotData.map<DropdownMenuItem<supplierList>>(
                            (supplierList items) {
                          return DropdownMenuItem<supplierList>(
                            value: items,
                            child: Text(items.name.toString()),
                          );
                        }).toList(),
                        onChanged: (supplierList value) {
                          setState(
                            () {
                              _selectedSupplier = value.id;
                              _selectedSupplierName = value.name;
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
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Start Date"),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: InkWell(
                        onTap: () {
                          _pickStartDateDialog();
                        },
                        child: TextField(
                          controller: StartdateController,

                          // keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Start Date',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(4, 4),
                            )
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("End Date"),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: InkWell(
                        onTap: () {
                          _pickEndDateDialog();
                        },
                        child: TextField(
                          controller: EnddateController,
                          // keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'End Date',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(4, 4),
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                fetchPdfFromUrl(
                  _selectedSupplier == null ? '' : _selectedSupplier.toString(),
                  _selectedUser == null ? "" : _selectedUser.toString(),
                ).whenComplete(
                  () async {
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      if (partyReport.isNotEmpty) {
                        Fluttertoast.showToast(
                          msg: "Wait Party Payment Invoice is Generating...",
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey,
                          fontSize: 18,
                        );
                        generateInvoice();
                        StartdateController.clear();
                        EnddateController.clear();
                        partyReport.clear();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Data Not Found",
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          fontSize: 18,
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "Permission Deined",
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        fontSize: 18,
                      );
                    }
                  },
                );
              },
              child: const Text("Generate"))
        ],
      ),
    );
  }

  void _pickStartDateDialog() async {
    pickedStart = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        helpText: "Select Delivered Date");
    if (pickedStart != null) {
      setState(() {
        StartdateController.text =
            '${pickedStart.year}-${pickedStart.month}-${pickedStart.day}';
      });
    }
  }

  void _pickEndDateDialog() async {
    pickedEnd = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        helpText: "Select Delivered Date");
    if (pickedEnd != null) {
      setState(() {
        EnddateController.text =
            '${pickedEnd.year}-${pickedEnd.month}-${pickedEnd.day}';
      });
    }
  }
}
