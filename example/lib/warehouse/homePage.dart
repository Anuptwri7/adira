import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Home/Notification/model/allNotification.dart';
import 'package:classic_simra/Home/Notification/services/notification_services.dart';
import 'package:classic_simra/warehouse/ui%20inventory/Pack%20Info/packInfoPage.dart';
import 'package:classic_simra/warehouse/ui%20inventory/audit/ui/audit_list.dart';
import 'package:classic_simra/warehouse/ui%20inventory/depratment%20transfer/transferMaster.dart';
import 'package:classic_simra/warehouse/ui%20inventory/drop/Bulk%20Drop/ui/bulkDropListPage.dart';
import 'package:classic_simra/warehouse/ui%20inventory/drop/ui/drop_%20order_list.dart';
import 'package:classic_simra/warehouse/ui%20inventory/in/po_in_list.dart';
import 'package:classic_simra/warehouse/ui%20inventory/location%20Shift/locationShiftPage.dart';
import 'package:classic_simra/warehouse/ui%20inventory/opening/ui/opening_list.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/pick_order_list.dart';
import 'package:classic_simra/warehouse/ui%20inventory/transfer%20Order/transferList.dart';
import 'package:classic_simra/warehouse/ui/Measure/qtyDrop.dart';
import 'package:classic_simra/warehouse/ui/Tasks/Task%20Lot%20Output/taskLotOutputDrop.dart';
import 'package:classic_simra/warehouse/ui/Tasks/taskMaster.dart';
import 'package:classic_simra/warehouse/ui/drop/homePage.dart';
import 'package:classic_simra/warehouse/ui/info/tagInfo.dart';
import 'package:classic_simra/warehouse/ui/pickUp/homePage.dart';
import 'package:classic_simra/warehouse/ui/return/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/stringConst.dart';
import '../Constants/styleConst.dart';
import '../Home/Notification/controller/notificationController.dart';
import '../Home/Notification/notificationScreen.dart';
import '../main.dart';

import 'package:http/http.dart' as http;

import 'assetsSubHomepage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String  name;
  int numNotific = 10;
  NotificationServices notificationServices = NotificationServices();
  Results results;
  bool isSuperUser;
  List<String> permission_code_name = [];

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isSuperUser =  pref.getBool("is_super_user") ;
    log("final superuser"+isSuperUser.toString());
  }
  @override
  void initState() {
    super.initState();
    getAllowedFuctionsPermission();
    final data = Provider.of<NotificationClass>(context, listen: false);
    data.fetchCount(context);
    notificationServices.fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<NotificationClass>(context);

    return  Scaffold(
      appBar:AppBar(
        actions: [
          // const Icon(
          //   Icons.search,
          //   color: Color(0xff2c51a4),
          // ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
              ),
              if (count.notificationCountModel?.unreadCount != null)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      "${(count.notificationCountModel?.unreadCount) > (numNotific) ?"9+":count.notificationCountModel?.unreadCount}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                Container()


            ],
          ),

          // const SizedBox(
          //   width: 10,
          // ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>  NotificationPage()));
            },
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: ()async{
                    final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],

        title: Row(
          children:  [

            Text(
              "ADIRA WAREHOUSE",
              style: TextStyle(color: Colors.blueGrey, fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50.0,left: 20,right:20 ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // height: 350,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Color(0x155665df),
                        spreadRadius: 5,
                        blurRadius: 17,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Stack(
                      children: [
                      Card(
                      elevation: 8.0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingOrderInList()));
                          },
                          focusColor: Colors.white,

                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            height: 60,
                            width: 150,
                            // color: Colors.blueGrey[700],
                            // color: Colors.white10,
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
                            child: Column(
                              children: [
                                Icon(
                               Icons.arrow_drop_up,
                                  size: 32,
                                  color: Colors.black,
                                ),
                                Text(
                              'Receive',
                                  style: kTextStyleBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Positioned(
                      //   right: 11,
                      //   top: 0,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(2),
                      //     decoration: BoxDecoration(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     constraints: const BoxConstraints(
                      //       minWidth: 18,
                      //       minHeight: 18,
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //        "${ count.notificationCountModel.customerOrderCount.toString()=="null"?"0":count.notificationCountModel.customerOrderCount}",
                      //         style: const TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold
                      //         ),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //     ),
                      //   ),
                      // )

                    ],
                  ),
                          kHeightVeryBig,
                          _poButtonDesign(Icons.arrow_drop_up,"Purchase Rec Drop",
                              goToPage: () => (OpenDialogCustomer(context))),
                        ],
                      ),
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesign(Icons.arrow_drop_up,"Pickup",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>PickOrder()))),
                          kHeightVeryBig,
                          Visibility(
                            visible: true,
                              child:_poButtonDesign(Icons.arrow_drop_up,"Pack Info",
                                  goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>PackInfo()))),
                          )

                        ],
                      ),
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesign(Icons.arrow_drop_up,"Location Shift",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationShifting()))),
                          kHeightVeryBig,
                          _poButtonDesign(Icons.arrow_drop_up,"Pre Proc Mgt",
                              goToPage: () =>{
                            openLotDialog(context)
                          }
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetsSubHomePage()))
                            ),
                        ],
                      ),

                      // kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // _poButtonDesign(Icons.arrow_drop_up,"Audit",
                          //     goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditList()))),
                          kHeightVeryBig,

                        ],
                      ),
                      _poButtonDesignLong(Icons.arrow_drop_up,"Open Stock",
                          goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>OpeningStockList()))),
                      kHeightVeryBig,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //
                      //     _poButtonDesign(Icons.arrow_drop_up,"Transfer",
                      //         goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferListPage()))),
                      //     kHeightVeryBig,
                      //     _poButtonDesign(Icons.arrow_drop_up,"Req Department",
                      //         goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestedDepartmentPage()))),
                      //   ],
                      // ),


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

  _poButtonDesign(IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Stack(
      children: [
      Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.white,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 60,
          width: 150,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
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
          child: Column(
            children: [
              Icon(
                buttonIcon,
                size: 32,
                color: Colors.black,
              ),
              Text(
                buttonString,
                style: kTextStyleBlack,
              ),
            ],
          ),
        ),
      ),
    ),

          // Positioned(
          //   right: 11,
          //   top: 0,
          //   child: Container(
          //     padding: const EdgeInsets.all(2),
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     constraints: const BoxConstraints(
          //       minWidth: 18,
          //       minHeight: 18,
          //     ),
          //     child: Center(
          //       child: Text(
          //         "5",
          //         style: const TextStyle(
          //           color: Colors.white,
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // )

      ],
    );

  }
  _poButtonDesignLong(IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Card(

      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.white,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 60,
          width: 150,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
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
          child: Column(
            children: [
              Icon(
                buttonIcon,
                size: 32,
                color: Colors.black,
              ),
              Text(
                buttonString,
                style: kTextStyleBlack,
              ),
            ],
          ),
        ),
      ),
    );

  }

  _poButtonDesignDailog(IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.white,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 60,
          width: 120,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
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
          child: Column(
            children: [
              SizedBox(height: 10,),
              Icon(
                buttonIcon,
                size: 20,
                color: Colors.black,
              ),
              // SizedBox(height: 5,),
              Text(
                buttonString,
                style: kTextStyleBlack,
              ),
            ],
          ),
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
}

