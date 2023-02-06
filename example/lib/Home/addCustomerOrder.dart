import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:classic_simra/Home/model/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../Constants/stringConst.dart';
import 'customer_order_list.dart';
import 'model/addModel.dart';
import 'model/byBatch.dart';
import 'model/customer_model.dart';
import 'provider/byBatchProvider.dart';
import 'provider/customer_list_provider.dart';
import 'provider/item_list_provider.dart';
import 'services/customer_api.dart';

TextEditingController firstName = TextEditingController();
TextEditingController discountName = TextEditingController();
TextEditingController discountRate = TextEditingController();
TextEditingController middleName = TextEditingController();
TextEditingController lastName = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController contactNumber = TextEditingController();
TextEditingController PanNumber = TextEditingController();
ScrollController scrollController = ScrollController();

class AddPropertyTabPage extends StatefulWidget {
  const AddPropertyTabPage({Key key}) : super(key: key);

  @override
  _AddPropetyTabPageState createState() => _AddPropetyTabPageState();
}

class _AddPropetyTabPageState extends State<AddPropertyTabPage> {
  bool isChecked = false;
  String _selectedCustomer;
  String _selectedCustomerName = "Select Customer";
  int _selectedItem;
  int _seletedBatch;
  String _selectedBatchNo = "Select Batch";
  bool _taxable;
  bool loading = false;
  String _taxRate;
  String _selectedItemName = "Select Item";
  double _remainingQty;
  double _remainingQtyBatch;
  double _selectedItemCost;
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  List<AddItemModel> allModelData = [];
  bool isVisibleAddCustomer = false;
  List<String> permission_code_name = [];

  // List<ItemModal> allitemData = [];

  double grandTotal = 0.0, subTotal = 0.0, totalDiscount = 0.0, netAmount = 0.0;

  Calc() {
    for (int i = 0; i < allModelData.length; i++) {
      subTotal += allModelData[i].amount;
      totalDiscount +=
          (allModelData[i].discount * allModelData[i].amount) / 100;
      netAmount = (subTotal - totalDiscount);
      grandTotal = netAmount;
      // log("${qtyController.")
      double a = double.parse(qtyController.text);
      log("$a");
      log("${a.runtimeType}");
    }
  }

  final player = AudioPlayer();

