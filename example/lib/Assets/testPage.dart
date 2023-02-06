import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:zebra_datawedge/zebra_datawedge.dart';
import 'package:zebra_rfid/zebra_rfid.dart';

class SerialInfoPage extends StatefulWidget {
  @override
  State<SerialInfoPage> createState() => _SerialInfoPageState();
}

class _SerialInfoPageState extends State<SerialInfoPage> {
  List<String> _packCodesListPackInfo = [];
  List<String> _packCodesID = [];

  List<String> locationNumber = [];

  // List<String> _savedPackCodesID = [];

  List<String> _scanedSerialNo = [];
  String _packCodeNo = '', _scanedLocationNo = '', receivedLocation = '';
  String _currentScannedCode = '';
 int totalSerialNo;

  List<String> _scannedIndex = [];

  @override
  void initState() {
    // ZebraRfid.disconnect();
    // ZebraDataWedge.listenForDataWedgeEvent((event) { });
    _newPickupInitDataWedgeListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serial Info"),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Serial Code',

            ),
          ),
          Card(
            color: Color(0xffeff3ff),
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Text(
                "${_packCodesListPackInfo.isEmpty ? "Please scan Serial code" : _packCodesListPackInfo}"),
          ),
              Container(),
        ],
      ),
    );
  }

  // /*UI Part*/
  // _displayLocationSerialNo() {
  //   return Card(
  //     color: Color(0xffeff3ff),
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
  //                   _scanedLocationNo,
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
  //
  // _displayItemsSerialNo() {
  //   return Card(
  //     color: Color(0xffeff3ff),
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
  //                   '${StringConst.packSerialNo} / Pack No :',
  //                   style: kTextStyleSmall.copyWith(
  //                       fontWeight: FontWeight.bold, color: Colors.black),
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 4,
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: _scanedSerialNo.length,
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Text(
  //                       _scanedSerialNo[index].isNotEmpty
  //                           ? _scanedSerialNo[index]
  //                           : '',
  //                       style: kTextStyleSmall.copyWith(
  //                           fontWeight: FontWeight.bold, color: Colors.black),
  //                     );
  //                   },
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
  //
  // printLocationCodes() {
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Text(
  //       receivedLocation,
  //       style: kTextBlackSmall,
  //     ),
  //   );
  // }
  //
  // displaySerialNos() {
  //   return Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: smallShowMorePickUpLocations(
  //           "${_packCodesListPackInfo.join("\n").toString()} "));
  // }

  Future<void> _newPickupInitDataWedgeListener() async {
    ZebraDataWedge.listenForDataWedgeEvent((response) {
      if (response != null && response is String) {
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response);

          if (jsonResponse != null) {
            _currentScannedCode = jsonResponse["decodedData"].toString().trim();

            if (_packCodesListPackInfo.isEmpty) {
              _packCodesListPackInfo.add(_currentScannedCode);
            } else {
              log('packo' + _packCodesListPackInfo.toString());
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

}
