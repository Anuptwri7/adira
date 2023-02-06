import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:classic_simra/warehouse/provider/model/locationList.dart';
import 'package:classic_simra/warehouse/ui/pickUp/services/assetSummaryServices.dart';
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
import 'model/summaryModel.dart';




class AssetSummary extends StatefulWidget {
  String id;
   AssetSummary({Key key,this.id}) : super(key: key);

  @override
  State<AssetSummary> createState() => _AssetSummaryState();
}

class _AssetSummaryState extends State<AssetSummary> {



  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController = TextEditingController();
  TextEditingController costtextEditingController = TextEditingController();
  TextEditingController eoltextEditingController = TextEditingController();
  TextEditingController netvaluetextEditingController = TextEditingController();
  TextEditingController amctextEditingController = TextEditingController();
  TextEditingController warrentytextEditingController = TextEditingController();
  TextEditingController salvagetextEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController depRatetextEditingController = TextEditingController();
  TextEditingController bookValueRatetextEditingController = TextEditingController();
  TextEditingController maintaintextEditingController = TextEditingController();
  TextEditingController vehicleNumbertextEditingController = TextEditingController();
  TextEditingController phoneNumbertextEditingController = TextEditingController();
  TextEditingController ownertextEditingController = TextEditingController();
  TextEditingController ownerIdtextEditingController = TextEditingController();
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController remarkstextEditingController = TextEditingController();

  String dropdownValueCategory = "Select Category";

  String subCategorydropdownValue = "Select Sub Category";
  String ownerNamedropdownValue = "Select the Owner Name";
  String dropdownvalueLocation = 'Select Location';
  String _selectedSupplierName;
  String _selectedDepreciation;
  String _selectedType;
  int _selectedCategory;
  int _selectedSubCategory;
  int _selectedOwner;
  int _selectedLocation;
  bool isCheckedAsset=false;
  bool isCheckedDocument = false;
  bool isCheckedVehicle = false;
  bool isAsset = false;
  bool isDep1=false;
  bool isDep2=false;
  ByteData byteData;
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
    ZebraRfid.connect();
    // log(androidBatteryInfo.pluggedStatus);

    // final categorydata = Provider.of
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
        if(availableRfidTagKeys.contains(item.tagID)){
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
  List availableRfidTagKeys = [];
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
      appBar: AppBar(
        title: Text("Pickup Assets"),
      ),
      backgroundColor: Color(0xfff4f7ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,

            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xfff4f7ff),
                  spreadRadius: 5,
                  blurRadius: 17,
                  offset: Offset(0, 3),
                )
              ],
              // borderRadius: BorderRadius.all(
              //   Radius.circular(10.0),
              // ),
              color:Color(0xfff4f7ff),
            ),
            child: Column(
              children: [
                Container(
                  child: Text("Assigned Rfid Tag key",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                FutureBuilder(
                    future: fetchAssetSummary(widget.id),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            log("me"+snapshot.data['results'][0]['asset_dispatch_info_count'].toString());
                            return _pickOrderCards(snapshot.data);
                          }
                      }
                    }),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: dropDownsDecoration,
                  child: Consumer<LocationList>(
                      builder: ((context, item, child) {
                        return DropdownButton<ResultsLocation>(
                          elevation: 24,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${dropdownvalueLocation.isEmpty
                                ? "Select Location"
                                : dropdownvalueLocation}"),
                          ),
                          // value: snapshotData.first,
                          iconSize: 24.0,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: item.allLocation
                              .map<DropdownMenuItem<ResultsLocation>>((ResultsLocation items) {
                            return DropdownMenuItem<ResultsLocation>(
                              value: items,
                              child: Text(items.code.toString()),
                            );
                          }).toList(),
                          onChanged: (ResultsLocation newValue) {
                            setState(
                                  () {

                                dropdownvalueLocation = newValue.code;

                                log("--------------------------------" +
                                    dropdownvalueLocation.toString());

                              },
                            );
                          },
                        );

                      })),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  child: Text("Scanned Rfid Tag key",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                Container(
                    child:
                    Text(
                        "${rfidDocument}" ,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)
                    )
                ),


                ElevatedButton(
                    onPressed: (){
                      dispatchPickup();
                    },
                    child: Text("Pickup"))

              ],
            )

        ),


      ),
    );

  }
  _pickOrderCards( data) {
    return data != null
        ? ListView.builder(
        // controller: controller,
        shrinkWrap: true,
        itemCount:data['results'][0]['asset_dispatch_info_count'] ,

        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          availableRfidTagKeys.add(data['results'][0]['asset_dispatch_info'][index]['rfid_tag']['code'].toString());
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  child:
                  data['results'][0]['asset_dispatch_info'][index]['rfid_tag']=='null'? Text("null"):Text(data['results'][0]['asset_dispatch_info'][index]['rfid_tag']['code'].toString()
                      ,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),

                ),


              ],

            ),

          );


        })
        : Center(
      child: Text(
        "jh",
        style: kTextStyleBlack,
      ),
    );
  }



  Future dispatchPickup() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();



    final responseBody = {
      "rfid_tag_code": rfidDocument[0],
      "location_code": dropdownvalueLocation
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
    log(response.body);

    if (response.statusCode == 200||response.statusCode==201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Asset Enrolled Successfully");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EnrolledAssetMaster()));
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

}

