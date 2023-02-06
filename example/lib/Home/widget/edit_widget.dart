import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Home/provider/item_list_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../BottomNavBar/bottomNavBar.dart';
import '../../Constants/stringConst.dart';
import '../model/addModel.dart';
import '../model/byBatch.dart';
import '../model/item_model.dart';
import '../provider/byBatchProvider.dart';
import '../services/customer_api.dart';
import '../services/list_services.dart';

class Edit extends StatefulWidget {
  bool byBatch;
  final List<AddItemModel> allModelData;
  final String customerId;
  final String updateId;
  final String userName;
  Edit(
      {Key key,
      this.byBatch,
      this.allModelData,
      this.customerId,
      this.updateId,
      this.userName})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String _selectedCustomer;
  String _selectedCustomerName;
  int _selectedItem;
  String _selectedItemName = "Select Item";
  int _seletedBatch;
  String _selectedBatchNo = "Select Batch";
  double _remainingQty;
  double _remainingQtyBatch;
  bool isVisible = false;
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  // List<AddItemModel> allModelData = [];

  ListingServices listingservices = ListingServices();

  Future CancelSingleOrder(String cancelId) async {
    return await listingservices.CancelSingleOrderFromUrl(cancelId);
  }

  double grandTotal = 0.0,
      subTotal = 0.0,
      totalDiscount = 0.0,
      finaldiscount = 0.0,
      x = 0.0;

  DateTime picked;
  CustomerServices customerServices = CustomerServices();
  int selectedId = 0;
  String discountInitial = "0.00";
  int discountId = 0;
  int itemId = 0;

