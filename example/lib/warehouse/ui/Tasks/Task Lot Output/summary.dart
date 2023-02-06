import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/warehouse/ui/Tasks/Task%20Lot%20Output/taskLotOutputDrop.dart';
import 'package:zebra_datawedge/zebra_datawedge.dart';

import 'package:classic_simra/Assets/availableCode/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';
import 'package:http/http.dart' as http;
import 'package:classic_simra/warehouse/ui/Tasks/model/lotOutputDetail.dart';
import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';






class ScanToDropLotOutputPage extends StatefulWidget {
  String id;

  ScanToDropLotOutputPage({Key key,this.id}) : super(key: key);

  @override
  State<ScanToDropLotOutputPage> createState() => _ScanToDropLotOutputPageState();
}

class _ScanToDropLotOutputPageState extends State<ScanToDropLotOutputPage> {
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
  // List pkCode=[];
String pkCode='';
List scannedPackCodes = [];
List<String> recPackCode = [];

String purchase_detail ='';
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
        {
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
        title: Text("Drop Details"),
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

                FutureBuilder<List<Results>>(
                    future: getDetail(widget.id),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return _pickOrderCards(snapshot.data);
                          }
                      }
                    }),
                // displaySerialNos(),
                Container(
                    child:Text("",style:TextStyle(fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 20,),
                Container(
                    child:Text("Location to Drop")
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
                    child:Text("PK to Drop")
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
                                  child: Text('$scannedPackCodes',
                                    style: TextStyle(fontSize: 14),)));
                        },
                        itemCount: 1,
                      ),
                    ),
                  ),
                ),


                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: ElevatedButton(
                        onPressed: () {
                            UpdateLocation();
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
  _pickOrderCards(List<Results> data) {

    return data != null
        ? ListView.builder(

        shrinkWrap: true,
        itemCount: data[0].puPackTypeCodes.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
            purchase_detail = data[index].id.toString();
          return Padding(
            padding: const EdgeInsets.only(left:10.0,top:20),
            child: Row(
              children: [
         Text("${data[0].puPackTypeCodes[index].code.toString()} "),

                    Text("${data[0].puPackTypeCodes[index].location==null?"No Location":data[0].puPackTypeCodes[index].location} ") ,

              ],
            ),
          );
        })
        : Center(
      child: Text(
        StringConst.noDataAvailable,
        style: kTextStyleBlack,
      ),
    );
  }
  // displaySerialNos() {
  //   return Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: );
  // }

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
            } else if(!locationCode.isEmpty) {
              // pkCode.add(_currentScannedCode);
              pkCode=_currentScannedCode.toString();
              scannedPackCodes.add(_currentScannedCode);
              log('packo' + pkCode.toString());
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
  Future UpdateLocation() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

      final packCode = [];
      
      List multiplePackCode = [];
      for(int i=0;i<scannedPackCodes.length;i++){
        multiplePackCode.add(  {
          "pack_type_code": scannedPackCodes[i],
          "purchase_detail_id": purchase_detail
        });
      }

    final responseBody = {
      "pack_type_codes": multiplePackCode,
      "location_code": locationCode
    };

    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.bulkUpdateLocationlot}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    // log(response.body);
    log(json.encode(responseBody));
    if (response.statusCode == 200||response.statusCode==201) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LotOutputMasterPage()));
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Dropped Successfully");

      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }


  Future<List<Results>> getDetail(String id) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.lotOutputDetail+id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
  );

    log(response.body);

    if (response.statusCode == 200||response.statusCode==201) {
        return LotOutputDetailModel.fromJson(jsonDecode(response.body)).results;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }


  }


}

