import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Constants/stringConst.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/pickup_order_details.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/test_pickup_scan_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/styleConst.dart';
import '../../network/network_helper.dart';
import '../model/pickup_details.dart';


class PickUpOrderSaveLocation extends StatefulWidget {

  int pickupDetailsID;
  List<CustomerPackingType> customerPackingType;
  final index;

  PickUpOrderSaveLocation(this.customerPackingType, this.pickupDetailsID,
      this.index);

  @override
  State<PickUpOrderSaveLocation> createState() =>
      _PickUpOrderSaveLocationState();
}

class _PickUpOrderSaveLocationState extends State<PickUpOrderSaveLocation> {

  List<int> _packIDList = [];

  String finalUrl = '';
   int pkOrderID;
   SharedPreferences prefs;
  List<String> _scannedIndex = [];

  @override
  void initState() {

      initUi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Pickup Codes'),
        backgroundColor: Color(0xff2c51a4),
        actions: [
          InkWell(
            onTap: () => _completedButton(),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Text('Save', style: kTextStyleWhite,),
            ),
          )
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.customerPackingType.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: kMarginPaddSmall,
                color: Colors.white,
                elevation: kCardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  padding: kMarginPaddSmall,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text("Location Code :",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
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
                            child: Center(child: Text(
                              "${widget.customerPackingType[index]
                                  .locationCode}",
                              style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      ),
                      // poInRowDesign('Location Code :', widget.customerPackingType[index].locationCode),
                      kHeightMedium,
                      Row(
                        children: [
                          Container(
                            child: Text("Pickup Location:",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ),

                          Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
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
                            child: Center(child: Text(
                              "${widget.customerPackingType[index].code}",
                              style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      ),
                      // poInRowDesign('Pickup Locations :', widget.customerPackingType[index].code),
                      kHeightMedium,
                      Row(
                        children: [
                          Container(
                            child: Text("Serial No. Count",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
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
                            child: Center(child: Text(
                              "${widget.customerPackingType[index]
                                  .salePackingTypeDetailCode.length
                                  .toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      ),

                      // poInRowDesign('Serial No. Count:', widget.customerPackingType[index].salePackingTypeDetailCode.length.toString()),
                      kHeightMedium,
                      pickedOrNotPicked(widget.customerPackingType, index),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  pickedOrNotPicked(List<CustomerPackingType> customerPackingType, int index) {
    return
      _scannedIndex != null && _scannedIndex.contains(index.toString())
          ? ElevatedButton(
          child:Text ('Scanned'), onPressed: () => {})
          : ElevatedButton(child:Text( 'Scan'),
          onPressed: () => goToPage(context, TestPickupScanLocation(
              customerPackingType, index, widget.index,
              widget.pickupDetailsID)));
  }


  _completedButton() {
    showDialog(context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Do You Finished Scanning?', style: kTextStyleBlack,),
            actions: [
              TextButton(
                child: const Text('Yes', style: kTextStyleBlack,),
                onPressed: () {
                  Navigator.of(context).pop();
                  _savePickUpOrderTask();
                },
              ),
              noAlertTextButton()
            ],
          );
        });
  }

  noAlertTextButton() {
    return TextButton(
      child: const Text('No', style: kTextStyleBlack),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }


  /*Futures || Network tasks */

  Future<void> initUi() async {
    // pd = initProgressDialog(context);
    prefs = await SharedPreferences.getInstance();
    String finalUrl = prefs.getString("subDomain").toString();
    String pickOrderID = prefs.getString(StringConst.pickUpOrderID).toString();
    pkOrderID = int.parse(pickOrderID);

    /*Getting Index of Saved Items*/
    _scannedIndex = prefs.getStringList(StringConst.pickUpsScannedIndex);
  }

  Future _savePickUpOrderTask() async {
    prefs = await SharedPreferences.getInstance();
    List<String> _savedPackCodesID = prefs.getStringList(
        StringConst.pickUpSavedPackCodesID);

    if (_savedPackCodesID != null) {
      for (var _packCodes in _savedPackCodesID) {
        int packId = int.parse(_packCodes.toString());
        if(_packIDList.contains(packId)){}else{
          _packIDList.add(packId);
        }


      }
      print("Saved Pack Codes : ${_packIDList.toString()}");
    };
    postPickUpOrder(_packIDList, widget.pickupDetailsID);
  }

  Future<void> postPickUpOrder(_pickUpOrderList, _pickUpDetailsItemID) async {
    String finalUrl = prefs.getString("subDomain").toString();
    try {

      Response response = await NetworkHelper(
          'https://$finalUrl${StringConst.urlCustomerOrderApp}pickup-customer-order')
          .pickUpOrders(_pickUpDetailsItemID, _pickUpOrderList);
log('https://$finalUrl${StringConst.urlCustomerOrderApp}pickup-customer-order');
log(response.body);
      if (response.statusCode == 401) {

      } else {
        if (response.statusCode == 200 || response.statusCode == 201) {
          prefs.remove(StringConst.pickUpsScannedIndex);
          prefs.remove(StringConst.pickUpSavedPackCodesID);
          popAndLoadPage(pkOrderID);
          displayToastSuccess(msg: 'Scan Successfull');
        }
        else if (response.statusCode == 400) {
          var jsonData = jsonDecode(response.body.toString());
          displayToast(msg: jsonData['message'].toString());
        }
        else {
          displayToast(msg: StringConst.somethingWrongMsg);
        }
      }
    }
    catch (e) {
      // prefs.remove(StringConst.pickUpSavedPackCodesID);
      displayToast(msg: e.toString());
      // pd.close();

    }
  }

  popAndLoadPage(pkOrderID) {
    Navigator.pop(context);
    Navigator.pop(context);
    goToPage(context, PickUpOrderDetails(pkOrderID));

    // goToPage(context, PickUpDetails());
  }


}
