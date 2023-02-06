import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/warehouse/ui%20inventory/pick/model/pack_type_model.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/ByBatch/testPickUpByBatch.dart';
import 'package:classic_simra/warehouse/ui/Tasks/pick/scanPackCodesPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zebra_datawedge/zebra_datawedge.dart';

import 'package:http/http.dart' as http;

import '../../../../../../Constants/stringConst.dart';
import '../../../../../../Constants/styleConst.dart';
import '../../../ui inventory/depratment transfer/controller/scan_serial_controller.dart';
import '../../../ui inventory/pick/ui/ByBatch/pick_order_byBatch.dart';
import '../taskMaster.dart';


class GetPackCodeFromLocation extends StatefulWidget {
  int orderId;
  int purchaseDetail;
  double qty;
  GetPackCodeFromLocation(this.purchaseDetail, this.orderId, this.qty);

  @override
  State<GetPackCodeFromLocation> createState() =>
      _GetPackCodeFromLocationState();
}

class _GetPackCodeFromLocationState
    extends State<GetPackCodeFromLocation> {
  http.Response response;

  String receivedLocation = '';
  String _currentScannedLocation = '';
  // ProgressDialog pd;
  String finalUrl = '';
  int pkOrderID;
  SharedPreferences prefs;
  List<String> location = [];

  String errorMessage = '';

  Future searchHandling() async {
    if (_currentScannedLocation == "") {
      return pickUpLocationPackTypeDetails(widget.purchaseDetail, "hhh");
    } else {
      return pickUpLocationPackTypeDetails(
          widget.purchaseDetail, _currentScannedLocation);
    }
  }
  List finalPackId = [];
  String masterId='';

  Future getCodesId() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    // finalPackId=preferences.getStringList("PackId");
    for(int i =0;i<preferences.getStringList("PackId").length;i++){
      finalPackId.add(preferences.getStringList("PackId")[i]);
    }

    log("Pack Codes"+finalPackId.toString());
  }
  Future getMasterId() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    masterId=preferences.getString("masterId");
    log(masterId.toString());
  }

  Future availableLocation(receivedOrderID) async {
    prefs = await SharedPreferences.getInstance();
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.urlCustomerOrderApp}pack-type?&purchase_detail=$receivedOrderID&location_code='),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });
    // response = await NetworkHelper(
    //         '$finalUrl${StringConst.baseUrl+StringConst.urlCustomerOrderApp}pack-type?&purchase_detail=$receivedOrderID&location_code=')
    //     .getOrdersWithToken();

    if (response.statusCode == 401) {

    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = packTypeListFromJson(response.body.toString()).results;
        location.clear();

        // for (var i = 0; i < data.length; i++) {
        //   location.add(data[i].locationCode);
        //   location.toSet().toList();
        // }
        for (int i = 0; i < data.length; i++) {
          if (location.contains(data[i].locationCode.toString())) {
          } else {
            location.add(data[i].locationCode.toString());
          }
        }
        return location;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCodesId();
    getMasterId();
    _newScannedLocationInitDataWedgeListener();
  }


  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {

          // prefs.remove("PackId");

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Save Pickup Codes'),
          backgroundColor: Color(0xff2c51a4),
          actions: [
            InkWell(
              onTap: () => _completedButton(context,finalPackId,masterId),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Text('Save', style: kTextStyleWhite,),
              ),
            )
          ],
        ),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Card(
                  margin: kMarginPaddSmall,
                  // color: const Color(0xffeff3ff),
                  color: Color.fromARGB(255, 204, 212, 241),

                  elevation: kCardElevation,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Container(
                    padding: kMarginPaddSmall,
                    child: Column(
                      children: [
                        kHeightMedium,
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "Locations",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    // height: 0,
                                    width: 220,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffeff3ff),
                                      borderRadius: BorderRadius.circular(10),
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Color(0xffeff3ff),
                                      //     offset: Offset(-2, -2),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 10,
                                      //   ),
                                      // ],
                                    ),
                                    child: Center(
                                      child: FutureBuilder(
                                          future: availableLocation(
                                              widget.purchaseDetail),
                                          builder: (context, snapshot) {
                                            receivedLocation =
                                                snapshot.data.toString();
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return const Center(
                                                    child:
                                                    CircularProgressIndicator());
                                              default:
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  return displayLocation();
                                                  //   return availableLocationList(
                                                  //       snapshot.data);
                                                }
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Ordered Qty",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/4,
                                  // height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffeff3ff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "${(widget.qty)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                        kHeightMedium,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20, right: 10),
              ),
              _currentScannedLocation.isNotEmpty &&
                  location.contains(_currentScannedLocation)
                  ? FutureBuilder(
                  future: searchHandling(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                            child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return dropItemByBtachDetails(snapshot.data);
                        }
                    }
                  })
                  : Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: _currentScannedLocation.isEmpty
                          ? Text(
                        "Please Scan location",
                        style: TextStyle(fontSize: 20),
                      )
                          : Text(
                        "Please Scan location",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  displayLocation() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: smallShowMorePickUpLocations("${location.join("\n").toString()} "),
    );
  }

  dropItemByBtachDetails(data) {
    return data != null
        ? ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: ()=>{
          goToPage(
          context,
          ScanPickupCodesAndStore(
          data[index].code,
          data[index].locationCode,
         widget.orderId,
          data[index].id

          ),
          ),
          },
              // Provider.of<SerialController>(context,
              //     listen: false)
              //     .serialId
              //     .length !=
              //     widget.qty.toInt() &&
              //     Provider.of<SerialController>(context, listen: false)
              //         .scannnedPK
              //         .contains(
              //       data[index].code,
              //     )
              //     ? displayToast(msg: "Already scanned")
              //     :
              //



            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: kMarginPaddSmall,
                color:
                // Provider.of<SerialController>(context, listen: false)
                //     .scannnedPK
                //     .contains(
                //   data[index].code,
                // )
                //     ? Colors.grey
                //     :
                Colors.white,
                elevation: kCardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Container(
                  padding: kMarginPaddSmall,
                  child: Column(
                    children: [
                      kHeightMedium,
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Pk code",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 218, 225, 247),
                              // color: const Color(0xffeff3ff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                                  "${data[index].code}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            child: Text(
                              "R Qty  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 30,
                            // width: 150,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 218, 225, 247),
                              // color: const Color(0xffeff3ff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                                  "${data[index].remainingQty}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),

                      kHeightMedium,
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Pickup Location:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 218, 225, 247),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                                  "${data[index].locationCode}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        })
        : const Text('We have no Data for now');
  }
  Future<void> _newScannedLocationInitDataWedgeListener() async {
    ZebraDataWedge.listenForDataWedgeEvent(
          (response) {
        if (response != null && response is String) {
          Map<String, dynamic> jsonResponse;
          try {
            jsonResponse = json.decode(response);
            if (jsonResponse != null) {
              _currentScannedLocation =
                  jsonResponse["decodedData"].toString().trim();
              if (location.contains(_currentScannedLocation)) {
              } else {
                // displayToast(msg: "Please scan Loations");
              }

              log("Scanned Location No : ${_currentScannedLocation.toString()}");
            } else {}

            setState(() {});
          } catch (e) {}
        } else {}
      },
    );
  }

  _completedButton(BuildContext context,List packCodes, String id) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Do You Finished Scanning?',
              style: kTextStyleBlack,
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Yes',
                  style: kTextStyleBlack,
                ),
                onPressed: () async {

                  // Navigator.of(context).pop();
                  Navigator.pop(context);
                  // _savePickUpOrderTask();
                  pickup(packCodes,id.toString(),widget.qty.toInt());


                  // Navigator.pop(context);


                },
              ),
              noAlertTextButton()
            ],
          );
        });
  }
  Future pickup(List packCode,String id,int qty) async {

    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
  log("pack codes"+packCode.toString());
    List packTypeDetail=[];
    for(int i=0;i<packCode.length;i++){

      packTypeDetail.add(

          {
            "packing_type_code": packCode[i],
            "sale_packing_type_detail_code": [

            ],
            "qty": qty
          }


      );
    }

log("id to send"+id.toString());
    final responseBody = ({
      "task_lot_detail_id": id,
      "task_lot_packing_types": packTypeDetail
    });
    log(responseBody.toString());
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.pickupTask}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: jsonEncode(responseBody));

    if (response.statusCode == 200||response.statusCode==201) {
          setState(() {
            prefs.remove("masterId");
            prefs.remove("PackId");
          });

      displayToast(msg: "Picked Sucessfully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskMasterPage()));

    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

  noAlertTextButton() {
    return TextButton(
      child: const Text('No', style: kTextStyleBlack),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future _savePickUpOrderTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String finalUrl = prefs.getString("subDomain").toString();
    int order = int.parse(pref.getString("order").toString());
    final scan = Provider.of<SerialController>(context, listen: false);
    final scanedCode = scan.serialCode;
    final scannedId = scan.serialId;
    final scannedPack = scan.customer_packing_types;
    log("Scanned Serial Code" + scanedCode.toString());
    log("Scanned Serial code Id" + scannedId.toString());

    final responseBody = {
      "customer_order_detail": widget.orderId,
      "customer_packing_types": scannedPack
    };

    log("Scanned Serial code final" + json.encode(responseBody));
    try {
      var response = await http.post(
        Uri.parse("https://$finalUrl${StringConst.getPackCodes}"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        },
        body: (
            json.encode(responseBody)
        ),
      );
      // final response = await http.post(
      //     Uri.parse(${finalUrl}
      //          StringConst.getPackCodes),
      //     headers: await NetworkHelper.tokenHeader(),
      //     body: json.encode(responseBody));
      // log(response.body);
      // log(response.reasonPhrase.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        scan.serialCode.clear();
        scan.serialId.clear();
        scan.customer_packing_types.clear();
        Navigator.pop(context);
        Navigator.pushReplacement(

            context,
            MaterialPageRoute(
                builder: (context) => PickUpOrderByBatchDetails(order)));

        // displayToast(msg: "save Succefully");
      } else {
        displayToast(msg: "${response.reasonPhrase}+ Please Scan Again");
      }
    } catch (e) {
      // displayToast(msg: e.toString());
      rethrow;
    }
  }

  Future pickUpLocationPackTypeDetails(
      int receivedOrderID, String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String finalUrl = prefs.getString(StringConst.subDomain).toString();
    prefs.setString(
        StringConst.pickUpOrderID, widget.purchaseDetail.toString());
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.urlCustomerOrderApp}pack-type?limit=0&purchase_detail=$receivedOrderID&location_code=$search'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });
    // response = await NetworkHelper(
    //         '$finalUrl${StringConst.baseUrl+StringConst.urlCustomerOrderApp}pack-type?limit=0&purchase_detail=$receivedOrderID&location_code=$search')
    //     .getOrdersWithToken();
log(response.body);
    if (response.statusCode == 401) {

    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = packTypeListFromJson(response.body.toString()).results;
        return data;
      } else {
        displayToast(msg: StringConst.somethingWrongMsg);
      }
    }
    return null;
  }

  popAndLoadPage(pkOrderID) {
    Navigator.pop(context);
    Navigator.pop(context);
    goToPage(context, PickUpOrderByBatchDetails(pkOrderID));
  }
}
