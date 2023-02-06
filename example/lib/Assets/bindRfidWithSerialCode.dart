import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Assets/testPage.dart';
import 'package:classic_simra/TabPages/HomeTabPage.dart';
import 'package:classic_simra/provider/availableSerialCodes.dart';
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

import '../Constants/stringConst.dart';
import '../Constants/styleConst.dart';
import '../provider/itemListProvider.dart';
import 'assetItem/services.dart';
import 'assetSummary/assetSummary.dart';
import 'assteMaster/masterPage.dart';



class RfidBindWithSerialCode extends StatefulWidget {

  String serial;
  int id;

  RfidBindWithSerialCode({Key key,this.serial,this.id}) : super(key: key);

  @override
  State<RfidBindWithSerialCode> createState() => _RfidBindWithSerialCodeState();
}

class _RfidBindWithSerialCodeState extends State<RfidBindWithSerialCode> {
  String dropdownValueCode= "Select Serial Codes";
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
  List availableCodes = [];
  List _selectedCodeId = [];
  Map dict = {};

  void initState() {
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
    _newPickupInitDataWedgeListener();
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


  @override
  Widget build(BuildContext context) {
    context.read<CategoryListProvider>().fetchAllCategory();

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
        title: Text("Scan Assets"),
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
                                  child: Text('$document',
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
                          RfidBindWithSerialCode(widget.serial);
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
  Future<void> _newPickupInitDataWedgeListener() async {
    ZebraDataWedge.listenForDataWedgeEvent((response) {
      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);
          if (jsonResponse != null) {
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();
            log(_currentScannedCode);
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
  availableCodeList(List<ResultCodes> data) {
    return data !=null
        ? Container(
      height: MediaQuery.of(context).size.height/3,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {

            /*Save PackType codes*/


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: 200,
                decoration:  BoxDecoration(
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
                child: Center(child: Text("${data[index].code}",style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
            );
          }),
    )
        : const Text('We have no Data for now');
  }

  Future RfidBindWithSerialCode(String serial) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    log(_selectedCodes.toString());
    final responseBody = {
      "device_type": 1,
      "app_type": 1,
      "code": document
    };
    // log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.assetAssign+serial}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    log(response.body);
    log('https://$finalUrl${StringConst.assetAssign+serial}');
    if (response.statusCode == 200||response.statusCode==201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Asset Enrolled Successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EnrolledAssetMaster()));
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }


}

