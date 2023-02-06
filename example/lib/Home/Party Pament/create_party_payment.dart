import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/stringConst.dart';
import '../Credit Managament/model/payement_details_model.dart';
import '../Credit Managament/payment_screen.dart';
import 'model/get_party_invoice_model.dart';
import 'model/supplierListModel.dart';
import 'party_payment.dart';
import 'services/supplierListService.dart';
import 'package:http/http.dart' as http;

String dueamount;

class CreatePartyPayment extends StatefulWidget {
  const CreatePartyPayment({Key key}) : super(key: key);

  @override
  _CreatePartyPaymentState createState() => _CreatePartyPaymentState();
}

class _CreatePartyPaymentState extends State<CreatePartyPayment> {
  String dueAmount;
  int _selectedSupplier;
  String _selectedSupplierName = "Select Supplier";
  String totalAmount;
  String paidAmount;
  int _selectedPurchaseId;
  String _selectedPurchaseNo = "Select Purchase";
  List<PaymentDetails> paymentDetails = [];

  var payment = ["Payment", "Return"];
  String dropdownValue;

  TextEditingController remarksController = TextEditingController();

  double total = 0;
  payingAmount() {
    for (int i = 0; i < paymentDetails.length; i++) {
      total += paymentDetails[i].amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, -0.94),
                    end: Alignment(0.968, 1.0),
                    colors: [Color(0xff2557D2), Color(0xff6b88e8)],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  //   color: Color(0xff2557D2)
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Party Payment',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffeff3ff),
                        offset: Offset(5, 8),
                        spreadRadius: 5,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Suppliers",
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              // blurRadius: 2,
                                              // offset: Offset(4, 4),
                                            )
                                          ]),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 0, top: 2),
                                      child: FutureBuilder(
                                        future: fetchSupplierFromUrl(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          log(snapshot.hasData.toString());
                                          if (!snapshot.hasData) {
                                            return  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: const Text(
                                                        'Loading Supplier .....',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black)),
                                                  );
                                          }
                                          if (snapshot.hasData) {
                                            try {
                                              final List<SupplierListModel>
                                                  snapshotData = snapshot.data;

                                              return DropdownButton<
                                                  SupplierListModel>(
                                                elevation: 24,
                                                isExpanded: true,
                                                hint: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Text(
                                                    "${_selectedSupplierName.isEmpty ? "Select Branch" : _selectedSupplierName}",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
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
                                                items: snapshotData.map<
                                                        DropdownMenuItem<
                                                            SupplierListModel>>(
                                                    (SupplierListModel items) {
                                                  return DropdownMenuItem<
                                                      SupplierListModel>(
                                                    value: items,
                                                    child: Text(
                                                        items.name.toString()),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (SupplierListModel value) {
                                                  setState(
                                                    () {
                                                      _selectedSupplier =
                                                          value.id;
                                                      _selectedSupplierName =
                                                          value.name;
                                                    },
                                                  );
                                                },
                                              );
                                            } catch (e) {
                                              throw Exception(e);
                                            }
                                          } else {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Purchase No."),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            // blurRadius: 2,
                                            // offset: Offset(4, 4),
                                          ),
                                        ]),
                                    child: FutureBuilder(
                                      future: getPartyInvoiceFromUrl(
                                          _selectedSupplier.toString()),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return  Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: const Text(
                                                      'Select .....',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                );
                                        }
                                        if (snapshot.hasData) {
                                          try {
                                            final List<GetPartyInvoiceModel>
                                                snapshotData = snapshot.data;
                                            // return Text(
                                            //     snapshotData.toString());

                                            return DropdownButton<
                                                GetPartyInvoiceModel>(
                                              elevation: 24,
                                              isExpanded: true,
                                              hint: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  "${_selectedPurchaseNo.isEmpty ? "Select Branch" : _selectedPurchaseNo}",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
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
                                              items: snapshotData.map<
                                                      DropdownMenuItem<
                                                          GetPartyInvoiceModel>>(
                                                  (GetPartyInvoiceModel items) {
                                                return DropdownMenuItem<
                                                    GetPartyInvoiceModel>(
                                                  value: items,
                                                  child: Text(items.purchaseNo
                                                      .toString()),
                                                );
                                              }).toList(),
                                              onChanged:
                                                  (GetPartyInvoiceModel value) {
                                                setState(() {
                                                  _selectedPurchaseNo =
                                                      value.purchaseNo;
                                                  _selectedPurchaseId =
                                                      value.purchaseId;
                                                });
                                                totalAmount = value.totalAmount;

                                                paidAmount = value.paidAmount;
                                                dueAmount = value.dueAmount;
                                                dueamount = dueAmount;
                                              },
                                            );
                                          } catch (e) {
                                            throw Exception(e);
                                          }
                                        } else {
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Payment Type"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                            ),
                                          ]),
                                      child: DropdownButton<String>(
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Select Type",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        value: dropdownValue,
                                        iconSize: 0,
                                        // icon: Icon(
                                        //   Icons.arrow_drop_down_circle,
                                        //   color: Colors.grey,
                                        // ),
                                        underline: Container(
                                          height: 0,
                                          color: Colors.indigo.shade50,
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            dropdownValue = value;
                                          });
                                        },
                                        items: payment
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Total Amount"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        totalAmount != null
                                            ? "Rs.$totalAmount"
                                            : "Rs. 0.0",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            // blurRadius: 2,
                                            // offset: Offset(4, 4),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Paid Amount"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        paidAmount != null
                                            ? "Rs.$paidAmount"
                                            : "Rs.0.00",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            // blurRadius: 2,
                                            // offset: Offset(4, 4),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Due Amount"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dueAmount != null
                                            ? "Rs.$dueAmount"
                                            : "Rs.0.00",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            // blurRadius: 2,
                                            // offset: Offset(4, 4),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Paying Amount"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "$total",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            // blurRadius: 2,
                                            // offset: Offset(4, 4),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Remarks"),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: remarksController,
                                maxLength: 200,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Remarks',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 80,
                              child: ElevatedButton(
                                onPressed: paymentDetails.isNotEmpty
                                    ? () async {
                                        setState(() {
                                          savePayment();
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 2),
                                          dismissDirection:
                                              DismissDirection.down,
                                          content: const Text(
                                            "Bill Cleared Successfully",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          elevation: 10,
                                          backgroundColor: Colors.blue,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ));

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PartyPayment(),
                                          ),
                                        );
                                      }
                                    : null,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        paymentDetails.isEmpty
                                            ? Colors.lightBlue[600]
                                            : Colors.indigo[900]),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    )),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              height: 40,
                              width: 80,
                              //color: Colors.grey,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_selectedSupplier == null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please select the supplier First!");
                                  } else {
                                    paymentDetails = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentScreen()),
                                    );
                                  }

                                  setState(() {
                                    payingAmount();
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff5073d9)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        //  side: BorderSide(color: Colors.red)
                                      ),
                                    )),
                                child: const Text(
                                  "Pay",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future savePayment() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double total = 0.0;
    var partyPaymentDetails = [];

    // log("sale no.$_selectedPurchaseId");

    for (int i = 0; i < paymentDetails.length; i++) {
      total += paymentDetails[i].amount;
      partyPaymentDetails.add({
        "payment_mode": paymentDetails[i].paymentMode,
        "amount": paymentDetails[i].amount,
        "remarks": paymentDetails[i].remarks,
      });
    }

    final responseBody = {
      "party_payment_details": partyPaymentDetails,
      "payment_type": 1,
      "remarks": remarksController.text,
      "purchase_master": _selectedPurchaseId,
      "total_amount": total,
    };

    log(responseBody.toString());

    try {
      final response = await http.post(
          Uri.parse('https://$finalUrl/${StringConst.clearPartyInvoice}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
          },
          body: json.encode(responseBody));
      if (response.statusCode == 201) {
        paymentDetails.clear();
        allSupplier.clear();
        // allPartySupplier.clear();
      } else if (response.statusCode == 400) {
        FlutterError.onError = (details) => Text(details.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
