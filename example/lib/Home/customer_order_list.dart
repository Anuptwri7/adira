import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../BottomNavBar/bottomNavBar.dart';
import 'model/customer_order_list_model.dart';
import 'services/list_services.dart';
import 'widget/edit_all_item.dart';

class CustomerOrderListScreen extends StatefulWidget {
  const CustomerOrderListScreen({Key key}) : super(key: key);

  @override
  State<CustomerOrderListScreen> createState() =>
      _CustomerOrderListScreenState();
}

class _CustomerOrderListScreenState extends State<CustomerOrderListScreen> {
  // String get $i => null;
  ListingServices listingservices = ListingServices();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await listingservices.fetchOrderListFromUrl('');
    } else {
      return await listingservices.fetchOrderListFromUrl(_searchItem);
    }
  }

  Future CancelOrder(String cancelId) async {
    return await listingservices.cancelOrderFromUrl(cancelId);
  }

  @override
  void initState() {
    // searchHandling();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffeff3ff),
        body: Column(
          children: [
            Container(
              height:50,
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
                    'Customer Order',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 15, width: 15, color: const Color(0x96f2efb0)),
                const Text(
                  "PENDNING",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 15,
                  width: 15,
                  color: const Color(0xb0f5c4ce),
                ),
                const Text("Cancelled", style: TextStyle(fontSize: 10)),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.green.shade100,
                ),
                const Text("BILLED", style: TextStyle(fontSize: 10)),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.blue.shade100,
                ),
                const Text("CHALAN", style: TextStyle(fontSize: 10)),
              ],
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
                      top: 20, right: 5, left: 5, bottom: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, right: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                controller: _searchController,
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
                                    _searchItem = query;
                                  });
                                },
                                textCapitalization: TextCapitalization.sentences,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: FutureBuilder(
                          future: searchHandling(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                final snapshotData = json.decode(snapshot.data);
                                CustomerOrderList customerOrderList =
                                    CustomerOrderList.fromJson(snapshotData);
                                Color getColor() {
                                  for (int i = 0;
                                      i < customerOrderList.results.length;
                                      i++) {
                                    switch (customerOrderList.results[i].status) {
                                      case 0:
                                        if (customerOrderList.results[i].status
                                                .toString() ==
                                            "CHALAN") {
                                          return Colors.orange;
                                        }
                                        break;
                                      case 1:
                                        if (customerOrderList.results[i].status
                                                .toString() ==
                                            "PENDING") {
                                          return Colors.blue;
                                        }
                                        break;
                                      case 2:
                                        if (customerOrderList.results[i].status
                                                .toString() ==
                                            "CANCELLED") {
                                          return Colors.red;
                                        }
                                        break;
                                      case 3:
                                        if (customerOrderList.results[i].status
                                                .toString() ==
                                            "BILLED") {
                                          return Colors.blue;
                                        }
                                        break;
                                      default:
                                        return Colors.black;
                                    }
                                  }

                                  return Colors.black;
                                }

                                return SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: DataTable(
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      columnSpacing: 0,
                                      horizontalMargin: 0,

                                      // columnSpacing: 10,

                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .2,
                                            child: const Text(
                                              " CO No",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .2,
                                            child: const Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Text(
                                              'Status',
                                              style: TextStyle(
                                                  fontSize: 18,
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
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                          customerOrderList.results.length,
                                          (index) => DataRow(
                                                onLongPress: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         const ViewCustomerOrderDetails(
                                                  //       customerId: "412",
                                                  //       customerName:
                                                  //           "Rajan paudel",
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                // selected: true,
                                                cells: [
                                                  DataCell(
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: customerOrderList
                                                                    .results[
                                                                        index]
                                                                    .statusDisplay
                                                                    .toString() ==
                                                                "CANCELLED"
                                                            ? const Color(
                                                                0xb0f5c4ce)
                                                            : customerOrderList
                                                                        .results[
                                                                            index]
                                                                        .statusDisplay
                                                                        .toString() ==
                                                                    "PENDING"
                                                                ? const Color(
                                                                    0x96f2efb0)
                                                                : customerOrderList
                                                                            .results[
                                                                                index]
                                                                            .statusDisplay
                                                                            .toString() ==
                                                                        "BILLED"
                                                                    ? const Color(
                                                                        0xb0c8f1cd)
                                                                    : customerOrderList
                                                                                .results[
                                                                                    index]
                                                                                .statusDisplay
                                                                                .toString() ==
                                                                            "CHALAN"
                                                                        ? const Color(
                                                                            0xb0c8e1f5)
                                                                        : Colors
                                                                            .white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10.0),
                                                        child: Text(
                                                          customerOrderList
                                                              .results[index]
                                                              .orderNo
                                                              .toString(),
                                                          style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(Container(
                                                    height: 40,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      color: customerOrderList
                                                                  .results[index]
                                                                  .statusDisplay
                                                                  .toString() ==
                                                              "CANCELLED"
                                                          ? const Color(
                                                              0xb0f5c4ce)
                                                          : customerOrderList
                                                                      .results[
                                                                          index]
                                                                      .statusDisplay
                                                                      .toString() ==
                                                                  "PENDING"
                                                              ? const Color(
                                                                  0x96f2efb0)
                                                              : customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .statusDisplay
                                                                          .toString() ==
                                                                      "BILLED"
                                                                  ? const Color(
                                                                      0xb0c8f1cd)
                                                                  : customerOrderList
                                                                              .results[
                                                                                  index]
                                                                              .statusDisplay
                                                                              .toString() ==
                                                                          "CHALAN"
                                                                      ? const Color(
                                                                          0xb0c8e1f5)
                                                                      : Colors
                                                                          .white,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        customerOrderList
                                                            .results[index]
                                                            .customerFirstName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  )),
                                                  DataCell(
                                                    Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: customerOrderList
                                                                    .results[
                                                                        index]
                                                                    .statusDisplay
                                                                    .toString() ==
                                                                "CANCELLED"
                                                            ? const Color(
                                                                0xb0f5c4ce)
                                                            : customerOrderList
                                                                        .results[
                                                                            index]
                                                                        .statusDisplay
                                                                        .toString() ==
                                                                    "PENDING"
                                                                ? const Color(
                                                                    0x96f2efb0)
                                                                : customerOrderList
                                                                            .results[
                                                                                index]
                                                                            .statusDisplay
                                                                            .toString() ==
                                                                        "BILLED"
                                                                    ? const Color(
                                                                        0xb0c8f1cd)
                                                                    : customerOrderList
                                                                                .results[
                                                                                    index]
                                                                                .statusDisplay
                                                                                .toString() ==
                                                                            "CHALAN"
                                                                        ? const Color(
                                                                            0xb0c8e1f5)
                                                                        : Colors
                                                                            .white,
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: customerOrderList
                                                                      .results[
                                                                          index]
                                                                      .statusDisplay
                                                                      .toString() ==
                                                                  "CANCELLED"
                                                              ? const Color(
                                                                  0xffcb1d41)
                                                              : customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .statusDisplay
                                                                          .toString() ==
                                                                      "PENDING"
                                                                  ? const Color(
                                                                      0xffe8d72f)
                                                                  : customerOrderList
                                                                              .results[
                                                                                  index]
                                                                              .statusDisplay
                                                                              .toString() ==
                                                                          "BILLED"
                                                                      ? const Color(
                                                                          0xff39d94d)
                                                                      : customerOrderList.results[index].statusDisplay.toString() ==
                                                                              "CHALAN"
                                                                          ? const Color(
                                                                              0xff2f93e4)
                                                                          : Colors
                                                                              .white,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(15),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            customerOrderList
                                                                .results[index]
                                                                .statusDisplay
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w900,
                                                              fontSize: 12,
                                                              color: Colors.white,
                                                              // shadows: [
                                                              //   Shadow( // bottomLeft
                                                              //       offset: Offset(-1.5, -1.5),
                                                              //       color: Colors.white
                                                              //   ),
                                                              //   Shadow( // bottomRight
                                                              //       offset: Offset(1.5, -1.5),
                                                              //       color: Colors.white
                                                              //   ),
                                                              //   Shadow( // topRight
                                                              //       offset: Offset(1.5, 1.5),
                                                              //       color: Colors.white
                                                              //   ),
                                                              //   Shadow( // topLeft
                                                              //       offset: Offset(-1.5, 1.5),
                                                              //       color: Colors.white
                                                              //   ),
                                                              // ]
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: customerOrderList
                                                                    .results[
                                                                        index]
                                                                    .statusDisplay
                                                                    .toString() ==
                                                                "CANCELLED"
                                                            ? Colors.red.shade100
                                                            : customerOrderList
                                                                        .results[
                                                                            index]
                                                                        .statusDisplay
                                                                        .toString() ==
                                                                    "PENDING"
                                                                ? const Color(
                                                                    0x96f2efb0)
                                                                : customerOrderList
                                                                            .results[
                                                                                index]
                                                                            .statusDisplay
                                                                            .toString() ==
                                                                        "BILLED"
                                                                    ? const Color(
                                                                        0xb0c8f1cd)
                                                                    : customerOrderList
                                                                                .results[
                                                                                    index]
                                                                                .statusDisplay
                                                                                .toString() ==
                                                                            "CHALAN"
                                                                        ? const Color(
                                                                            0xb0c8e1f5)
                                                                        : Colors
                                                                            .white,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .status
                                                                          .toString() ==
                                                                      "1"
                                                                  ? OpenDialog(
                                                                      context,
                                                                      customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .id
                                                                          .toString())
                                                                  : null;
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: customerOrderList
                                                                            .results[
                                                                                index]
                                                                            .status
                                                                            .toString() ==
                                                                        "1"
                                                                    ? Colors.redAccent[
                                                                        700]
                                                                    : Colors
                                                                        .red[300],
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius.circular(
                                                                      5),
                                                                ),
                                                              ),
                                                              child: const Center(
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .trash,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              (!customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .approved &&
                                                                      !customerOrderList
                                                                          .results[
                                                                              index]
                                                                          .isPicked)
                                                                  ? Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ViewDetails(
                                                                          isApproved: customerOrderList
                                                                              .results[index]
                                                                              .approved,
                                                                          userId: customerOrderList
                                                                              .results[index]
                                                                              .id
                                                                              .toString(),
                                                                          userName: customerOrderList
                                                                              .results[index]
                                                                              .customerFirstName
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : null;
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: (!customerOrderList
                                                                              .results[
                                                                                  index]
                                                                              .approved &&
                                                                          !customerOrderList
                                                                              .results[
                                                                                  index]
                                                                              .isPicked)
                                                                      ? Colors.indigo[
                                                                          900]
                                                                      : Colors.indigo[
                                                                          200],
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: const Center(
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .penToSquare,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))),
                                );
                              } catch (e) {
                                throw Exception(e);
                              }
                            } else {
                              return Text('Loading Please wait');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future OpenDialog(BuildContext context, String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                margin: const EdgeInsets.only(left: 220),
                child: GestureDetector(
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade100,
                      child:
                          const Icon(Icons.close, color: Colors.red, size: 20)),
                  onTap: () => Navigator.pop(context, true),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: (const Text(
                  'Are You Sure ? Want to cancel the order',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CancelOrder(id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      },
                      child: const Text("Yes"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      );
}
