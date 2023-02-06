import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../model/addModel.dart';
import '../model/order_summary_list.dart';
import '../services/list_services.dart';
import 'edit_widget.dart';

class ViewDetails extends StatefulWidget {
  final String userId;
  final String userName;
  final bool isApproved;
  const ViewDetails({Key key, this.userId, this.userName, this.isApproved})
      : super(key: key);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  ListingServices listingservices = ListingServices();

  List<AddItemModel> allModelData = [];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              //   color: Color(0xff2557D2)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  widget.userName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
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
                padding: const EdgeInsets.only(
                    top: 20, right: 5, left: 5, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormField(
                              // controller: _searchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                prefixIcon: const Icon(Icons.search),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                errorMaxLines: 4,
                              ),
                              // validator: validator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (query) {
                                setState(() {
                                  // _searchItem = query;
                                });
                              },
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          //color: Colors.grey,
                          // padding: const EdgeInsets.only(left: 120, right: 120),
                          child: ElevatedButton(
                            onPressed: () async {
                              (!widget.isApproved && allModelData.isNotEmpty)
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Edit(
                                          byBatch: allModelData[0].isByBatch,
                                          allModelData: allModelData,
                                          updateId: widget.userId,
                                          customerId: allModelData[0]
                                              .customerId
                                              .toString(),
                                          userName: widget.userName,
                                        ),
                                      ),
                                    )
                                  : null;
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff2658D3).withOpacity(0.9)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    //  side: BorderSide(color: Colors.red)
                                  ),
                                )),
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.73,
                      child: FutureBuilder(
                        future: listingservices.fetchOrderSummaryListFromUrl(
                            widget.userId.toString()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            try {
                              final snapshotData = json.decode(snapshot.data);

                              OrderSummaryList orderSummaryList =
                                  OrderSummaryList.fromJson(snapshotData);

                              // List<OrderDetails> orderDetails = [];
                              allModelData.clear();

                              for (int i = 0;
                                  i < orderSummaryList.orderDetails.length;
                                  i++) {
                                if (!orderSummaryList
                                    .orderDetails[i].cancelled) {
                                  allModelData.add(
                                    AddItemModel(
                                      id: orderSummaryList.orderDetails[i].id,
                                      name: orderSummaryList
                                          .orderDetails[i].item.name,
                                      quantity: double.parse(orderSummaryList
                                          .orderDetails[i].qty
                                          .toString()),
                                      price: double.parse(orderSummaryList
                                          .orderDetails[i].netAmount
                                          .toString()),
                                      discount: double.parse(orderSummaryList
                                          .orderDetails[i].discountRate
                                          .toString()),
                                      discountAmt: (double.parse(
                                          orderSummaryList
                                              .orderDetails[i].discountAmount
                                              .toString())),
                                      amount: double.parse(orderSummaryList
                                          .orderDetails[i].grossAmount
                                          .toString()),
                                      totalAfterDiscount: (double.parse(
                                        orderSummaryList
                                            .orderDetails[i].netAmount
                                            .toString(),
                                      )),
                                      isNew: false,
                                      isByBatch: orderSummaryList.byBatch,
                                      customerId: orderSummaryList.customer.id,
                                    ),
                                  );
                                }
                              }

                              log(allModelData.length.toString());

                              return SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: DataTable(
                                  columnSpacing: 10,
                                  horizontalMargin: 0,
                                  // columnSpacing: 10,
                                  columns: [
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Text(
                                          "Name",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .15,
                                        child: const Text(
                                          'Amount',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Center(
                                            child: Text(
                                          'Action',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                    allModelData.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(allModelData[index]
                                              .name
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(allModelData[index]
                                              .quantity
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(allModelData[index]
                                              .amount
                                              .toString()),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // InkWell(
                                              //   onTap: () {
                                              //     Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (_) => Edit(
                                              //                 byBatch:
                                              //                     orderSummaryList
                                              //                         .byBatch!,
                                              //                 allModelData:
                                              //                     allModelData,
                                              //                 updateId:
                                              //                     widget.userId,
                                              //                 customerId:
                                              //                     orderSummaryList
                                              //                         .customer!
                                              //                         .id
                                              //                         .toString(),
                                              //                 userName: widget
                                              //                     .userName)));
                                              //   },
                                              //   child: Container(
                                              //     height: 20,
                                              //     width: 20,
                                              //     decoration: BoxDecoration(
                                              //         color: Colors.indigo[900],
                                              //         borderRadius:
                                              //             const BorderRadius
                                              //                     .all(
                                              //                 Radius.circular(
                                              //                     5))),
                                              //     child: const Center(
                                              //       child: FaIcon(
                                              //         FontAwesomeIcons.pencil,
                                              //         size: 12,
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),

                                              InkWell(
                                                onTap: () {
                                                  if (allModelData.length ==
                                                      1) {
                                                    Fluttertoast.showToast(
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      fontSize: 20,
                                                      backgroundColor:
                                                          Colors.red,
                                                      msg:
                                                          "There is only one saved Item so cancel whole order or add some item and save them then try again !!!",
                                                    );
                                                  } else {
                                                    setState(
                                                      () {
                                                        ListingServices()
                                                            .CancelSingleOrderFromUrl(
                                                          allModelData[index]
                                                              .id
                                                              .toString(),
                                                        );
                                                      },
                                                    );
                                                    allModelData.clear();
                                                  }
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.redAccent[700],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.xmark,
                                                      size: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              throw Exception(e);
                            }
                          } else {
                            return Text(
                              'Loading Customer Order Data',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.withOpacity(0.2)),
                            );
                          }
                        },
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
        ],
      ),
    );
  }
}
