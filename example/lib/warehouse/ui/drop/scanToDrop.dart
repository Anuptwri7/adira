import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Assets/testPage.dart';
import 'package:classic_simra/TabPages/HomeTabPage.dart';
import 'package:classic_simra/provider/availableSerialCodes.dart';
import 'package:classic_simra/warehouse/ui/pickUp/homePage.dart';
import 'package:zebra_datawedge/zebra_datawedge.dart';
import 'dart:io';
import 'package:classic_simra/Assets/assetItem/categoryModel.dart';
import 'package:classic_simra/Assets/assetItem/model.dart';
import 'package:classic_simra/Assets/availableCode/model.dart';
import 'package:classic_simra/Assets/availableCode/services.dart';
import 'package:classic_simra/Assets/subCategory/services.dart';
import 'package:classic_simra/provider/categoryListProvider.dart';
import 'package:classic_simra/provider/model/subCategoryModel.dart';
import 'package:classic_simra/provider/subCategoryListProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';
import 'package:http/http.dart' as http;

import '../../../Constants/stringConst.dart';
import '../../../Constants/styleConst.dart';
import '../../provider/locatiobDropdown.dart';
import '../../provider/model/locationList.dart';
import 'homePage.dart';





class ScanToDropPage extends StatefulWidget {

  String rfidTag;

  ScanToDropPage({Key key,this.rfidTag}) : super(key: key);

  @override
  State<ScanToDropPage> createState() => _ScanToDropPageState();
}

class _ScanToDropPageState extends State<ScanToDropPage> {
  String dropdownValueCode= "Select Serial Codes";
  String dropdownvalueLocation = 'Select Location';
  List _selectedcodesList = [];
  int _selectedCodes;
  Codes codes = Codes();
  String _currentScannedCode = '';

  bool isCheckedAsset=true;
  bool isAsset = false;
  bool isDep1=false;
  bool isDep2=false;
  ByteData byteData;
  bool isCheckedBulk= false;
  bool isCheckedIndividual= false;
  List _selectedCodeId = [];
  String locationCode = '';
  List locationCodeList = [];
  Map dict = {};

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

    // final categorydata = Provider.of<CategoryListProvider>(context, listen: false);
    // categorydata.fetchAllCategory(context);
    ZebraRfid.connect();
    // log(androidBatteryInfo.pluggedStatus);

    super.initState();
    initPlatformState();
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

      }else if(rfidDatas[item.tagID].peakRSSI>-40)
      {
        if(widget.rfidTag==item.tagID){
          rfidDocument.add(item.tagID.toString());
        }else {
          Fluttertoast.showToast(msg: "Wrong Code Scanned");
        }
        document = item.tagID.toString();
      }
    }
    setState(() {
      connectionStatus.name;
    });
  }
  List rfidDocument = [];

  String document = '';


  @override
  Widget build(BuildContext context) {
    final itemdata = Provider.of<LocationList>(context, listen: false);
    itemdata.fetchAvailableLocationList();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Send Drop Details"),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery
                .of(context)
                .size
                .width,

            decoration:  BoxDecoration(
              // boxShadow: [

              // borderRadius: BorderRadius.all(
              //   Radius.circular(10.0),
              // ),
              // color:Color(0xfff4f7ff),
            ),
            child: Column(
              children: [
                Container(
                    child:Text("Rfid Tag to Scan")
                ),
                Container(
                    child:Text("${widget.rfidTag}",style:TextStyle(fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 20,),
                Container(
                    child:Text("Location to Drop")
                ),
                // Container(
                //   height: 50,
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width,
                //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                //   decoration: dropDownsDecoration,
                //   child: Consumer<LocationList>(
                //       builder: ((context, item, child) {
                //         return DropdownButton<ResultsLocation>(
                //           elevation: 24,
                //           isExpanded: true,
                //           hint: Padding(
                //             padding: const EdgeInsets.all(10.0),
                //             child: Text("${dropdownvalueLocation.isEmpty
                //                 ? "Select Location"
                //                 : dropdownvalueLocation}"),
                //           ),
                //           // value: snapshotData.first,
                //           iconSize: 24.0,
                //           icon: Icon(
                //             Icons.arrow_drop_down_circle,
                //             color: Colors.white,
                //           ),
                //           underline: Container(
                //             height: 2,
                //             color: Colors.white,
                //           ),
                //           items: item.allLocation
                //               .map<DropdownMenuItem<ResultsLocation>>((ResultsLocation items) {
                //             return DropdownMenuItem<ResultsLocation>(
                //               value: items,
                //               child: Text(items.code.toString()),
                //             );
                //           }).toList(),
                //           onChanged: (ResultsLocation newValue) {
                //             setState(
                //                   () {
                //
                //                 dropdownvalueLocation = newValue.code;
                //
                //                 log("--------------------------------" +
                //                     dropdownvalueLocation.toString());
                //
                //               },
                //             );
                //           },
                //         );
                //
                //       })),
                // ),
                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,

                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 6,
                            offset: Offset(4, 4),
                          )
                        ]),

                    child: Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                              visualDensity: VisualDensity(
                                  horizontal: 0, vertical: -4),
                              title: Center(
                                  child: Text('$locationCode',
                                    style: TextStyle(fontSize: 14),)));
                        },
                        itemCount: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    child:Text("Rfid tag to drop")
                ),
                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,

                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 6,
                            offset: Offset(4, 4),
                          )
                        ]),

                    child: Scrollbar(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                              visualDensity: VisualDensity(
                                  horizontal: 0, vertical: -4),
                              title: Center(
                                  child: Text('$rfidDocument',
                                    style: TextStyle(fontSize: 14),)));
                        },
                        itemCount: 1,
                      ),
                    ),
                  ),
                ),
                // for document

                // kHeightSmall,kHeightSmall,kHeightSmall,kHeightSmall,

                // for Save asset

                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: ElevatedButton(
                        onPressed: () {
                          assetDrop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff789cc8),
                            minimumSize: const Size.fromHeight(30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                          // maximumSize: const Size.fromHeight(56),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),

              ],
            )
        ),


      ),
    );

  }
  Future _newPickupInitDataWedgeListener() async {
    log("im here");
    ZebraDataWedge.listenForDataWedgeEvent((response) {
      log("im here");
      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);

          if (jsonResponse != null) {
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();
            log('packo' + _currentScannedCode.toString());

            if (locationCode.isEmpty) {
              locationCode=_currentScannedCode;
            } else {
              log('packo' + locationCode.toString());
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


  Future assetDrop() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final responseBody = {
      "rfid_tag_code": rfidDocument[0],
      "location_code": locationCode
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.assetDrop}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));

    log(responseBody.toString());
    // log(response.body);

    if (response.statusCode == 200||response.statusCode==201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Dropped Successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DropMaster()));
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }


}

