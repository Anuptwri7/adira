import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Assets/assteMaster/masterPage.dart';
import '../Assets/enrollAssets.dart';
import '../Constants/styleConst.dart';
import '../Home/Credit Managament/credit_clearance.dart';
import '../Home/Notification/controller/notificationController.dart';
import '../Home/Notification/notificationScreen.dart';
import '../Home/Party Pament/party_payment.dart';
import '../Home/addCustomerOrder.dart';
import '../Home/customer_detail_list.dart';
import '../Home/customer_order_list.dart';
import '../Home/quotation_page.dart';
import '../Home/stock management/stock_anaysis.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int numNotific = 10;

  bool isToBeExpandedFirst = false;
  bool isToBeExpandedSecond = false;
  bool isToBeExpandedThird = false;
  bool isToBeExpandedFourth = false;

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<NotificationClass>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            // const Icon(
            //   Icons.search,
            //   color: Color(0xff2c51a4),
            // ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()));
                    },
                  ),
                  // if (count.notificationCountModel?.unreadCount != null)
                  Positioned(
                    right: 0,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 12,
                      child: Text(
                        "9+",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  // else
                  //   Container()
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Inventory",
            style: TextStyle(),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        "assets/logo.png",
                        height: 40,
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 100,
                      decoration: BoxDecoration(
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
                        color: Colors.grey.shade50,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 450,

                            decoration: homePageContainerDecoration,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10, top: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Visibility(
                                            // visible: permission_code_name.contains("add_customer_order")||isSuperUser == true ?true:isVisibleCreateOrder,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  OpenDialogCustomerOrder(
                                                      context),
                                              // Navigator.push(
                                              // (context),
                                              // MaterialPageRoute(
                                              //     builder: (context) =>
                                              //
                                              // const AddPropertyTabPage()
                                              // )),
                                              child: Container(
                                                height: containerHeight,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                          "assets/create.png",
                                                          height: 60),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Customer Order",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Color(
                                                            0xff2C51A4,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                decoration:
                                                    homePageContainerDecoration,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),

                                          Visibility(
                                            // visible: permission_code_name.contains("view_customer_order")||permission_code_name.contains("self_customer_order")||isSuperUser == true?true:isVisibleCustomerOrder,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CustomerOrderListScreen()),
                                                ),
                                              },
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/order.png",
                                                            height: 60),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "View Orders",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2C51A4)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),
                                          // ),

                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            // visible: permission_code_name.contains("view_party_payment")
                                            //     || permission_code_name.contains("add_party_payment")||isSuperUser == true?
                                            // true:
                                            // isVisiblePartyPayment,
                                            child: InkWell(
                                              onTap: () {
                                                OpenDialog(context);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //         const PartyPayment()));
                                              },
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/payment.png",
                                                            height: 60),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Asset",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2C51A4)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Visibility(
                                            // visible: permission_code_name.contains("view_credit_clearance")||
                                            //     permission_code_name.contains("add_credit_clearance")||isSuperUser == true? true:
                                            // isVisibleCreditClearance,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const CreditClearance()));
                                              },
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/credit.png",
                                                            height: 60),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Recievable",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2C51A4)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            // visible: permission_code_name.contains("view_customer")||isSuperUser == true ?true:isVisibleCreateOrder,
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PartyPayment())),
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/person.png",
                                                            height: 60),
                                                        Text(
                                                          "Payable",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2C51A4)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),

                                          Visibility(
                                            // visible: permission_code_name.contains("view_stock_analysis")||isSuperUser == true?true:isVisibleCustomerOrder,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StockAnalysisPage(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/stock.png",
                                                            height: 60),
                                                        Text(
                                                          "Stock Analysis",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Color(
                                                              0xff2C51A4,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),
                                          // ),

                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            // visible: permission_code_name.contains("view_customer")||isSuperUser == true ?true:isVisibleCreateOrder,
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CustomerListings())),
                                              child: Container(
                                                  height: containerHeight,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            "assets/person.png",
                                                            height: 60),
                                                        Text(
                                                          "Customer List",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff2C51A4)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration:
                                                      homePageContainerDecoration),
                                            ),
                                          ),

                                          // ),

                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      // InkWell(
                                      //   // onTap: () {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) =>
                                      //   //               const CreditReport()));
                                      //   // },
                                      //   onTap: () async {
                                      //
                                      //   },
                                      //   child: Container(
                                      //     height: 40,
                                      //     width: 105,
                                      //     child: const Padding(
                                      //       padding: EdgeInsets.all(8),
                                      //       child: Center(
                                      //         child: Text(
                                      //           "View More",
                                      //           style:
                                      //               TextStyle(color: Color(0xff2C51A4)),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius: BorderRadius.circular(20),
                                      //       boxShadow: const [
                                      //         BoxShadow(
                                      //           color: Color(0xffeff3ff),
                                      //           offset: Offset(5, 8),
                                      //           spreadRadius: 5,
                                      //           blurRadius: 12,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 0,top: 00),
                          //   child: Row(
                          //     children: [
                          //       Text("Customer Order" ,style: TextStyle(color: Colors.blueGrey,),),
                          //       Transform.scale(
                          //         scale: 0.5,
                          //         child: CupertinoSwitch(
                          //           activeColor: Colors.grey.shade300,
                          //           thumbColor: Colors.indigo,
                          //           trackColor: Colors.grey,
                          //           value: isToBeExpandedFirst,
                          //           onChanged: (value) => setState(() => isToBeExpandedFirst = value),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   indent: 20,
                          //   color: Colors.blueGrey.shade200,
                          //   endIndent: 20,
                          // ),
                          // Visibility(
                          //   visible: isToBeExpandedFirst==true?true:false,
                          //   child: SingleChildScrollView(
                          //   scrollDirection:Axis.horizontal,
                          //     child: Row(
                          //       children: [
                          //
                          //         GestureDetector(
                          //           onTap: ()=>{
                          //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //           },
                          //           child: Container(
                          //               margin: EdgeInsets.only(left:5),
                          //               width: MediaQuery.of(context).size.width/4,
                          //               height: 50,
                          //               decoration: const BoxDecoration(
                          //
                          //                 borderRadius: BorderRadius.all(
                          //                   Radius.circular(18.0),
                          //                 ),
                          //                 color: Colors.white,
                          //               ),
                          //               child: Center(child: Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),))
                          //
                          //           ),
                          //         ),
                          //         GestureDetector(
                          //           onTap: ()=>{
                          //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //           },
                          //           child: Container(
                          //               margin: EdgeInsets.only(left: 5),
                          //               // width: MediaQuery.of(context).size.width/4,
                          //               height: 50,
                          //               decoration: const BoxDecoration(
                          //
                          //                 borderRadius: BorderRadius.all(
                          //                   Radius.circular(18.0),
                          //                 ),
                          //                 color: Colors.white,
                          //               ),
                          //               child: Center(child: Padding(
                          //                 padding: const EdgeInsets.all(10.0),
                          //                 child: Text("Create Customer",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //               ))
                          //
                          //           ),
                          //         ),
                          //
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 0,top: 0),
                          //   child: Row(
                          //     children: [
                          //       Text("Purchase Order Management" ,style: TextStyle(color: Colors.blueGrey,),),
                          //       Transform.scale(
                          //         scale: 0.5,
                          //         child: CupertinoSwitch(
                          //           activeColor: Colors.grey.shade300,
                          //           thumbColor: Colors.indigo,
                          //           trackColor: Colors.grey,
                          //           value: isToBeExpandedSecond,
                          //           onChanged: (value) => setState(() => isToBeExpandedSecond = value),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   indent: 20,
                          //   color: Colors.blueGrey.shade200,
                          //   endIndent: 20,
                          // ),
                          // Visibility(
                          //   visible: isToBeExpandedSecond==true?true:false,
                          //   child: SingleChildScrollView(
                          //     scrollDirection:Axis.horizontal,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(top: 10.0),
                          //       child: Row(
                          //         children: [
                          //
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left:5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("Purchase Order",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left: 5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("PO Receive",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left:5),
                          //                 width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Text("PO Verify",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left: 5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("PO Doc Setup",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //
                          //
                          //         ],
                          //       ),
                          //
                          //     ),
                          //   ),
                          // ),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 0,top: 0),
                          //   child: Row(
                          //     children: [
                          //       Text("Repair Management" ,style: TextStyle(color: Colors.blueGrey,),),
                          //       Transform.scale(
                          //         scale: 0.5,
                          //         child: CupertinoSwitch(
                          //           activeColor: Colors.grey.shade300,
                          //           thumbColor: Colors.indigo,
                          //           trackColor: Colors.grey,
                          //           value: isToBeExpandedThird,
                          //           onChanged: (value) => setState(() => isToBeExpandedThird = value),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   indent: 20,
                          //   color: Colors.blueGrey.shade200,
                          //   endIndent: 20,
                          // ),
                          // Visibility(
                          //   visible: isToBeExpandedThird==true?true:false,
                          //   child: SingleChildScrollView(
                          //     scrollDirection:Axis.horizontal,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(top: 10.0),
                          //       child: Row(
                          //         children: [
                          //
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left:5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("Repair",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left: 5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("Repair User",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //
                          //     ),
                          //   ),
                          // ),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 0,top: 0),
                          //   child: Row(
                          //     children: [
                          //       Text("Stock Management" ,style: TextStyle(color: Colors.blueGrey,),),
                          //       Transform.scale(
                          //         scale: 0.5,
                          //         child: CupertinoSwitch(
                          //           activeColor: Colors.grey.shade300,
                          //           thumbColor: Colors.indigo,
                          //           trackColor: Colors.grey,
                          //           value: isToBeExpandedFourth,
                          //           onChanged: (value) => setState(() => isToBeExpandedFourth = value),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   indent: 20,
                          //   color: Colors.blueGrey.shade200,
                          //   endIndent: 20,
                          // ),
                          // Visibility(
                          //   visible: isToBeExpandedFourth==true?true:false,
                          //   child: SingleChildScrollView(
                          //     scrollDirection:Axis.horizontal,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(top: 10.0),
                          //       child: Row(
                          //         children: [
                          //
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left:5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("Stock Analysis",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left: 5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("By Price",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetMasterPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left:5),
                          //                 width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Text("By Batch",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),))
                          //
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: ()=>{
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectOptionPage()))
                          //             },
                          //             child: Container(
                          //                 margin: EdgeInsets.only(left: 5),
                          //                 // width: MediaQuery.of(context).size.width/4,
                          //                 height: 50,
                          //                 decoration: const BoxDecoration(
                          //
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(18.0),
                          //                   ),
                          //                   color: Colors.white,
                          //                 ),
                          //                 child: Center(child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text("By Location",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 14),),
                          //                 ))
                          //
                          //             ),
                          //           ),
                          //
                          //
                          //         ],
                          //       ),
                          //
                          //     ),
                          //   ),
                          // ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future OpenDialogCustomerOrder(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: const Text(
                "Select one to Proceed",
                style: TextStyle(fontSize: 15),
              )),
              Container(
                decoration: const BoxDecoration(),
                // margin: const EdgeInsets.only(left: 220),
                child: GestureDetector(
                  child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey.shade100,
                      child:
                          const Icon(Icons.close, color: Colors.red, size: 20)),
                  onTap: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
          content: Container(
            height: 100,
            width: 200,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuotationPage()),
                      ),
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Image.asset("assets/quotation.png", height: 40),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Quotation",
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
                Visibility(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPropertyTabPage(),
                        ),
                      ),
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset("assets/create.png", height: 40),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Create Order",
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
          ),
        ),
      );

  Future OpenDialog(BuildContext context) => showDialog(
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.indigo.shade50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // height: MediaQuery.of(context).size.height/1.5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EnrollAssets())),
                          child: Container(
                              // height: dialogcontainerHeight,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset("assets/person.png",
                                        height: 60),
                                    Text(
                                      "Enroll Asset",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff2C51A4)),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: homePageContainerDecoration),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnrolledAssetMaster())),
                          child: Container(
                              // height: dialogcontainerHeight,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset("assets/person.png",
                                        height: 60),
                                    Text(
                                      "Asset List",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff2C51A4)),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: homePageContainerDecoration),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: -35,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.book_outlined,
                      size: 40,
                    ),
                    radius: 40,
                  )),
            ],
          ),
        ),
      );
}
