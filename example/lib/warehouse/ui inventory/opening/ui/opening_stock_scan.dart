
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zebra_datawedge/zebra_datawedge.dart';

import '../../../../Constants/buttons_const.dart';
import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';
import '../model/opening_stock_details_model.dart';
import 'opening_list.dart';
import 'opening_stock_details.dart';
import 'package:http/http.dart' as http;
class OpeningStockScan extends StatefulWidget {

  String purchaseDetail='';

  List locationSavedCodes = [];
  List<PuPackTypeCodes> openStockResult = [];
  OpeningStockScan(this.purchaseDetail,this.openStockResult, this.locationSavedCodes);


  @override
  State<OpeningStockScan> createState() => _OpeningStockScanState();
}

class _OpeningStockScanState extends State<OpeningStockScan> {

  int totalReceivedQty = 0;
  String _scanLocationNo = '';
  String _scanPackNo = '';
  String _currentScannedCode = '';
  List _scannedPackCode=[];

  int scannedItem = 0;
  String finalUrl = '';
   int _openStockOrderID;


List gotPackCodes=[];
  List packCodes = [];


  @override
  void initState() {
    initUi();
    _openingInitDataWedgeListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popAndLoadPage(_openStockOrderID),
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan Item Location'),
        backgroundColor: Color(0xff2c51a4),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(width:20,),
                          Container(
                            height: 30,
                            width: 100,
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

                            child: Center(child: Text("${totalReceivedQty}",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      ),
                      SizedBox(width:20,),
                      // Text(
                      //   'Item Name',
                      //   style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(width: 8,),
                      // Flexible(
                      //   child: Text(
                      //     widget._purchaseOrderDetails[widget.index].itemName,
                      //     overflow: TextOverflow.clip,
                      //     style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text("Scanned:",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(width:20,),
                              Container(
                                height: 30,
                                width: 80,
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

                                child: Center(child: Text("${_scannedPackCode.length}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontWeight: FontWeight.bold),)),
                              ),
                            ],
                          ),
                          // Text(
                          //   'Item Name',
                          //   style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(width: 8,),
                          // Flexible(
                          //   child: Text(
                          //     widget._purchaseOrderDetails[widget.index].itemName,
                          //     overflow: TextOverflow.clip,
                          //     style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // Text('Total : ${totalReceivedQty}', style:  kHintTextStyle,),

                  // Text('Scanned : $scannedItem', style: kHintTextStyle),
                ],
              ),
              kHeightMedium,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Pack Codes', style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),),
              ),
              Card(
                color: Color(0xffeff3ff),
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: printPackCodes(),
              ),
              kHeightMedium,
              Column(
                children: [
                  _displayLocationSerialNo(),
                  _displayItemsSerialNo(),
                ],
              ),
              kHeightMedium,
              Container(
                width: 120,
                padding:  const EdgeInsets.all(16.0),
                child: RoundedButtons(
                  buttonText: 'Drop',
                  onTap: () =>
                      // dropCurrentItem(_scanLocationNo, _scanPackNo)
                  _scanLocationNo.isNotEmpty && _scannedPackCode.length==packCodes.length
                      ? dropCurrentItem()
                      : displayToast(msg:  'Please Scan Codes and Try Again'),
                  color: Color(0xff2c51a4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  /*Network Request*/
  Future dropCurrentItem()  async {



    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String finalUrl = prefs.getString(StringConst.subDomain).toString();


    List finalPackCode=[];
    for(int i=0;i<_scannedPackCode.length;i++){
      finalPackCode.add({
        "pack_type_code": _scannedPackCode[i],
        "purchase_detail_id": widget.purchaseDetail

      });
    }

    int  _openStockID = int.parse(prefs.getString(StringConst.openingStockOrderID).toString());
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.urlOpeningStockApp}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        },
        body: jsonEncode({
          "pack_type_codes": finalPackCode,
          "location_code": _scanLocationNo
        }));
    // Response response = await NetworkHelper(
    //     '$finalUrl${StringConst.urlOpeningStockApp}location-purchase-details')
    //     .dropReceivedOrders(locationCode, packCode);
log({
  "pack_type_codes": finalPackCode,
  "location_code": _scanLocationNo
}.toString());

    if (response.statusCode == 401) {}
    else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          scannedItem++;
          _scanLocationNo = '';
          _scanPackNo = '';
          // packCodes?.remove(packCode);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OpeningStockList()));
        });
        displayToastSuccess(msg: 'Item Dropped Successfully');


        if(scannedItem==totalReceivedQty){
          popAndLoadPage(_openStockID);
        }
      } else {
        displayToast(msg: StringConst.somethingWrongMsg);
      }
    }

  }


  /*UI Part*/
  Future<void> _openingInitDataWedgeListener() async {
    ZebraDataWedge.listenForDataWedgeEvent((response) {
      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);

          if (jsonResponse != null) {
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();
            log(_currentScannedCode.toString());


            if(_scanLocationNo.isEmpty) {
                widget.locationSavedCodes.contains(_currentScannedCode)
                    ? _scanLocationNo = _currentScannedCode
                    : Container() ;
            }
            else if(_scanLocationNo.isNotEmpty){
              if(!_scannedPackCode.contains(_currentScannedCode)&&packCodes.contains(_currentScannedCode)){
                _scannedPackCode.add(_currentScannedCode);
              }

            }
            /* else{
            displayToast(msg: 'Please Save, and Try Again');
          }*/
          } else {
            displayToast(msg: 'Something went wrong, Please Try Again');
            // _source = "An error Occured";
          }

        } catch (e) {
          displayToast(msg: 'Something went wrong, Please Scan Again');
        }

        setState(() {});

      }
      else{
        //
      }
    });
  }

  popAndLoadPage(dropOrderID) {
    Navigator.pop(context);
    Navigator.pop(context);
    goToPage(context, OpeningStockDetails(dropOrderID));
  }

  Future<void> initUi() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    finalUrl = prefs.getString(StringConst.subDomain).toString();

    String _oSOrderID = prefs.getString(StringConst.openingStockOrderID).toString();
    _openStockOrderID = int.parse(_oSOrderID);

    /*Total Received Qty*/
    totalReceivedQty  = int.parse(widget.openStockResult.length.toString());

    savePackCodeList(widget.openStockResult);

    // print("REceived Location CodeS: ${widget.locationSavedCodes}");
