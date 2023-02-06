import 'dart:convert';
import 'dart:developer';
import 'package:classic_simra/Assets/assteMaster/model.dart';
import 'package:classic_simra/Assets/assteMaster/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../assetSummary/assetSummary.dart';


class EnrolledAssetMaster extends StatefulWidget {
  const EnrolledAssetMaster({Key key}) : super(key: key);

  @override
  State<EnrolledAssetMaster> createState() =>
      _EnrolledAssetMasterState();
}

class _EnrolledAssetMasterState extends State<EnrolledAssetMaster> {
  // String get $i => null;
  ListingServices listingservices = ListingServices();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';
  List serialNo = [];

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
  void initState() {

    // searchHandling();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

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
                          // Row(
                          //   children: [
                          //
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 0.0,right: 10),
                          //       child: Container(
                          //         width: MediaQuery.of(context).size.width/2,
                          //         child: TextFormField(
                          //           controller: _searchController,
                          //           keyboardType: TextInputType.text,
                          //           decoration: InputDecoration(
                          //             hintText: "Search",
                          //             hintStyle:
                          //             Theme.of(context).textTheme.subtitle1.copyWith(
                          //               fontSize: 18,
                          //               color: Colors.grey,
                          //             ),
                          //             // filled: true,
                          //             // fillColor: Theme.of(context).backgroundColor,
                          //             prefixIcon: const Icon(Icons.search),
                          //             border: InputBorder.none,
                          //             errorBorder: InputBorder.none,
                          //             errorMaxLines: 4,
                          //           ),
                          //           // validator: validator,
                          //           autovalidateMode: AutovalidateMode.onUserInteraction,
                          //           onChanged: (query) {
                          //             setState(() {
                          //               _searchItem = query;
                          //             });
                          //           },
                          //           textCapitalization: TextCapitalization.sentences,
                          //         ),
                          //       ),
                          //     ),
                          //
                          //
                          //   ],
                          // ),
                          FutureBuilder(


                            // future: customerServices
                            //     .fetchOrderListFromUrl(_searchItem),
                            future: listingservices.fetchOrderListFromUrl(),

                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {

                                try {


                                  final snapshotData = jsonDecode(snapshot.data);
                                  AssetMaster assetmaster =
                                  AssetMaster.fromJson(snapshotData);

                                  // log(customerOrderList.count.toString());

                                  return DataTable(

                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      columnSpacing: 0,
                                      horizontalMargin: 0,

                                      // columnSpacing: 10,

                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Text(" Reg No",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Text(
                                              'Item',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Text(
                                              'Cat',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Center(
                                                child: Text(
                                                  'S.Cat',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: width * .15,
                                            child: const Center(
                                                child: Text(
                                                  'Action',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                          assetmaster.results.length,
                                              (index) => DataRow(

                                            // selected: true,
                                            cells: [
                                              DataCell(
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Text(
                                                      assetmaster
                                                          .results[
                                                      index]
                                                          .registrationNo,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:10.0),
                                                    child: Text(
                                                        assetmaster
                                                            .results[
                                                        index]
                                                            .assetItemName.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  )),
                                              DataCell(
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:10.0),
                                                    child: Text(
                                                      assetmaster
                                                          .results[
                                                      index]
                                                          .assetCategoryName.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  )),
                                              DataCell(
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:10.0),
                                                    child: Text(
                                                      assetmaster
                                                          .results[
                                                      index]
                                                          .assetSubCategoryName.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  )),

                                              DataCell(
                                                Container(
                                                  height:40,

                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [


                                                      assetmaster.results[index].assetDetails[0].location.toString()=="null"?InkWell(
                                                        onTap: () {
                                                      Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AssetSummaryPage(
                                                                        id: assetmaster.results[index].id,
                                                                        SerialNo: serialNo,
                                                                      ),
                                                            ),
                                                          ) ;
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .indigo[900],
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      5))),
                                                          child: const Center(
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .eye,
                                                              size: 12,
                                                              color:
                                                              Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ): GestureDetector(
                                                        onTap:(){
                                                          Fluttertoast.showToast(msg: "Already Dropped cant assign the tag");
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .indigo[900],
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      5))),
                                                          child: const Center(
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .eye,
                                                              size: 12,
                                                              color:
                                                              Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )));
                                } catch (e) {
                                  throw Exception(e);
                                }
                              } else {
                                return Container(child:Text("Loading"));
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

}
