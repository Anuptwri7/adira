import 'dart:developer';
import 'package:classic_simra/Financial%20Report/CustomerOrderReport/finanacialPdfDemo.dart';
import 'package:classic_simra/Financial%20Report/CustomerOrderReport/services/customerOrderReportAPI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/model/customer_model.dart';
import '../../Home/services/customer_api.dart';
import '../../Home/services/customer_list_services.dart';

TextEditingController StartdateController = TextEditingController();
TextEditingController EnddateController = TextEditingController();

class CustomerOrderReport extends StatefulWidget {
  const CustomerOrderReport({Key key}) : super(key: key);

  @override
  _CustomerOrderReportState createState() => _CustomerOrderReportState();
}

class _CustomerOrderReportState extends State<CustomerOrderReport> {
  DateTime pickedStart;
  DateTime pickedEnd;
  String _selectedCustomer;
  String _selectedCustomerName = "Select Customer";
  String username = "";
  String _selectedType;
  String userId = '';
  CustomerListingsService customerListingsService = CustomerListingsService();
  CustomerServices customerServices = CustomerServices();
  int _selectedSupplier;
  String _selectedSupplierName;

  @override
  void initState() {
    setState(() {
      catchUserName();
      catchUserId();
    });
    super.initState();
  }

  Future<void> catchUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("user_name").toString();
    log("codes name" + pref.getString("user_name").toString());
  }

  Future<void> catchUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId").toString();
    log("UserId::::::::::::" + pref.getString("userId").toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Customer Order Report',
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Customer Order Type",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: DropdownButton<String>(
                      hint: const Text(
                        "Select Packing Type",
                        style: TextStyle(),
                      ),
                      icon: const Visibility(
                          visible: false, child: Icon(Icons.arrow_downward)),
                      items: <String>[
                        'PENDING',
                        'BILLED',
                        'CANCELLED',
                        'CHALAN'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(value.toString()),
                          ),
                          onTap: () {
                            value == 'PENDING'
                                ? _selectedType = '1'
                                : value == 'BILLED'
                                    ? _selectedType = '2'
                                    : value == 'CANCELLED'
                                        ? _selectedType = '3'
                                        : value == 'CHALAN'
                                            ? _selectedType = '4'
                                            : _selectedType = '0';
                            _selectedSupplierName = value.toString();
                            log(_selectedType.toString());
                            log(_selectedSupplierName.toString());
                          },
                        );
                      }).toList(),
                      value: _selectedSupplierName,
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      onChanged: (newValue) {
                        setState(() {
                          newValue = _selectedType.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Customer",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                      future: customerServices.fetchCustomerFromUrl(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading");
                        }
                        if (snapshot.hasData) {
                          try {
                            List<AllCustomer> fetchAllCustomerList = [];

                            final result = snapshot.data;

                            result['results'].forEach(
                              (element) {
                                fetchAllCustomerList.add(
                                  AllCustomer.fromJson(element),
                                );
                              },
                            );
                            log(fetchAllCustomerList.length.toString());

                            return DropdownButton<AllCustomer>(
                              elevation: 24,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    "${_selectedCustomerName.isEmpty ? "Select Branch" : _selectedCustomerName}"),
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
                              items: fetchAllCustomerList
                                  .map<DropdownMenuItem<AllCustomer>>(
                                      (AllCustomer items) {
                                return DropdownMenuItem<AllCustomer>(
                                  value: items,
                                  child: Text(items.firstName.toString()),
                                );
                              }).toList(),
                              onChanged: (AllCustomer value) {
                                setState(
                                  () {
                                    _selectedCustomer = value.id.toString();
                                    _selectedCustomerName = value.firstName;
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              width: MediaQuery.of(context).size.width / 2.50,
                              child: InkWell(
                                onTap: () {
                                  _pickStartDateDialog();
                                },
                                child: TextField(
                                  controller: StartdateController,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Start Date',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                              width: MediaQuery.of(context).size.width / 2.2,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          fetchCustomerOrderPdfFromUrl(
                            userId == null ? '' : userId.toString(),
                            _selectedType.toString(),
                          ).whenComplete(
                            () async {
                              final status = await Permission.storage.request();
                              if (status.isGranted) {
                                if (customerOrderReport.isNotEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Wait your report is Generating...",
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blueGrey,
                                    fontSize: 18,
                                  );
                                  generateInvoice(username.toString());
                                  StartdateController.clear();
                                  EnddateController.clear();
                                  customerOrderReport.clear();
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
                        child: const Text("Generate")),
                  )
                ],
              ),
            ),
          ],
        ),
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
