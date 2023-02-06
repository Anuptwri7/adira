import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Assets/availableCode/model.dart';
import 'package:classic_simra/Assets/availableCode/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';


import 'package:http/http.dart' as http;



class EnrollAssetNextPage extends StatefulWidget {
  String itemId;
   EnrollAssetNextPage({Key key,this.itemId}) : super(key: key);

  @override
  State<EnrollAssetNextPage> createState() => _EnrollAssetNextPageState();
}

class _EnrollAssetNextPageState extends State<EnrollAssetNextPage> {

  TextEditingController remakrsController = TextEditingController();
Codes codes =Codes();
  // String dropdownValueCategory = "Select Category";
  String dropdownvalueUser = 'Select User';

  int _selectedCategory;
  int _selecteduser;

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
      if(rfidDocument.contains(rfidDatas[item.tagID].tagID)){}
      else if(rfidDatas[item.tagID].peakRSSI>-40) {rfidDocument.add(item.tagID.toString());
      document = item.tagID.toString();
      }
    }
    setState(() {
      connectionStatus.name;
    });
  }
  List rfidDocument = [];
  String document = '';

  Validation(){
    if(dropdownvalueUser=="Select User"){
      Fluttertoast.showToast(msg: "Select User",backgroundColor: Colors.red);
    }
    else if (rfidDocument.isEmpty){
      Fluttertoast.showToast(msg: "Please Scan the Document ",backgroundColor: Colors.red);
    }

    else{
      // SaveDocument(context);

    }
  }

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
      return Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Assign"),
      ),
      backgroundColor: Color(0xfff4f7ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Container(
            margin: EdgeInsets.all(20),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Scanned Document:"),
                    ),
                    Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width/4,
                        margin: const EdgeInsets.only(top:0,left: 0,right: 10),
                        //margin: EdgeInsets.only(left:10,right:60),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(4, 4),
                              )
                            ]),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Center(child: Text("${rfidDocument.length}"))
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top:10,left: 10,right: 10),

                  //margin: EdgeInsets.only(left:10,right:60),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        )
                      ]),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FutureBuilder(
                    future: codes.fetchAvailableCodes(widget.itemId.toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasError){
                        return Text("Loading");
                      }
                      if (snapshot.hasData) {
                        try {
                          final List<ResultCodes> snapshotData = snapshot.data;

                          return DropdownButton<ResultCodes>(
                            hint: Text("${dropdownvalueUser.isEmpty?"Select User":dropdownvalueUser}"),
                            // value: snapshotData.first,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            items: snapshotData
                                .map<DropdownMenuItem<ResultCodes>>((ResultCodes items) {
                              return DropdownMenuItem<ResultCodes>(
                                value: items,
                                child: Text(items.code.toString()),
                              );
                            }).toList(),
                            onChanged: (ResultCodes newValue) {
                              setState(
                                    () {
                                  dropdownvalueUser = newValue.code.toString();
                                  _selecteduser = newValue.id;
                                  log("--------------------------------"+_selecteduser.toString());
                                },
                              );
                            },
                          );
                        } catch (e) {
                          throw Exception(e);
                        }
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top:10,left: 10,right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          blurRadius:6,
                          offset: Offset(4, 4),
                        )
                      ]),

                  child:TextField(
                    controller: remakrsController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter the Remarks',
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),

                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top:10,left: 10,right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          blurRadius:6,
                          offset: Offset(4, 4),
                        )
                      ]),

                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Center(child: Text(rfidDocument.isNotEmpty?rfidDocument.toString():"Scan the Document",style: TextStyle(fontSize: 14),)));
                      },
                      itemCount:1,
                    ),
                  ),
                ),


                Container(
                  padding: const EdgeInsets.only(left: 120, right: 120),
                  child: ElevatedButton(
                      onPressed: () {
                        Validation();
                        // SaveDocument(context,document,titletextEditingController.text.toString(),descriptiontextEditingController.text.toString(),_selectedCategory,_selectedLocation);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DocumentMaster()));
                        // SaveDocumentMultipart();
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

              ],
            )
        ),


      ),
    );
  }
  // Future SaveDocument(BuildContext context) async {
  //   final SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //   // String tagKey ;
  //   var tagKey = [];
  //   log(rfidDocument.toString());
  //
  //   for(int i =0;i<rfidDocument.length;i++){
  //     tagKey.add(
  //         {
  //           "tagKey":rfidDocument[i].toString()
  //         }
  //     );
  //     log(tagKey.toString());
  //   }
  //   final responseBody = {
  //     "tags": tagKey,
  //     "assignedTo":_selecteduser,
  //     "remarks": remakrsController.text.toString()
  //   };
  //   // log("=================="+responseBody.toString());
  //   log(rfidDocument.length.toString());
  //   log("kjhjhgjgjgjh"+tagKey.toString());
  //   log(responseBody.toString());
  //   final response = await http.post(
  //       Uri.parse(ApiConstant.baseUrl + ApiConstant.assign),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  //       },
  //       body: json.encode(responseBody));
  //   log(response.statusCode.toString());
  //   if (response.statusCode == 201) {
  //     Fluttertoast.showToast(msg: "Done Successfully!",backgroundColor: Colors.red);
  //     log(responseBody.toString());
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabPage()));
  //
  //   } else if (response.statusCode == 400){
  //     Fluttertoast.showToast(msg: "Asset already Assigned!",backgroundColor: Colors.indigoAccent);
  //   }
  //   else if (response.statusCode == 404) {
  //     Fluttertoast.showToast(msg: json.decode(response.body)["message"],backgroundColor: Colors.indigoAccent);
  //   }
  //
  //   return response;
  // }
}



