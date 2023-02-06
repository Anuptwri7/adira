
import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/Assets/availableCode/model.dart';
import 'package:classic_simra/warehouse/ui%20inventory/depratment%20transfer/model/getCodesLocation.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/pickup_order_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zebra_datawedge/zebra_datawedge.dart';

import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';
import 'detail.dart';

String _scanLocationNo = '';
class ScanToPickupReturned extends StatefulWidget {
int idForPost;
  int masterId;
  List pakcCodes=[];
  Map packCodeId={};
  // List<CustomerPackingType> customerPackingType;

  ScanToPickupReturned( this.idForPost,this.masterId,this.pakcCodes,this.packCodeId);

  @override
  State<ScanToPickupReturned> createState() => _PickUpScanLocationState();
}

class _PickUpScanLocationState extends State<ScanToPickupReturned> {

  final List<String> _scanSerialNo = [];
  String _currentScannedCode = '';
  int scannedItem = 0;
  double totalReceivedQty = 0.0;

  String finalUrl = '';
  int pkOrderID;

  List packCodesID =  [];
  List<String> _packCodesList = [];
  List locationCodesList = [];
  List<String> previousSerialCodes = [];
  List scannedPackCodes= [];
  List values= [];

  // ProgressDialog pd;

  @override
  void initState() {
    log(widget.packCodeId.toString());
    values.add(widget.packCodeId.values);
    log(widget.packCodeId.values.length.toString());
    // pickUpOrdersDetails(widget.pickupDetailsID);
    initUi();
    // savePackCodeList(widget.customerPackingType);
    _pickupInitDataWedgeListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popAndLoadPage(pkOrderID),
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan Item Location'),
          backgroundColor: Color(0xff2c51a4),),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total : ${totalReceivedQty}', style: kHintTextStyle,),
                  Text('Scanned : ${_scanSerialNo.length}', style: kHintTextStyle),
                ],
              ),
            ),
            // kHeightMedium,
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Pickup Location', style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),),
            // ),
            // Card(
            //   elevation: 8.0,
            //   clipBehavior: Clip.antiAlias,
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            //   child: printLocationCodes(),
            // ),
            kHeightMedium,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('Serial Codes ', style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),),
                  Text('Pack Codes', style: kTextStyleBlack.copyWith(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Card(
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child : printSerialNos(),
                    ),
                    Expanded(
                      flex: 2,
                      child: showPackCodes(),
                    ),
                  ],
                )
            ),

            kHeightMedium,
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  // _displayLocationSerialNo(),
                  _displayItemsSerialNo(),
                ],
              ),
            ),
            kHeightMedium,
            Container(
              width: 120,
              padding:  const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child:Text('Pickup') ,
                onPressed: () =>
                    pickup()

                // _scanSerialNo.length == previousSerialCodes.length
                //     ?  postPickUpOrder(packCodesID, widget.pickupDetailsID)
                //     : displayToast(msg: 'Please Complete Your Scan First'),

              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Network Part*/

  // Future<void> postPickUpOrder(_pickUpOrderList, _pickUpDetailsItemID) async {
  //   // pd.show(max: 100, msg: 'Updating Pickup Item...');
  //
  //   try {
  //     Response response = await NetworkHelper(
  //         '$finalUrl${StringConst.urlCustomerOrderApp}pickup-customer-order')
  //         .pickUpOrders(_pickUpDetailsItemID, _pickUpOrderList);
  //
  //     // pd.close();
  //     if (response.statusCode == 401) {
  //       // replacePage(LoginScreen(), context);
  //     } else {
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         popAndLoadPage(pkOrderID);
  //         displayToastSuccess(msg: 'Scan Successfull');
  //       } else {
  //         displayToast(msg: StringConst.somethingWrongMsg);
  //       }
  //     }
  //   }
  //   catch(e){
  //     displayToast(msg: e.toString());
  //     // pd.close();
  //
  //   }
  //
  // }
  Future<List<Results>> pickUpOrdersDetails(int receivedOrderID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(receivedOrderID.toString());
    // prefs.setString(StringConst.pickUpOrderID, widget.orderID.toString());
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.getCodes+receivedOrderID.toString()}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });
    // response = await NetworkHelper(
    //         '$finalUrl${StringConst.baseUrl+StringConst.urlCustomerOrderApp}order-detail?&limit=0&order=$receivedOrderID')
    //     .getOrdersWithToken();

    if (response.statusCode == 401) {
      // replacePage(LoginScreen(), context);
    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
       setState(() {
         totalReceivedQty=DetailCodeLocation.fromJson(jsonDecode(response.body.toString())).results[0].qty;
         for(int i=0;i<jsonDecode(response.body)['results'].length;i++){
           _packCodesList.add(DetailCodeLocation.fromJson(jsonDecode(response.body.toString())).results[i].code);
           locationCodesList.add(DetailCodeLocation.fromJson(jsonDecode(response.body.toString())).results[i].locationCode);
         }
       });
        // log("qty"+jsonDecode(response.body)['results']['qty']);
        log(response.body);
        return DetailCodeLocation.fromJson(jsonDecode(response.body.toString())).results;
      } else {
        displayToast(msg: StringConst.somethingWrongMsg);
      }
    }
    return null;
  }
  /*UI Part*/
  // _displayLocationSerialNo() {
  //   return Card(
  //     elevation: kCardElevation,
  //     shape: kCardRoundedShape,
  //     child: Padding(
  //       padding: kMarginPaddSmall,
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 flex: 2,
  //                 child: Text(
  //                   'Location No :',
  //                   style: kTextStyleSmall.copyWith(
  //                       fontWeight: FontWeight.bold, color: Colors.black),
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 4,
  //                 child: Text(
  //                   _scanLocationNo,
  //                   style: kTextStyleSmall.copyWith(
  //                       fontWeight: FontWeight.bold, color: Colors.black),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           kHeightSmall,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _displayItemsSerialNo() {
    return Card(
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
                    '${StringConst.packSerialNo} / Pack No :',
                    style: kTextStyleSmall.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _scanSerialNo.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        _scanSerialNo[index].isNotEmpty ? _scanSerialNo[index] : '',
                        style: kTextStyleSmall.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      );
                    },
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

  popAndLoadPage(pkOrderID) {
    Navigator.pop(context);
    Navigator.pop(context);
    goToPage(context, PickUpOrderDetails(pkOrderID));

    // goToPage(context, PickUpDetails());
  }

  Future<void> _pickupInitDataWedgeListener() async {

    ZebraDataWedge.listenForDataWedgeEvent((response) {

      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);

          if (jsonResponse != null) {
            _currentScannedCode = '';
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();
            print("Current Location : $_currentScannedCode");
            print("Location Codes: $locationCodesList");
            print("Location Codes: ${widget.pakcCodes}");

            if(!_scanSerialNo.contains(widget.pakcCodes)){
              setState(() {
                _scanSerialNo.add(_currentScannedCode);
              });
            }

            widget.packCodeId.forEach(
                  (key, value) {
                if (key == _currentScannedCode) {
                  packCodesID.add(value);
                }
              },
            );

            // if(_scanLocationNo.isEmpty) {
            //   locationCodesList.contains(_currentScannedCode)
            //       ? setState(() {_scanLocationNo = _currentScannedCode;})
            //       : displayToast(msg: 'Invalid Location, Scan Again');
            // }

            // else if(_scanSerialNo.isEmpty || _scanSerialNo.length<previousSerialCodes.length) {
            //   if(previousSerialCodes.contains(_currentScannedCode)) {
            //     setState(() {
            //       _scanSerialNo.add(_currentScannedCode);
            //       previousSerialCodes.remove(_currentScannedCode);
            //     });
            //   }
            //   setState(() {
            //
            //   });
            //   // else if(widget.customerPackingType[widget.index].code == _currentScannedCode
            //   //     && _scanSerialNo.length < previousSerialCodes.length){
            //   //   setState(() {
            //   //     _scanSerialNo.addAll(previousSerialCodes);
            //   //     previousSerialCodes.remove(_currentScannedCode);
            //   //   });
            //   // }
            //   /*  else{
            //     displayToast(msg: ' Invalid Serial or Pack No, Scan Again');
            //   }*/
            // }
          }
          else{
            // displayToast(msg: 'Something went wrong, Please Scan Again');
          }
        } catch (e) {
          // displayToast(msg: 'Something went wrong, Please Scan Again');
        }
      }


      else{
        // print('')
      }
    });

  }
  Future pickup() async {
    log(widget.packCodeId.toString());
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    List packTypeDetail=[];
    List id = [];
    log(id.toString());
    id.add(widget.packCodeId.values);

log("jlnljk"+packCodesID.toString());

    for(int i=0;i<packCodesID.length;i++){
      log("jadbskjashdk"+id.toString());
      packTypeDetail.add(

            {
              "packing_type_code": packCodesID[i],
              "sale_packing_type_detail_code": [

              ],
              "qty": 5
            }

      );
    }


    final responseBody = {
      "department_transfer_detail": widget.idForPost,
      "department_transfer_packing_types": packTypeDetail
    };
    log(responseBody.toString());
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.postPickupRequestedDepartment}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(
            {
              "department_transfer_detail": widget.idForPost,
              "department_transfer_packing_types": packTypeDetail
            }
        ));
    log(widget.idForPost.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200||response.statusCode==201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      Fluttertoast.showToast(msg: "Asset Enrolled Successfully");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PickUpRequestedDetails(widget.masterId)));
            DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

  Future<void> initUi() async {

    // pd = initProgressDialog(context);
    // pickUpOrdersDetails(widget.pickupDetailsID);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    finalUrl = prefs.getString(StringConst.subDomain).toString();
    String pickOrderID = prefs.getString(StringConst.pickUpOrderID).toString();
    pkOrderID = int.parse(pickOrderID);
  }

  // void savePackCodeList(List<Results> customerPackingType) {
  //
  //   totalReceivedQty = customerPackingType.length;
  //   locationCodesList.add(customerPackingType[widget.index].locationCode);
  //
  //   for(int i = 0; i < customerPackingType.length; i++){
  //     for(int j = 0; j < customerPackingType[i].salePackingTypeDetailCode.length; j++){
  //
  //       String serialNos = customerPackingType[i].salePackingTypeDetailCode[j].code;
  //       int serialID = customerPackingType[i].salePackingTypeDetailCode[j].id;
  //
  //       _packCodesList.add(customerPackingType[i].code);
  //       packCodesID.add(serialID);
  //       previousSerialCodes.add(serialNos);
  //
  //     }
  //   }
  //
  //   print("Serial Codes: $packCodesID");
  //   print("Previous Serial Code: $previousSerialCodes");
  //
  // }



  printSerialNos(){
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: smallShowMorePickUpLocations("${widget.pakcCodes.join("\n").toString()} ")

    );


  }

  showPackCodes() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: smallShowMorePickUpLocations("${_packCodesList.join("\n").toString()} ")

    );

  }

}