  void Notification() {
    // player.play('images/notificationIMS.mp3');
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime picked;
  CustomerServices customerServices = CustomerServices();
  // ListingServices listingServices = ListingServices();
  // Batch batch = Batch();
  int selectedId = 0;
  String discountInitial = "10.00";
  int discountId = 0;
  int itemId = 0;
  bool isVisible = false;
  bool isVisibleBatch = true;
  bool isVisibleSave = false;
  bool isVisibleSaveBatch = true;
  bool isSuperUser;

  orderDelete() {
    for (int i = 0; i < allModelData.length; i++) {}
  }

  @override
  void initState() {
    super.initState();
    final data = Provider.of<CustomerListProvider>(context, listen: false);
    data.fetchAllCustomer(context);
    final itemdata =
        Provider.of<CustomerItemListProvider>(context, listen: false);
    itemdata.fetchAllItem(context);
    setState(() {
      // listingServices;
      // customerServices;
      // batch;
    });
    getSuperUser();
    getAllowedFuctionsPermission();
    super.initState();
  }

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isSuperUser = pref.getBool("is_super_user");
    });
    log("final superuser" + isSuperUser.toString());
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
      return Colors.black;
    }

    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -0.94),
                  end: Alignment(0.968, 1.0),
                  colors: [Color(0xff2557D2), Color(0xff6b88e8)],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                //   color: Color(0xff2557D2)
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    'Create Customer Order',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   color: Colors.grey.shade300,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         child: const Text(
            //           "FIFO Wise:",
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            //         ),
            //       ),
            //       CupertinoSwitch(
            //         value: isChecked,
            //         onChanged: (value) {
            //           setState(() {
            //             isChecked = value;
            //             value = isChecked
            //                 ? isVisibleBatch = false
            //                 : isVisibleBatch = true;
            //             value = isChecked
            //                 ? isVisibleSave = true
            //                 : isVisibleSave = false;
            //             value = isChecked
            //                 ? isVisibleSaveBatch = false
            //                 : isVisibleSaveBatch = true;
            //           });
            //         },
            //         thumbColor: CupertinoColors.systemGrey,
            //         activeColor: CupertinoColors.white,
            //       ),
            //       // Checkbox(
            //       //   shape: const CircleBorder(),
            //       //   checkColor: Colors.white,
            //       //   fillColor: MaterialStateProperty.resolveWith(getColor),
            //       //   value: isChecked,
            //       //   onChanged: (bool? value) {
            //       //     setState(() {
            //       //       isChecked = value!;
            //       //       value = isChecked
            //       //           ? isVisibleBatch = false
            //       //           : isVisibleBatch = true;
            //       //       value = isChecked
            //       //           ? isVisibleSave = true
            //       //           : isVisibleSave = false;
            //       //       value = isChecked
            //       //           ? isVisibleSaveBatch = false
            //       //           : isVisibleSaveBatch = true;
            //       //     });
            //       //   },
            //       // ),
            //     ],
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xfff5f7ff),
                      offset: Offset(5, 8),
                      spreadRadius: 5,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Customer Name",
                            style: TextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          Container(
                            child: const Text(
                              "FIFO Wise:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          CupertinoSwitch(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
                                value = isChecked
                                    ? isVisibleBatch = false
                                    : isVisibleBatch = true;
                                value = isChecked
                                    ? isVisibleSave = true
                                    : isVisibleSave = false;
                                value = isChecked
                                    ? isVisibleSaveBatch = false
                                    : isVisibleSaveBatch = true;
                              });
                            },
                            thumbColor: CupertinoColors.systemGrey,
                            activeColor:
                                CupertinoColors.systemBlue.withOpacity(0.2),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.3,
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0, top: 2),
                                child: Consumer<CustomerListProvider>(
                                    builder: (context, message, child) {
                                  return DropdownButton<AllCustomer>(
                                    elevation: 24,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                          "${_selectedCustomerName.isEmpty ? "Select Branch" : _selectedCustomerName}"),
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
                                    items: message.allCustomer
                                        .map<DropdownMenuItem<AllCustomer>>(
                                            (AllCustomer name) {
                                      return DropdownMenuItem<AllCustomer>(
                                        value: name,
                                        child: Text(name.firstName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (AllCustomer newValue) {
                                      setState(
                                        () {
                                          _selectedCustomerName =
                                              newValue.firstName.toString();
                                          _selectedCustomer =
                                              newValue.id.toString();
                                          // _selecteduser = newValue.id;
                                          // subDomain = newValue.subDomain.toString();
                                        },
                                      );
                                    },
                                  );
                                })),
                          ),
                          Visibility(
                            // visible:permission_code_name.contains("add_customer")||isSuperUser == true?true :isVisibleAddCustomer,
                            child: Container(
                              child: Visibility(
                                // visible: permission_code_name
                                //             .contains("add_customer") ||
                                //         isSuperUser == true
                                //     ? true
                                //     : false,
                                child: GestureDetector(
                                  onTap: () => OpenDialog(context),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      child: const Icon(Icons.add)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Item"),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 2.25,
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
                                child: Consumer<CustomerItemListProvider>(
                                    builder: ((context, item, child) {
                                  return DropdownButton<ItemModel>(
                                    elevation: 24,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
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

                                          _taxable = value.taxable;
                                          _taxRate = value.taxRate.toString();
                                          _remainingQty = double.parse(
                                              "${value.remainingQty}");
                                          _selectedItemCost = value.saleCost;

                                          log('selected item is Taxable or not : ${_taxable.toString()}');
                                          log('cost : ${_selectedItemCost.toString()}');
                                          log('selected item taxRate : ${_taxRate.toString()}');
                                          log('selected item name : ${_selectedItemName.toString()}');
                                          log('selected item name : ${_selectedItem.toString()}');
                                        },
                                      );
                                    },
                                  );
                                })),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isVisibleBatch,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Select Batch"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.4,
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
                                          return Text("Select Batch");
                                        }

                                        return Consumer<BatchListProvider>(
                                            builder: (context, message, child) {
                                          return DropdownButton<ByBatchModel>(
                                            elevation: 24,
                                            isExpanded: true,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
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
                                            items: message.allBatch.map<
                                                    DropdownMenuItem<
                                                        ByBatchModel>>(
                                                (ByBatchModel name) {
                                              return DropdownMenuItem<
                                                  ByBatchModel>(
                                                value: name,
                                                child: Text(
                                                    name.batchNo.toString()),
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
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text("Sales Price"),
                                  Text("*",
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // permission_code_name
                              //             .contains("update_sale_cost") ||
                              //         isSuperUser == true
                              //     ?
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  controller: pricecontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "${_selectedItemCost ?? "0.0"}",
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                    contentPadding: const EdgeInsets.all(15),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        // blurRadius: 2,
                                        // offset: Offset(4, 4),
                                      )
                                    ]),
                              )
                              // : Container(
                              //     height: 45,
                              //     width:
                              //         MediaQuery.of(context).size.width / 4,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(12.0),
                              //       child:
                              //           Text("${_selectedItemCost ?? ""}"),
                              //     ),
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius:
                              //             BorderRadius.circular(15),
                              //         boxShadow: const [
                              //           BoxShadow(
                              //             color: Colors.grey,
                              //             spreadRadius: 1,
                              //             // blurRadius: 2,
                              //             // offset: Offset(4, 4),
                              //           )
                              //         ]),
                              //   ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text("Quantity"),
                                  Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  controller: qtyController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                                    borderRadius: BorderRadius.circular(15),
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
                              const Text("Delivery Location"),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  controller: locationController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                                    borderRadius: BorderRadius.circular(15),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text("Delivery Date"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: InkWell(
                                    onTap: () {
                                      _pickDateDialog();
                                    },
                                    child: TextField(
                                      controller: dateController,
                                      // keyboardType: TextInputType.text,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Delivery Date',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
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
                                const Text("Discount %"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: TextField(
                                    controller: discountPercentageController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
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
                                      borderRadius: BorderRadius.circular(15),
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
                                const Text("Remarks"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: TextField(
                                    controller: remarkscontroller,
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
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
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
                      Center(
                        child: SizedBox(
                          height: 35,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                // allBatch.clear();
                              });
                              final SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              String finalUrl =
                                  pref.getString("subDomain").toString();

                              double quantiy = double.parse(qtyController.text);
                              if (pricecontroller.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Enter the price",
                                    backgroundColor: Colors.redAccent,
                                    fontSize: 14);
                              }
                              // if (dateController.text.isEmpty) {
                              //   Fluttertoast.showToast(
                              //       msg: "Enter the date",
                              //       backgroundColor: Colors.redAccent,
                              //       fontSize: 18);
                              // }
                              if (qtyController.text.isEmpty ||
                                  qtyController.text.contains(".")) {
                                Fluttertoast.showToast(
                                    msg: "Enter the Quantity in correct format",
                                    backgroundColor: Colors.redAccent,
                                    fontSize: 18);
                              }
                              if (_remainingQty < quantiy ||
                                  _remainingQtyBatch < quantiy) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Quantity can not be greater than stock quantity",
                                    backgroundColor: Colors.redAccent,
                                    fontSize: 18);
                              } else {
                                if (discountPercentageController.text.isEmpty) {
                                  discountPercentageController.text = "0";
                                }
                                grandTotal = 0.0;
                                subTotal = 0.0;
                                totalDiscount = 0.0;
                                netAmount = 0.0;
                                setState(() {
                                  allModelData.add(
                                    AddItemModel(
                                        id: _selectedItem,
                                        name: _selectedItemName.toString(),
                                        quantity:
                                            double.parse(qtyController.text),
                                        price: pricecontroller.text.isEmpty
                                            ? _selectedItemCost
                                            : double.parse(
                                                pricecontroller.text),
                                        discount: double.parse(
                                            discountPercentageController.text),
                                        remarks: remarkscontroller.text,
                                        discountAmt: pricecontroller.text.isEmpty
                                            ? (double.parse(discountPercentageController.text) *
                                                (_selectedItemCost *
                                                    int.parse(
                                                        qtyController.text)) /
                                                100)
                                            : (double.parse(discountPercentageController.text) *
                                                (double.parse(pricecontroller.text) *
                                                    int.parse(
                                                        qtyController.text)) /
                                                100),
                                        amount: pricecontroller.text.isEmpty
                                            ? _selectedItemCost *
                                                int.parse(qtyController.text)
                                            : double.parse(pricecontroller.text) *
                                                int.parse(qtyController.text),
                                        totalAfterDiscount: pricecontroller.text.isEmpty
                                            ? (_selectedItemCost * int.parse(qtyController.text) -
                                                (double.parse(discountPercentageController.text) *
                                                    (_selectedItemCost * int.parse(qtyController.text)) /
                                                    100))
                                            : (double.parse(pricecontroller.text) * int.parse(qtyController.text) - (double.parse(discountPercentageController.text) * (double.parse(pricecontroller.text) * int.parse(qtyController.text)) / 100)),
                                        batchNo: _seletedBatch),
                                  );
                                  Calc();
                                  allModelData.isEmpty
                                      ? isVisible = false
                                      : isVisible = true;

                                  log('allModelData.length :' +
                                      allModelData.length.toString());
                                });
                              }
                              _selectedBatchNo = "Select Batch";
                              _selectedItemName = "Select Item";
                              qtyController.clear();
                              _remainingQty >= quantiy
                                  ? pricecontroller.clear()
                                  : null;
                              discountPercentageController.clear();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff5073d9)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                      const SizedBox(
                        height: 25,
                      ),
                      allModelData.isNotEmpty
                          ? Visibility(
                              visible: isVisible,
                              child: Column(
                                children: [
                                  DataTable(
                                    columns: const [
                                      DataColumn(
                                          label: Text("Name")),
                                      DataColumn(
                                          label: Text("Qty")),
                                      DataColumn(
                                          label: Text("Amt")),
                                      DataColumn(
                                          label: Text("Act")),
                                    ],
                                    rows: [
                                      for (int i = 0;
                                          i < allModelData.length;
                                          i++)
                                        DataRow(cells: [
                                          DataCell(
                                              SizedBox(
                                              child: Text(
                                            "${allModelData[i].name}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                          DataCell(Text(
                                              "${allModelData[i].quantity}")),
                                          DataCell(Text(
                                              "${allModelData[i].amount}")),
                                          DataCell(
                                            GestureDetector(
                                              onTap: () {
                                                log("Your data" +
                                                    allModelData.toString());

                                                setState(() {
                                                  allModelData
                                                      .remove(allModelData[i]);
                                                });
                                              },
                                              child: const FaIcon(
                                                FontAwesomeIcons.trash,
                                                size: 15,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ])
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Visibility(
                                        visible: isVisibleSave,
                                        child: Center(
                                          child: SizedBox(
                                            height: 35,
                                            width: 80,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  AddProduct();
                                                });

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  dismissDirection:
                                                      DismissDirection.down,
                                                  content: const Text(
                                                    "Product Added Successfully",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),

                                                  // margin: EdgeInsets.only(bottom: 70),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  elevation: 10,
                                                  backgroundColor: Colors.blue,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ));

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CustomerOrderListScreen(),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xff2658D3)),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
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
                                      ),
                                      Visibility(
                                        visible: isVisibleSaveBatch,
                                        child: Center(
                                          child: SizedBox(
                                            height: 35,
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Notification();
                                                setState(() {
                                                  AddProductByBatch();
                                                });

                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //   duration: const Duration(
                                                //       seconds: 2),
                                                //   dismissDirection:
                                                //       DismissDirection.down,
                                                //   content: const Text(
                                                //     "Product Added Successfully",
                                                //     style:
                                                //         TextStyle(fontSize: 20),
                                                //   ),
                                                //
                                                //   // margin: EdgeInsets.only(bottom: 70),
                                                //   padding:
                                                //       const EdgeInsets.all(10),
                                                //   elevation: 10,
                                                //   backgroundColor: Colors.blue,
                                                //   behavior:
                                                //       SnackBarBehavior.floating,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               5)),
                                                // ));

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CustomerOrderListScreen(),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xff2658D3)),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
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
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getAllowedFuctionsPermission() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (isSuperUser == false) {
        permission_code_name = pref.getStringList("permission_code_name");
      }
    });
    log("final codes" + permission_code_name.toString());
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

  Future AddProduct() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double grandTotal = 0.0,
        subTotal = 0.0,
        totalDiscount = 0.0,
        finaldiscount = 0.0,
        x = 0.0;
    var orderDetails = [];
    for (int i = 0; i < allModelData.length; i++) {
      subTotal += allModelData[i].amount;
      totalDiscount +=
          (allModelData[i].discount * allModelData[i].amount) / 100;
      finaldiscount = (subTotal - totalDiscount);
      grandTotal += (finaldiscount - allModelData[i].amount);
      x += allModelData[i].totalAfterDiscount;
      log("grand toral hjgjhghjgjgh" + x.toString());
      orderDetails.add({
        "item": allModelData[i].id,
        "item_category": 8,
        "taxable": _taxable,
        "discountable": "true",
        "qty": allModelData[i].quantity,
        "purchase_cost": 0,
        "sale_cost": allModelData[i].price,
        "discount_rate": allModelData[i].discount,
        "discount_amount": allModelData[i].discountAmt,
        "tax_rate": _taxRate,
        "tax_amount": 0,
        "gross_amount": allModelData[i].amount,
        "net_amount": allModelData[i].totalAfterDiscount,
        "remarks": allModelData[i].remarks,
        "isNew": "true",
        "unique": "2ed54673-a7b4-489f-91a2-98abe79241ee",
        "cancelled": "false"
      });
    }
    log('subTotal' + subTotal.toString());
    log('totalDiscount' + totalDiscount.toString());
    log('grandTotal' + x.toString());
    final responseBody = {
      "status": 1,
      "customer": _selectedCustomer,
      "sub_total": subTotal,
      "total_discount": totalDiscount,
      "total_tax": 0,
      "grand_total": x,
      "remarks": "",
      "total_discountable_amount": subTotal,
      "total_taxable_amount": 0,
      "total_non_taxable_amount": x,
      "discount_scheme": '',
      "discount_rate": 0,
      "delivery_location": locationController.text,
      "delivery_date_ad":
          dateController.text == "" ? null : dateController.text,
      "order_details": orderDetails,
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl/${StringConst.saveCustomerOrder}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201) {
      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

  Future AddProductByBatch() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double grandTotal = 0.0,
        subTotal = 0.0,
        totalDiscount = 0.0,
        finaldiscount = 0.0,
        x = 0.0;
    var orderDetails = [];
    for (int i = 0; i < allModelData.length; i++) {
      subTotal += allModelData[i].amount;
      totalDiscount +=
          (allModelData[i].discount * allModelData[i].amount) / 100;
      finaldiscount = (subTotal - totalDiscount);
      grandTotal += (finaldiscount - allModelData[i].amount);
      x += allModelData[i].totalAfterDiscount;
      log("grand toral hjgjhghjgjgh" + x.toString());
      orderDetails.add({
        "item": allModelData[i].id,
        "item_category": 1,
        "taxable": _taxable,
        "discountable": "true",
        "qty": allModelData[i].quantity,
        "purchase_cost": 0,
        "sale_cost": allModelData[i].price,
        "discount_rate": allModelData[i].discount,
        "discount_amount": allModelData[i].discountAmt,
        "tax_rate": _taxRate,
        "tax_amount": 0,
        "gross_amount": allModelData[i].amount,
        "net_amount": allModelData[i].totalAfterDiscount,
        "remarks": allModelData[i].remarks,
        // "isNew": "true",
        // "unique": "2ed54673-a7b4-489f-91a2-98abe79241ee",
        "cancelled": "false",
        "purchase_detail": allModelData[i].batchNo,
      });
    }
    log('subTotal' + subTotal.toString());
    log('totalDiscount' + totalDiscount.toString());
    log('grandTotal' + x.toString());
    final responseBody = {
      "status": 1,
      "customer": _selectedCustomer,
      "sub_total": subTotal,
      "total_discount": totalDiscount,
      "total_tax": 0,
      "grand_total": x,
      "remarks": "",
      "total_discountable_amount": subTotal,
      "total_taxable_amount": 0,
      "total_non_taxable_amount": x,
      "discount_scheme": '',
      "discount_rate": 0,
      "delivery_location": locationController.text,
      "delivery_date_ad":
          dateController.text == "" ? null : dateController.text,
      "order_details": orderDetails,
    };
    log("------XXXX----" + json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl/${StringConst.saveCustomerOrderByBatch}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        //ApiConstant.baseUrl + ApiConstant.saveCustomerOrder
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201||response.statusCode==200) {
      Fluttertoast.showToast(msg: "Product Added successfully");
      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }
}

Future OpenDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: (const Text(
                        'New Customer',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: GestureDetector(
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey.shade100,
                            child: const Icon(Icons.close,
                                color: Colors.red, size: 20)),
                        onTap: () => Navigator.pop(context, true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  color: Colors.blue,
                  height: 1,
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 200,
                    child: TextField(
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 100,
                    child: TextField(
                      controller: middleName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Middle Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: TextField(
                      controller: lastName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 200,
                    child: TextField(
                      controller: address,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 100,
                    child: TextField(
                      controller: contactNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Contact No.',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        // focusedBorder: InputBorder. none,
                        // enabledBorder: InputBorder. none,
                        // errorBorder: InputBorder. none,
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),

                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: TextField(
                      controller: PanNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Pan No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
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
                            offset: Offset(2, 2),
                          )
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.blue,
                height: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                width: 130,
                //color: Colors.grey,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (firstName.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter the First name.");
                    }
                    if (address.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter address.");
                    } else {
                      createCustomer();
                    }

                    // calculation();
                    // dateController.clear();
                    //  pricecontroller.clear();

                    //  qtycontroller.clear();
                    //  discountPercentageController.clear();

                    //AddProduct1();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff2658D3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          )),
    );

Future createCustomer() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.post(
      Uri.parse('https://$finalUrl/${StringConst.createCustomer}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
      body: json.encode({
        "device_type": 1,
        "app_type": 1,
        "first_name": firstName.text,
        "middle_name": middleName.text,
        "last_name": lastName.text,
        "address": address.text,
        "phone_no": contactNumber.text,
        "mobile_no": '',
        "email_id": "",
        "pan_vat_no": PanNumber.text,
        "tax_reg_system": 1,
        "active": true,
        "country": 1
      }));
  if (response.statusCode == 201) {
    firstName.clear();
    discountName.clear();
    discountRate.clear();
    middleName.clear();
    lastName.clear();
    address.clear();
    contactNumber.clear();
    PanNumber.clear();

    Fluttertoast.showToast(msg: "Customer created successfully!");
  }

  if (kDebugMode) {
    log('hello${response.statusCode}');
  }
  return response;
}
