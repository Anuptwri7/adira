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



class EnrollAssetsSecondPage extends StatefulWidget {
  int itemId;
  int categoryId;
  int subCategoryId;
  String tittle;
  String describe;
  String depMethod;
  String net;
  String qty;
  String warrnety;
  String amc;
  String maintain;
  String eol;
  String salvage;
  String depRate;
  String book;

   EnrollAssetsSecondPage({Key key,this.itemId,this.categoryId,this.subCategoryId,this.tittle,this.describe,this.depMethod,this.net
   ,this.qty,this.warrnety,this.amc,this.maintain,this.eol,this.salvage,this.depRate,this.book}) : super(key: key);

  @override
  State<EnrollAssetsSecondPage> createState() => _EnrollAssetsSecondPageState();
}

class _EnrollAssetsSecondPageState extends State<EnrollAssetsSecondPage> {
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
  List _selectedCodeId = [];
  Map dict = {};
  List _packCodesListPackInfo=[];
  List scannedSerialCodes=[];
  List availableCodes = [];

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

            ),
            child: Column(
              children: [
                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Checkbox(
                        shape: const CircleBorder(),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isCheckedBulk,
                        onChanged: (bool value) {
                          setState(() {
                            // if(isCheckedDocument==false&&isCheckedVehicle==false)
                            isCheckedBulk = value;
                            isCheckedIndividual= false;
                            // value= isCheckedLocation?isLocation == true:isLocation==false;
                            // value = isCheckedBulk ? isAsset = true: isAsset = false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        child:const Text(
                          "Bulk",
                          style: TextStyle(
                              fontFamily: 'Arial', fontSize: 15,color: Color.fromRGBO(105, 131, 162, 20),fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Checkbox(
                        shape: const CircleBorder(
                        ),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isCheckedIndividual,
                        onChanged: (bool value) {
                          setState(() {
                            // if(isCheckedAsset==false&&isCheckedVehicle==false)
                            isCheckedIndividual = value;
                            isCheckedBulk = false;

                            // value = isCheckedInventory ? isLocation = false: isLocation = true;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        child:const Text(
                          "Individual",
                          style: TextStyle(
                              fontFamily: 'Arial', fontSize: 15,color: Color.fromRGBO(105, 131, 162, 20),fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  ],
                ),
                // Container(
                //   height: 50,
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width,
                //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                //   decoration: dropDownsDecoration,
                //   child: FutureBuilder(
                //     future: codes.fetchAvailableCodes(widget.itemId.toString()),
                //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                //       if(snapshot.data==null){
                //         return Text("Loading");
                //       }
                //       if(snapshot.hasError){
                //         return Text("Loading");
                //       }
                //       if (snapshot.hasData) {
                //         try {
                //           final List<ResultCodes> snapshotData = snapshot.data;
                //           return DropdownButton<ResultCodes>(
                //             elevation: 24,
                //             isExpanded: true,
                //             hint: Padding(
                //               padding: const EdgeInsets.only(left:15.0),
                //               child: Text("${dropdownValueCode.isEmpty?"Select Serial Codes":dropdownValueCode}"),
                //             ),
                //             // value: snapshotData.first,
                //             iconSize: 24.0,
                //             icon: Icon(
                //               Icons.arrow_drop_down_circle,
                //               color: Colors.grey,
                //             ),
                //             underline: Container(
                //               height: 2,
                //               color: Colors.indigo.shade50,
                //             ),
                //             items: snapshotData
                //                 .map<DropdownMenuItem<ResultCodes>>((ResultCodes items) {
                //               return DropdownMenuItem<ResultCodes>(
                //                 value: items,
                //                 child: Text(items.code.toString()),
                //               );
                //             }).toList(),
                //             onChanged: (ResultCodes newValue) {
                //               setState(
                //                     () {
                //                       dropdownValueCode = newValue.code.toString();
                //                       _selectedCodes = newValue.id;
                //                     if(isCheckedIndividual==true){
                //
                //                     }else{
                //                       _selectedcodesList.add(dropdownValueCode);
                //                       _selectedCodeId.add(newValue.id);
                //                     }
                //
                //                 },
                //               );
                //             },
                //           );
                //         } catch (e) {
                //           throw Exception(e);
                //         }
                //       } else {
                //         return Text(snapshot.error.toString());
                //       }
                //     },
                //   ),
                // ),

                // FutureBuilder(
                //     future: codes.fetchAvailableCodes(widget.itemId.toString()),
                //     builder: (context, snapshot) {
                //
                //           if (snapshot.hasError) {
                //             // log(snapshot.data.toString());
                //             return Text('Error: ${snapshot.error}');
                //           } else {
                //             return availableCodeList(snapshot.data);
                //           }
                //
                //     }),
                //for asset


                // for document

                Container(

                  // height: 50,
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
                  child: Center(

                    child: Text(
                      isCheckedBulk==true
                          ?

                      '${scannedSerialCodes}'
                          : _currentScannedCode,
                      style: TextStyle(fontSize: 14,color: Colors.black),
                    ),
                  ),
                ),

                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: ElevatedButton(
                        onPressed: () {
                          isCheckedIndividual?EnrollAssetsSecondPageIndividual():
                          EnrollAssetsSecondPageBulk();
                          // EnrollAssetsSecondPage();
                          // ZebraRfid.connect();
                          // log(_selectedDepreciation.toString());
                          // EnrollAssetsSecondPage();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SerialInfoPage()));
                            log(                          _packCodesListPackInfo.toString());
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
  availableCodeList( data) {
    return data != null
        ? ListView.builder(
      // controller: controller,
        shrinkWrap: true,
        itemCount:data['results'].length ,

        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          availableCodes.contains(data['results'][index]['code'])?"":availableCodes.add(data['results'][index]['code']);

          return  Container(child: Text(''),);


          //   Card(
          //   color: Color(0xffeff3ff),
          //   elevation: kCardElevation,
          //   // shape: kCardRoundedShape,
          //   child: Padding(
          //     padding: kMarginPaddSmall,
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               flex: 2,
          //               child: Text(data['results'][index]['code']
          //                   ,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
          //             ),
          //           ],
          //         ),
          //         kHeightSmall,
          //       ],
          //     ),
          //   ),
          // );








          //   Container(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Text(data['results'][index]['code']
          //         ,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
          //   ),
          // );
        })
        : Center(
      child: Text(
        "jh",
        style: kTextStyleBlack,
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

            if (isCheckedBulk==true) {
              scannedSerialCodes.add(_currentScannedCode);
            } else {
              log('packo' + scannedSerialCodes.toString());
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

  Future EnrollAssetsSecondPageIndividual() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    log(_selectedCodes.toString());
    final responseBody = {
      "asset_details": [
        {
          "packing_type_detail_code": _currentScannedCode
        }
      ],
      // "registration_no": "string",
      "scrapped": true,
      "available": true,
      "qty": widget.qty,
      // "adjusted_book_value": widget.book,
      "net_value": widget.net,
      "remarks": " ",
      "salvage_value": widget.salvage,
      // "depreciation_rate": widget.depRate,
      "amc_rate": widget.amc,
      "depreciation_method":widget.depMethod,
      "end_of_life_in_years": widget.eol,
      "warranty_duration": widget.warrnety,
      "maintenance_duration": widget.maintain,
      "category": widget.categoryId,
      "sub_category": widget.subCategoryId,
      "item": widget.itemId
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.enrollAssetsPost}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    // log(response.body);
    if (response.statusCode == 200||response.statusCode==201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Asset Enrolled Successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTabPage()));
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }
  Future EnrollAssetsSecondPageBulk() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    List codesPost = [];
    for (int i = 0;i<scannedSerialCodes.length;i++){
      codesPost.add(
          {
            "packing_type_detail_code": scannedSerialCodes[i]
          }
      );
    }

    final responseBody = {
      "asset_details": codesPost,
      // "registration_no": "string",
      "scrapped": true,
      "available": true,
      "qty": widget.qty,
      // "adjusted_book_value": widget.book,
      "net_value": widget.net,
      "remarks": " ",
      "salvage_value": widget.salvage,
      // "depreciation_rate": widget.depRate,
      "amc_rate": widget.amc,
      "depreciation_method":widget.depMethod,
      "end_of_life_in_years": widget.eol,
      "warranty_duration": widget.warrnety,
      "maintenance_duration": widget.maintain,
      "category": widget.categoryId,
      "sub_category": widget.subCategoryId,
      "item": widget.itemId
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.enrollAssetsPost}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Asset Enrolled Successfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTabPage()));
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

}

