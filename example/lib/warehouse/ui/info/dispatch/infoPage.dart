import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:zebra_datawedge/zebra_datawedge.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';

import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';



class DispatchTagInfo extends StatefulWidget {
  @override
  State<DispatchTagInfo> createState() => _DispatchTagInfoState();
}

class _DispatchTagInfoState extends State<DispatchTagInfo> {
  List<String> _packCodesListPackInfo = [];
  List<String> _packCodesID = [];

  List<String> locationNumber = [];

  // List<String> _savedPackCodesID = [];

  List<String> _scanedSerialNo = [];
  String _packCodeNo = '', _scanedLocationNo = '', receivedLocation = '';
  String _currentScannedCode = '';
  int totalSerialNo;

  List<String> _scannedIndex = [];

  @override
  void initState() {
    _newPickupInitDataWedgeListener();
    ZebraRfid.setEventHandler(ZebraEngineEventHandler(
      readRfidCallback: (datas) async {
        addDatas(datas);
      },
      errorCallback: (err) {
        ZebraRfid.toast(err.errorMessage);
      },
      connectionStatusCallback: (status) {
        setState(() {
          connectionStatus = status;
        });
      },
    ));

    ZebraRfid.connect();
    super.initState();
  }
  String _platformVersion = 'Unknown';
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ZebraRfid.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }
  Map<String, RfidData> rfidDatas = {};
  ReaderConnectionStatus connectionStatus = ReaderConnectionStatus.UnConnection;

  addDatas(List<RfidData> datas) async {
    for (var item in datas) {
      var data = rfidDatas[item.tagID];
      if (data != null) {
        data.count++;
        data.peakRSSI = item.peakRSSI;
        data.relativeDistance = item.relativeDistance;
      } else
        rfidDatas.addAll({item.tagID: item});
      if(rfidDocument.isNotEmpty){

      }else if(rfidDatas[item.tagID].peakRSSI>-40) {rfidDocument.add(item.tagID.toString());
      document = item.tagID.toString();
      }
    }
    setState(() {
      connectionStatus.name;
    });
  }
  List rfidDocument = [];
  String document = '';
  bool isSupplier= false;
  bool isValue= false;
  bool isStatus= false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.indigo;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dispatch Info"),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Dispatch Tag Code',
              style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            color: Color(0xffeff3ff),
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Text(
                "${rfidDocument.isEmpty ? "Please scan tag code" : rfidDocument[0]}"),
          ),
          kHeightMedium,
          kHeightMedium,

          rfidDocument.contains(document)
              ? FutureBuilder(
            future: PackInfoGetInfo(document.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              log("*-*-*-*-*-"+snapshot.data.toString());
              if(snapshot.data==null){
                return Text("Loading");
              }else
              if (snapshot.hasData) {
                try {
                  return snapshot.data[0]['id'].toString()=="null"?Container(
                      child:Text("${snapshot.data['msg']}",style: TextStyle(color: Colors.red),)
                  ):Column(
                    children: [
                      // Row(
                      //   children: [
                      //
                      //
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 10.0),
                      //       child: Container(
                      //         child:const Text(
                      //           "Suppplier",
                      //           style: TextStyle(
                      //               fontFamily: 'Arial', fontSize: 15,color: Color.fromRGBO(105, 131, 162, 20),fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left:0.0),
                      //       child: Checkbox(
                      //         shape: const CircleBorder(),
                      //         checkColor: Colors.white,
                      //         fillColor: MaterialStateProperty.resolveWith(getColor),
                      //         value: isSupplier,
                      //         onChanged: (bool value) {
                      //           setState(() {
                      //             // if(isCheckedDocument==false&&isCheckedVehicle==false)
                      //             isSupplier = value;
                      //             isValue= false;
                      //             isStatus= false;
                      //             // value= isCheckedLocation?isLocation == true:isLocation==false;
                      //             // value = isCheckedBulk ? isAsset = true: isAsset = false;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 0.0),
                      //       child: Container(
                      //         child:const Text(
                      //           " Asset Value",
                      //           style: TextStyle(
                      //               fontFamily: 'Arial', fontSize: 15,color: Color.fromRGBO(105, 131, 162, 20),fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left:0.0),
                      //       child: Checkbox(
                      //         shape: const CircleBorder(
                      //         ),
                      //         checkColor: Colors.white,
                      //         fillColor: MaterialStateProperty.resolveWith(getColor),
                      //         value: isValue,
                      //         onChanged: (bool value) {
                      //           setState(() {
                      //             // if(isCheckedAsset==false&&isCheckedVehicle==false)
                      //             isValue = value;
                      //             isSupplier = false;
                      //             isStatus = false;
                      //
                      //             // value = isCheckedInventory ? isLocation = false: isLocation = true;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 0.0),
                      //       child: Container(
                      //         child:const Text(
                      //           "Status",
                      //           style: TextStyle(
                      //               fontFamily: 'Arial', fontSize: 15,color: Color.fromRGBO(105, 131, 162, 20),fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left:0.0),
                      //       child: Checkbox(
                      //         shape: const CircleBorder(
                      //         ),
                      //         checkColor: Colors.white,
                      //         fillColor: MaterialStateProperty.resolveWith(getColor),
                      //         value: isStatus,
                      //         onChanged: (bool value) {
                      //           setState(() {
                      //             // if(isCheckedAsset==false&&isCheckedVehicle==false)
                      //             isStatus = value;
                      //             isSupplier = false;
                      //             isValue = false;
                      //
                      //
                      //             // value = isCheckedInventory ? isLocation = false: isLocation = true;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),

                      Container(
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
                                  child: const Text(" INFO",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: width * .2,
                                  child: const Text(
                                    'TYPE',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: width * .15,
                                  child: const Text(
                                    'BY',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: width * .2,
                                  child: const Text(
                                    'DATE',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: width * .2,
                                  child: const Text(
                                    'TO',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ],
                            rows: List.generate(
                                1,
                                    (index) => DataRow(

                                  // selected: true,
                                  cells: [
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          snapshot.data[0]['dispatch_info_display'].toString(),
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                        Text(

                                          snapshot.data[0]['dispatch_type_display'].toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold),
                                        )),
                                    DataCell(
                                        Text(

                                          snapshot.data[0]['dispatch_by']['user_name'].toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold),
                                        )),
                                    DataCell(
                                        Text(

                                          snapshot.data[0]['created_date_bs'].toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold),
                                        )),
                                    DataCell(
                                        Text(

                                          snapshot.data[0]['dispatch_to']['user_name'].toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold),
                                        )),
                                    // DataCell(
                                    //     GestureDetector(
                                    //       onTap: (){
                                    //         assetsummaryrfid.assetDetails[index].rfidTagCode==null?Fluttertoast.showToast(msg: "Bind the Rfid tag first"): Navigator.push(
                                    //             context, MaterialPageRoute(builder: (context)=>ScanToDropPage(
                                    //             rfidTag: assetsummaryrfid.assetDetails[index].rfidTagCode),
                                    //         ));
                                    //       },
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.only(left: 20.0),
                                    //         child: FaIcon(
                                    //           FontAwesomeIcons.dropbox,
                                    //           size: 12,
                                    //           color:
                                    //           Colors.indigo,
                                    //         ),
                                    //       ),
                                    //     )),
                                  ],
                                ))),
                      ),
                      // Visibility(
                      //   visible:isValue,
                      //   child: Container(
                      //     child: DataTable(
                      //
                      //         sortColumnIndex: 0,
                      //         sortAscending: true,
                      //         columnSpacing: 0,
                      //         horizontalMargin: 0,
                      //
                      //         // columnSpacing: 10,
                      //
                      //         columns: [
                      //           DataColumn(
                      //             label: SizedBox(
                      //               width: width * .25,
                      //               child: const Text("PUR COST",
                      //                 style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //           DataColumn(
                      //             label: SizedBox(
                      //               width: width * .15,
                      //               child: const Text("EOL",
                      //                 style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //
                      //
                      //         ],
                      //         rows: List.generate(
                      //             1,
                      //                 (index) => DataRow(
                      //
                      //               // selected: true,
                      //               cells: [
                      //                 DataCell(
                      //                     Text(
                      //
                      //                       snapshot.data[0]['created_date_bs'].toString(),
                      //                       style: const TextStyle(
                      //                           fontSize: 12,
                      //                           fontWeight:
                      //                           FontWeight.bold),
                      //                     )),
                      //                 DataCell(
                      //                   Padding(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     child: Text(
                      //                       snapshot.data[0]['dispatch_to']['user_name'].toString(),
                      //                       style: const TextStyle(
                      //                           fontSize: 11,
                      //                           fontWeight:
                      //                           FontWeight.bold),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //                 // DataCell(
                      //                 //     GestureDetector(
                      //                 //       onTap: (){
                      //                 //         assetsummaryrfid.assetDetails[index].rfidTagCode==null?Fluttertoast.showToast(msg: "Bind the Rfid tag first"): Navigator.push(
                      //                 //             context, MaterialPageRoute(builder: (context)=>ScanToDropPage(
                      //                 //             rfidTag: assetsummaryrfid.assetDetails[index].rfidTagCode),
                      //                 //         ));
                      //                 //       },
                      //                 //       child: Padding(
                      //                 //         padding: const EdgeInsets.only(left: 20.0),
                      //                 //         child: FaIcon(
                      //                 //           FontAwesomeIcons.dropbox,
                      //                 //           size: 12,
                      //                 //           color:
                      //                 //           Colors.indigo,
                      //                 //         ),
                      //                 //       ),
                      //                 //     )),
                      //               ],
                      //             ))),
                      //   ),
                      // ),
                      // Visibility(
                      //   visible:isStatus,
                      //   child: Container(
                      //     child: DataTable(
                      //
                      //         sortColumnIndex: 0,
                      //         sortAscending: true,
                      //         columnSpacing: 0,
                      //         horizontalMargin: 0,
                      //
                      //         // columnSpacing: 10,
                      //
                      //         columns: [
                      //           DataColumn(
                      //             label: SizedBox(
                      //               width: width * .2,
                      //               child: const Text(" LOCATION",
                      //                 style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //           DataColumn(
                      //             label: SizedBox(
                      //               width: width * .3,
                      //               child: const Text(
                      //                 'DEP',
                      //                 style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //           DataColumn(
                      //             label: SizedBox(
                      //               width: width * .2,
                      //               child: const Text(
                      //                 'ITEM',
                      //                 style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //
                      //         ],
                      //         rows: List.generate(
                      //             1,
                      //                 (index) => DataRow(
                      //
                      //               // selected: true,
                      //               cells: [
                      //                 DataCell(
                      //                   Padding(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     child: Text(
                      //                       snapshot.data[0]['dispatch_type_display'].toString(),
                      //                       style: const TextStyle(
                      //                           fontSize: 11,
                      //                           fontWeight:
                      //                           FontWeight.bold),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 DataCell(
                      //                     Text(
                      //
                      //                       snapshot.data[0]['dispatch_type_display'].toString(),
                      //                       style: const TextStyle(
                      //                           fontSize: 12,
                      //                           fontWeight:
                      //                           FontWeight.bold),
                      //                     )),
                      //                 DataCell(
                      //                     Text(
                      //
                      //                       snapshot.data[0]['dispatch_type_display'].toString(),
                      //                       style: const TextStyle(
                      //                           fontSize: 12,
                      //                           fontWeight:
                      //                           FontWeight.bold),
                      //                     )),
                      //                 // DataCell(
                      //                 //     GestureDetector(
                      //                 //       onTap: (){
                      //                 //         assetsummaryrfid.assetDetails[index].rfidTagCode==null?Fluttertoast.showToast(msg: "Bind the Rfid tag first"): Navigator.push(
                      //                 //             context, MaterialPageRoute(builder: (context)=>ScanToDropPage(
                      //                 //             rfidTag: assetsummaryrfid.assetDetails[index].rfidTagCode),
                      //                 //         ));
                      //                 //       },
                      //                 //       child: Padding(
                      //                 //         padding: const EdgeInsets.only(left: 20.0),
                      //                 //         child: FaIcon(
                      //                 //           FontAwesomeIcons.dropbox,
                      //                 //           size: 12,
                      //                 //           color:
                      //                 //           Colors.indigo,
                      //                 //         ),
                      //                 //       ),
                      //                 //     )),
                      //               ],
                      //             ))),
                      //   ),
                      // ),




                    ],
                  );



                  // Container(
                  //   child:Text("${snapshot.data['id']}")
                  // );

                } catch (e) {
                  throw Exception(e);
                }
              } else {
                return Text("No Asset found with this tag ",style: TextStyle(color: Colors.red),);
              }
            },
          )
              : Container(),
        ],
      ),
    );
  }






  Future<void> _newPickupInitDataWedgeListener() async {
    ZebraDataWedge.listenForDataWedgeEvent((response) {
      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);

          if (jsonResponse != null) {
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();

            if (_packCodesListPackInfo.isEmpty) {
              _packCodesListPackInfo.add(_currentScannedCode);
            } else {
              log('packo' + _packCodesListPackInfo.toString());
            }
          } else {
            // displayToast(msg: 'Something went wrong, Please Scan Again');
          }

          setState(() {});
        } catch (e) {
          // displayToast(msg: 'Something went wrong, Please Scan Again');
        }
      } else {
        // print('')
      }
    });
  }

  Future PackInfoGetInfo(String packCode) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    final response = await http.get(
      Uri.parse('https://$finalUrl${StringConst.dispatchtagInfo +
          packCode.toString()}'
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
    );
    log('https://$finalUrl${StringConst.assettagInfo +
        packCode.toString()}');
    log(response.statusCode.toString());
    if (response.statusCode == 200) {

      log('response body ' + response.body);

      return json.decode(response.body);
    }
    if (kDebugMode) {
      log('hello${response.statusCode}');
    }
  }


/*
  int pickupDetailsID;
  List<CustomerPackingType> customerPackingType;
  final  index;
  PickUpOrderSaveLocation(this.customerPackingType, this.pickupDetailsID, this.index);*/

}
