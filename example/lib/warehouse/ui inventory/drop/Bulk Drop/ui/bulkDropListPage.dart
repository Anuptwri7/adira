import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/stringConst.dart';
import '../../../../../Constants/styleConst.dart';
import '../../model/drop_list.dart';
import '../../ui/drop_order_details.dart';
import 'bulkOrderDetailPage.dart';


class BulkPODrop extends StatefulWidget {
  const BulkPODrop({Key key}) : super(key: key);

  @override
  _BulkPODropState createState() => _BulkPODropState();
}

class _BulkPODropState extends State<BulkPODrop> {

   http.Response response;

   Future<List<Result>> dropOrderReceived;


  @override
  void initState() {
    // dropOrderReceived = listDropReceivedOrders();
    super.initState();
  }
   List<String> list = <String>['Pending', 'Cancelled','Approved','Completed'];
   List<String> listDate = <String>['Today',"Yesterday","Last Week"];
   String dropdownValue = 'Select Status';
   String dropdownValueDate = 'Select date';
   TextEditingController StartdateController = TextEditingController();
   TextEditingController EnddateController = TextEditingController();
   String status= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.bulkdropOrders),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Row(
              children: [

                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width/2.5,
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
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  child: DropdownButton<String>(
                    // value: dropdownValueDate,
                    hint: Text(dropdownValueDate),
                    // icon: const Icon(Icons.arrow_downward,color: Color,),
                    elevation: 16,
                    style: const TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValueDate = value;

                        value=="Today"?StartdateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString()
                            :value=="Yesterday"?StartdateController.text=DateTime.now().subtract(Duration(days:1)).year.toString()+'-'+DateTime.now().subtract(Duration(days:1)).month.toString()+'-'+DateTime.now().subtract(Duration(days:1)).day.toString()
                            :value=="Last Week"?StartdateController.text=DateTime.now().subtract(Duration(days:7)).year.toString()+'-'+DateTime.now().subtract(Duration(days:7)).month.toString()+'-'+DateTime.now().subtract(Duration(days:7)).day.toString():""
                        ;
                        value=="Today"?EnddateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString()
                            :value=="Yesterday"?EnddateController.text=DateTime.now().subtract(Duration(days:1)).year.toString()+'-'+DateTime.now().subtract(Duration(days:1)).month.toString()+'-'+DateTime.now().subtract(Duration(days:1)).day.toString()
                            :value=="Last Week"?EnddateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString():""
                        ;
                      });
                    },
                    items: listDate.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),
          FutureBuilder<List<Result>>(
              future: listDropReceivedOrders(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return _dropOrderCards(snapshot.data);
                    }
                }
              })
        ],
      ),
    );
  }

  _dropOrderCards(List<Result> data) {
    return data != null
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
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
                        child: Text("Received No :",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        height: 30,
                        width: 200,
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
                        child: Center(child: Text("${data[index].orderNo}",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                  kHeightSmall,
                  // poInRowDesign('Received No :', data[index].orderNo),
                  Row(
                    children: [
                      Container(
                        child: Text("Date :",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(width: 75,),
                      Container(
                        height: 30,
                        width: 200,
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
                        child: Center(child: Text("${data[index].createdDateAd.toString().substring(0,10)}",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                  kHeightSmall,
                  // poInRowDesign(
                  //     'Date :',
                  //     data[index]
                  //         .createdDateAd
                  //         .toLocal()
                  //         .toString()
                  //         .substring(0, 10)),
                  Row(
                    children: [
                      Container(
                        child: Center(child: Text("Supplier Name :",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        height: 30,
                        width: 200,
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
                        child: Center(child: Text("${data[index].supplierName}",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                  kHeightSmall,
                  // poInRowDesign('Supplier Name :',
                  //     data[index].supplierName),
                  // kHeightMedium,
                  taskCheckButtons(data, index),
                ],
              ),
            ),
          );
        })
        : Center(
      child: Text(
        StringConst.noDataAvailable,
        style: kTextStyleBlack,
      ),
    );
  }

  Future<List<Result>> listDropReceivedOrders() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String finalUrl = prefs.getString(StringConst.subDomain).toString();
    String finalUrl = prefs.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl${StringConst.urlPurchaseApp}get-orders/received?ordering=-id&limit=0&date_after=${StartdateController.text.toString()}&date_before=${EnddateController.text.toString()}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get("access_token")}'
        });
    // http.Response response = await NetworkHelper(
    //     '$finalUrl${StringConst.urlPurchaseApp}get-orders/received?ordering=-id&limit=0')
    //     .getOrdersWithToken();

    if (response.statusCode == 401) {

    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return dropOrderReceiveFromJson(response.body.toString()).results;
      } else {
        displayToast(msg: StringConst.somethingWrongMsg);
      }
    }
  }

  taskCheckButtons(List<Result> _data, _index) {

    bool taskCheck = true;
    for(int i = 0; i < _data[_index].purchaseOrderDetails.length; i++){
      for(int j = 0; j < _data[_index].purchaseOrderDetails[i].poPackTypeCodes.length; j++){

        if(_data[_index].purchaseOrderDetails[i].poPackTypeCodes[j].location != null){
          taskCheck = true;
        }
        else{
          taskCheck = false;
          break;
        }

      }
    }

    return taskCheck
        ? ElevatedButton(
      child: Text('Task Completed'),
      onPressed: () => goToPage(context, BulkDropOrderDetails(_data[_index].id)),
      // color: Color(0xff6b88e8),
    )
        :  ElevatedButton(
      child: Text('View Details'),
      onPressed: () => goToPage(context, BulkDropOrderDetails(_data[_index].id)),
      // color: Color(0xff2c51a4),
    )
    ;
  }

}