  @override
  Widget build(BuildContext context) {
    context.read<CustomerItemListProvider>().fetchAllItem(context);
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
                      "Edit Customer Order",
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
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Customer"),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: 50,
                            width: 290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            // padding: const EdgeInsets.only(
                            //
                            //     left: 10, right: 0, top: 2),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 15.0),
                              child: Text(
                                widget.userName.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Items"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Consumer<CustomerItemListProvider>(
                              builder: ((context, item, child) {
                            return DropdownButton<ItemModel>(
                              elevation: 24,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                    "${_selectedItemName.isEmpty ? "Select Item" : _selectedItemName}"),
                              ),
                              // value: snapshotData.first,
                              iconSize: 24.0,
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.grey,
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              items: item.allItem
                                  .map<DropdownMenuItem<ItemModel>>(
                                      (ItemModel name) {
                                return DropdownMenuItem<ItemModel>(
                                  value: name,
                                  child: Text(name.name.toString()),
                                );
                              }).toList(),
                              onChanged: (ItemModel value) {
                                setState(
                                  () {
                                    _selectedItem = value.id;
                                    _selectedItemName = value.name;
                                  },
                                );
                              },
                            );
                          })),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: widget.byBatch,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Batch"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(2, 2),
                                  )
                                ]),
                            child: FutureBuilder(
                              future: customerServices
                                  .fetchBatchFromUrl(_selectedItem)
                                  .then((value) async {
                                if (_selectedItem != null) {
                                  await context
                                      .read<BatchListProvider>()
                                      .fetchAllBatch(
                                          context: context,
                                          itemId: _selectedItem);
                                }
                              }),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                log(snapshot.hasData.toString());
                                if (snapshot.data == null &&
                                    _selectedItem == null) {
                                  return Text("Loading");
                                }
                                return Consumer<BatchListProvider>(
                                    builder: (context, message, child) {
                                  return DropdownButton<ByBatchModel>(
                                    elevation: 24,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                          "${_selectedBatchNo.isEmpty ? "Select Branch" : _selectedBatchNo}"),
                                    ),
                                    // value: snapshotData.first,
                                    iconSize: 24.0,
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.grey,
                                    ),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    items: message.allBatch
                                        .map<DropdownMenuItem<ByBatchModel>>(
                                            (ByBatchModel name) {
                                      return DropdownMenuItem<ByBatchModel>(
                                        value: name,
                                        child: Text(name.batchNo.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (ByBatchModel value) {
                                      setState(
                                        () {
                                          //         // setState(() {
                                          _seletedBatch = value.id;
                                          _selectedBatchNo =
                                              value.batchNo.toString();
                                          _remainingQtyBatch =
                                              value.remainingQty;

                                          log('selected item is Taxable or not : ${_seletedBatch.toString()}');
                                        },
                                      );
                                    },
                                  );
                                });
                              },
                            )),
                      ],
                    ),
                  ),

                  // Container(
                  //   width: 20,
                  //   height: 20,
                  //   color: Colors.amber,
                  // )
                ],
              ),
              // ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sales Price"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: pricecontroller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Sales Price',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Delivery Location"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: locationController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Delivery location',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
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
                padding: const EdgeInsets.only(left: 18, right: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Quantity"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: qtyController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Quantity',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Delivery Date"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: InkWell(
                            onTap: () {
                              _pickDateDialog();
                            },
                            child: TextField(
                              controller: dateController,
                              enabled: false,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Delivery Date',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Discount %"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: discountPercentageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Discount %',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
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
              Center(
                child: SizedBox(
                  height: 35,
                  width: 80,
                  //color: Colors.grey,
                  // padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (pricecontroller.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the price");
                      }
                      if (qtyController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Quantity");
                      } else {
                        if (discountPercentageController.text.isEmpty) {
                          discountPercentageController.text = "0";
                        }
                        setState(() {
                          widget.allModelData.add(
                            AddItemModel(
                                id: _selectedItem,
                                name: _selectedItemName.toString(),
                                quantity: double.parse(qtyController.text),
                                price: double.parse(pricecontroller.text),
                                discount: double.parse(
                                    discountPercentageController.text),
                                discountAmt: (double.parse(
                                        discountPercentageController.text) *
                                    (double.parse(pricecontroller.text) *
                                        int.parse(qtyController.text)) /
                                    100),
                                amount: double.parse(pricecontroller.text) *
                                    int.parse(qtyController.text),
                                totalAfterDiscount: (double.parse(
                                            pricecontroller.text) *
                                        int.parse(qtyController.text) -
                                    (double.parse(
                                            discountPercentageController.text) *
                                        (double.parse(pricecontroller.text) *
                                            int.parse(qtyController.text)) /
                                        100)),
                                isNew: true,
                                batchNo: _seletedBatch),
                          );

                          _selectedItemName = "";
                          log('allModelData.length : ' +
                              widget.allModelData.length.toString());
                        });
                      }

                      qtyController.clear();
                      pricecontroller.clear();
                      discountPercentageController.clear();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff5073d9)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  side: BorderSide(color: Colors.red)
                          ),
                        )),
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 92,
              // ),
              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DataTable(
                  columnSpacing: 10,
                  horizontalMargin: 0,
                  // columnSpacing: 10,
                  columns: const [
                    DataColumn(
                      label: SizedBox(
                        width: 140,
                        child: Text('Name'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 80,
                        child: Text('Quantity'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 80,
                        child: Center(child: Text('Amount')),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 60,
                        child: Text('Discount'),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    widget.allModelData.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Text(widget.allModelData[index].name.toString()),
                        ),
                        DataCell(
                          Text(widget.allModelData[index].quantity.toString()),
                        ),
                        DataCell(
                          Text(widget.allModelData[index].amount.toString()),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.allModelData[index].discountAmt
                                .toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Center(
                child: SizedBox(
                  height: 35,
                  width: 80,
                  //color: Colors.grey,
                  // padding: const EdgeInsets.only(left: 120, right: 120),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        UpdateProduct(int.parse(widget.updateId.toString()));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff2658D3)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  side: BorderSide(color: Colors.red)
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
              ),

              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        lastDate: DateTime(2030),
        helpText: "Select Delivered Date");
    if (picked != null) {
      setState(() {
        dateController.text = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  Future UpdateProduct(int updateId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double grandTotal = 0.0,
        subTotal = 0.0,
        totalDiscount = 0.0,
        finaldiscount = 0.0,
        x = 0.0;
    var orderDetails = [];
    for (int i = 0; i < widget.allModelData.length; i++) {
      subTotal += widget.allModelData[i].amount;
      totalDiscount +=
          (widget.allModelData[i].discount * widget.allModelData[i].amount) /
              100;
      finaldiscount = (subTotal - totalDiscount);
      grandTotal += (finaldiscount - widget.allModelData[i].amount);
      x += widget.allModelData[i].totalAfterDiscount;
      log("Update data 1" + widget.allModelData.first.isNew.toString());
      log("Update data 2" + widget.allModelData[1].isNew.toString());
      widget.allModelData[i].isNew && widget.byBatch
          ? orderDetails.add({
              "item": widget.allModelData[i].id,
              "item_category": 3,
              "batch": {"id": widget.allModelData[i].batchNo},
              "taxable": false,
              "discountable": true,
              "qty": widget.allModelData[i].quantity,
              "purchase_cost": 0,
              "sale_cost": widget.allModelData[i].price,
              "discount_rate": widget.allModelData[i].discount,
              "discount_amount": widget.allModelData[i].discountAmt,
              "tax_rate": 0,
              "tax_amount": "0.00",
              "gross_amount": widget.allModelData[i].amount,
              "net_amount": widget.allModelData[i].totalAfterDiscount,
              "remarks": "",
              "isNew": true,
              "cancelled": false,
              "purchase_detail": widget.allModelData[i].batchNo
            })
          : [];
      // orderDetails.add({
      //     "item": widget.allModelData[i].id,
      //     "item_category": 3,
      //     "batch": {"id": widget.allModelData[i].batchNo},
      //     "taxable": false,
      //     "discountable": true,
      //     "qty": widget.allModelData[i].quantity,
      //     "purchase_cost": 0,
      //     "sale_cost": widget.allModelData[i].price,
      //     "discount_rate": widget.allModelData[i].discount,
      //     "discount_amount": widget.allModelData[i].discountAmt,
      //     "tax_rate": 0,
      //     "tax_amount": "0.00",
      //     "gross_amount": widget.allModelData[i].amount,
      //     "net_amount": widget.allModelData[i].totalAfterDiscount,
      //     "remarks": " ",
      //     "isNew": true,
      //     "cancelled": false,
      //     "purchase_detail": null
      //   });
    }

    Map<String, dynamic> responseBody = {
      "status": 1,
      "customer": widget.customerId,
      "sub_total": subTotal,
      "total_discount": totalDiscount,
      "total_tax": 0,
      "grand_total": x,
      "remarks": " ",
      "total_discountable_amount": subTotal,
      "total_taxable_amount": 0,
      "total_non_taxable_amount": x,
      "discount_scheme": '',
      "discount_rate": 0,
      "delivery_location": locationController.text,
      "order_details": orderDetails,
    };

    log("https://$finalUrl/${StringConst.editCustomerOrderByBatch}$updateId");
    log(responseBody.toString());
    final response = await http.patch(
      Uri.parse(widget.byBatch
          ? "https://$finalUrl/${StringConst.editCustomerOrderByBatch}$updateId"
          : "https://$finalUrl/${StringConst.editCustomerOrder}$updateId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
      body: json.encode(responseBody),
    );
    log("data Response Body " + response.reasonPhrase.toString());
    log("data Response Body " + response.body.toString());
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Product Added Successfully");
      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
    } else if (response.statusCode == 404) {
      Fluttertoast.showToast(
        msg: "Response from server :" + response.body.toString(),
      );
    }
  }
}