/*

    if(_scanLocationNo.isEmpty){
      _currentScannedCode = 'W1-RM01-RK01-A01-B01';
      widget.locationSavedCodes.contains(_currentScannedCode)
          ? _scanLocationNo = "This is Working"
          : displayToast(msg : "Invalid Pack Location");
    }
*/

  }

  _displayLocationSerialNo() {
    return Card(
      color: Color(0xffeff3ff),
      elevation: kCardElevation,
      shape: kCardRoundedShape,
      child: Padding(
        padding: kMarginPaddSmall,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Location No :',
                    style: kTextStyleSmall.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    _scanLocationNo,
                    style: kTextStyleSmall.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
            kHeightSmall,
          ],
        ),
      ),
    );
  }

  _displayItemsSerialNo() {
    return Card(

      color: Color(0xffeff3ff),
      elevation: kCardElevation,
      shape: kCardRoundedShape,
      child: Padding(
        padding: kMarginPaddSmall,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // height: 100,
                  flex: 2,
                  child: Text(
                    'Pack Code: ',
                    style: kTextStyleSmall.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        _scannedPackCode.toString(),
                        style: kTextStyleSmall.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            kHeightSmall,
          ],
        ),
      ),
    );
  }

  printPackCodes() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: showMorePickUpLocations(packCodes?.join("\n").toString() ?? ''),
    );
  }


  void savePackCodeList(List<PuPackTypeCodes> poPackTypeCodes) {
    for(int i = 0 ; i < poPackTypeCodes.length; i++){
      packCodes?.add(poPackTypeCodes[i].code);
    }

    setState(() {
    });
  }


}