_poButtonDesignDailog(IconData buttonIcon, String buttonString,
    { VoidCallback goToPage}) {
  return Card(
    elevation: kCardElevation,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: InkWell(
      focusColor: Colors.white,
      onTap: goToPage,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 60,
        width: 120,
        // color: Colors.blueGrey[700],
        // color: Colors.white10,
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
        child: Column(
          children: [
            SizedBox(height: 10,),
            Icon(
              buttonIcon,
              size: 20,
              color: Colors.black,
            ),
            // SizedBox(height: 5,),
            Text(
              buttonString,
              style: kTextStyleBlack,
            ),
          ],
        ),
      ),
    ),
  );
}
Future OpenDialogCustomer(BuildContext context) =>
    showDialog(
      barrierColor: Colors.black38,

      context: context,

      builder: (context) => Dialog(
        backgroundColor: Colors.indigo.shade50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // height:600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Column(
                    children: [
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesignDailog(Icons.arrow_circle_down_sharp, StringConst.bulkDrop,
                              goToPage: () => goToPage(context, BulkPODrop())),
                          kHeightVeryBig,
                          _poButtonDesignDailog(Icons.arrow_drop_down, StringConst.singleDrop,
                              goToPage: () => goToPage(context, PODrop())),
                          kHeightVeryBig,
                          kHeightVeryBig,
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView(
                            // controller: scrollController,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [

                            ],
                          ),


                        ],
                      ),


                    ],
                  ),
                ),

              ),
            ),
            Positioned(
                top:-35,

                child: CircleAvatar(
                  child: Icon(Icons.ac_unit_sharp,size: 40,),
                  radius: 40,

                )),

          ],
        ),
      ),

    );

Future openLotDialog(BuildContext context) =>
    showDialog(
      barrierColor: Colors.black38,

      context: context,

      builder: (context) => Dialog(
        backgroundColor: Colors.indigo.shade50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // height:600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Column(
                    children: [
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesignDailog(Icons.arrow_circle_down_sharp, "FG Drop",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LotOutputMasterPage()))),
                          kHeightVeryBig,
                          _poButtonDesignDailog(Icons.arrow_drop_down,"Task Pickup",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskMasterPage()))),
                          kHeightVeryBig,

                          kHeightVeryBig,
                        ],
                      ),

                      kHeightVeryBig,
                      _poButtonDesignDailog(Icons.arrow_drop_down,"Measure",
                          goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>QtyDropMaster()))),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView(
                            // controller: scrollController,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [

                            ],
                          ),


                        ],
                      ),


                    ],
                  ),
                ),

              ),
            ),
            Positioned(
                top:-35,

                child: CircleAvatar(
                  child: Icon(Icons.ac_unit_sharp,size: 40,),
                  radius: 40,

                )),

          ],
        ),
      ),

    );

