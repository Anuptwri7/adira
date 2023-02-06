import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Assets/assetSummary/model.dart';
import 'package:classic_simra/Assets/assetSummary/services.dart';
import 'package:classic_simra/Assets/assteMaster/model.dart';
import 'package:classic_simra/Assets/assteMaster/services.dart';
import 'package:classic_simra/Assets/bindRfidWithSerialCode.dart';
import 'package:classic_simra/warehouse/ui/return/services/tagkeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';

import '../../warehouse/ui/drop/scanToDrop.dart';
import '../model/serialCodes.dart';


class AssetSummaryPage extends StatefulWidget {
  int id;
  List SerialNo = [];
   AssetSummaryPage({Key key,this.id,this.SerialNo}) : super(key: key);

  @override
  State<AssetSummaryPage> createState() =>
      _AssetSummaryPageState();
}

class _AssetSummaryPageState extends State<AssetSummaryPage> {
  // String get $i => null;
  ListingServices listingservices = ListingServices();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await listingservices.fetchOrderListFromUrl();
    } else {
      return await listingservices.fetchOrderListFromUrl();
    }
  }
  @override

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
  String dropdownValueCode= "Select Serial Codes";
  List _selectedcodesList = [];
  int _selectedCodes;

  String _currentScannedCode = '';

  bool isCheckedAsset=true;
  bool isAsset = false;
  bool isDep1=false;
  bool isDep2=false;

  bool isCheckedBulk= false;
  bool isCheckedIndividual= false;
  List _selectedCodeId = [];
  Map dict = {};

  void initState() {
    log("id"+widget.id.toString());
   fetchTagKeys(widget.id);

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

    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(

        backgroundColor: const Color(0xffeff3ff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [

                const SizedBox(
                  height: 20,
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                          top: 20, right: 0, left: 5, bottom: 50),
                      child: Column(
                        children: [
                          FutureBuilder(


                            // future: customerServices
                            //     .fetchOrderListFromUrl(_searchItem),
                            future: fetchcodesumaary(widget.id),

                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {

                                try {


                                  final snapshotData = json.decode(snapshot.data);
                                  SerialCode assetsummaryrfid =
                                  SerialCode.fromJson(snapshotData);





                                  // log(customerOrderList.count.toString());

                                  return   DataTable(

                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      columnSpacing: 0,
                                      horizontalMargin: 0,

                                      // columnSpacing: 10,

                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .3,
                                            child: const Text(" SERIAL NO.",
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
                                              'RFID',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: SizedBox(
                                        //     width: width * .2,
                                        //     child: const Text(
                                        //       'Action',
                                        //       style: TextStyle(
                                        //           fontSize: 14,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ),
                                        // ),

                                      ],
                                      rows: List.generate(
                                          assetsummaryrfid.assetDetails.length,
                                              (index) => DataRow(

                                            // selected: true,
                                            cells: [
                                              DataCell(
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Text(
                                                    assetsummaryrfid.assetDetails[index].serialNo,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                  GestureDetector(
                                                    onTap: (){
                                                      assetsummaryrfid.assetDetails[index].rfidTag==null?
                                                      Navigator.push(
                                                          context, MaterialPageRoute(builder: (context)=>RfidBindWithSerialCode(
                                                          serial: assetsummaryrfid.assetDetails[index].serialNo),
                                                      )):Fluttertoast.showToast(msg: "Already tag Assigned!");
                                                    },
                                                    child: Text(
                                                      assetsummaryrfid.assetDetails[index].rfidTag==null?
                                                      "Click to scan Rfid Tag":assetsummaryrfid.assetDetails[index].rfidTag.code,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
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
                                          )));
                                } catch (e) {
                                  throw Exception(e);
                                }
                              } else {
                                return Text("Loading") ;
                              }
                            },
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
                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: (){

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                      }, child: Text("Yes"),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No"))
                  ],
                ),
              )

            ],
          ),
        )),
  );
  Future OpenDialogForRfid(BuildContext context) => showDialog(
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
                child: ( Text(
                  document==''?"Scan the Rfid":'$document',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: (){

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                      }, child: Text("Yes"),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No"))
                  ],
                ),
              )

            ],
          ),
        )),
  );

}
