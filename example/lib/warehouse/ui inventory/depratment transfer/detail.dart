import 'dart:convert';
import 'dart:developer';

import 'package:classic_simra/warehouse/ui%20inventory/depratment%20transfer/scanLocationForCodes.dart';
import 'package:classic_simra/warehouse/ui%20inventory/depratment%20transfer/scanToPickup.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/pickup_order_save_codes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';
import 'package:classic_simra/warehouse/ui inventory/depratment transfer/model/detail.dart';


class PickUpRequestedDetails extends StatefulWidget {
  final orderID;
  PickUpRequestedDetails(this.orderID);

  @override
  State<PickUpRequestedDetails> createState() => _PickUpRequestedDetailsState();
}

class _PickUpRequestedDetailsState extends State<PickUpRequestedDetails> {
  http.Response response;
  // ProgressDialog pd;
  Future<List<Results>> pickUpDetails;
  bool isPicked = true;
  List packLocations = [];
  double orderedQty=0.0;

  @override
  void initState() {
    pickUpDetails = pickUpOrdersDetails(widget.orderID);
    packLocations.clear();
    // pd = initProgressDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup Details"),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: FutureBuilder<List<Results>>(
          future: pickUpDetails,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return dropItemDetails(snapshot.data);
                }
            }
          }),
    );
  }

  Future<List<Results>> pickUpOrdersDetails(int receivedOrderID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(StringConst.pickUpOrderID, widget.orderID.toString());
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.departmentTrasnferSummary+receivedOrderID.toString()}'),
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
        log(response.body);
        return Detail.fromJson(jsonDecode(response.body.toString())).results;
      } else {
        displayToast(msg: StringConst.somethingWrongMsg);
      }
    }
    return null;
  }

  dropItemDetails(List<Results> data) {
    return data != null
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          /*Save PackType codes*/
          // savePackCodeList(data[index].);
          isPicked = data[index].isPicked;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: kMarginPaddSmall,
              color:isPicked==true?Colors.grey.shade400: Colors.white,
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
                          child: Text(
                            "Item Name:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 30,
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
                          child: Center(
                              child: Text(
                                "${data[index].itemName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                    // poInRowDesign('Item Name :',data[index].itemName),
                    kHeightSmall,
                    // poInRowDesign('Ordered Qty :', data[index].qty.toString()),
                    // kHeightMedium,
                    // poInRowDesign('Pickup Locations :', ''),

                    kHeightSmall,
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: showMorePickUpLocations(showPickUpLocations()),
                    ),
                    // kHeightMedium,
                    pickedOrNotPicked(data, index),
                  ],
                ),
              ),
            ),
          );
        })
        : const Text('We have no Data for now');
  }

  // void savePackCodeList(List<CustomerPackingType> customerPackingTypes) {
  //   for (int i = 0; i < customerPackingTypes.length; i++) {
  //     packLocations.add(customerPackingTypes[i].locationCode ?? "" + "\n");
  //   }
  // }

  String showPickUpLocations() {
    return packLocations.join(" , ").toString();
  }

  pickedOrNotPicked(data, index) {
    return !isPicked
        ? ElevatedButton(
      child:Text('Pick') ,

      onPressed: () => {

        // goToPage(context, PickUpScanLocation(data[index].customerPackingTypes, data[index].id, index))},
        goToPage(
            context,
            ScanLocation(data[index].id,data[index].refPurchaseDetail,
                data[index].packingType,5))
      },
    )
        : ElevatedButton(
      child:Text('Picked') ,
      onPressed: () {
        return displayToastSuccess(msg: 'Item Already Picked');
      },
    );
  }
}
