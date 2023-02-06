import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:classic_simra/Assets/EnrollAssetSecondPage.dart';
import 'package:classic_simra/Assets/assetItem/categoryModel.dart';
import 'package:classic_simra/Assets/assetItem/model.dart';
import 'package:classic_simra/Assets/subCategory/services.dart';
import 'package:classic_simra/provider/categoryListProvider.dart';
import 'package:classic_simra/provider/model/subCategoryModel.dart';
import 'package:classic_simra/provider/subCategoryListProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zebra_rfid/base.dart';
import 'package:zebra_rfid/zebra_rfid.dart';
import 'package:http/http.dart' as http;

import '../Constants/stringConst.dart';
import '../Constants/styleConst.dart';
import '../provider/itemListProvider.dart';
import 'assetItem/services.dart';



class EnrollAssets extends StatefulWidget {
  const EnrollAssets({Key key}) : super(key: key);

  @override
  State<EnrollAssets> createState() => _EnrollAssetsState();
}

class _EnrollAssetsState extends State<EnrollAssets> {


  SubCategoryClass subCategoryClass = SubCategoryClass();
  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController = TextEditingController();
  TextEditingController costtextEditingController = TextEditingController();
  TextEditingController eoltextEditingController = TextEditingController();
  TextEditingController netvaluetextEditingController = TextEditingController();
  TextEditingController qtytextEditingController = TextEditingController();
  TextEditingController amctextEditingController = TextEditingController();
  TextEditingController warrentytextEditingController = TextEditingController();
  TextEditingController salvagetextEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController depRatetextEditingController = TextEditingController();
  TextEditingController bookValueRatetextEditingController = TextEditingController();
  TextEditingController maintaintextEditingController = TextEditingController();
  TextEditingController vehicleNumbertextEditingController = TextEditingController();
  TextEditingController phoneNumbertextEditingController = TextEditingController();
  TextEditingController ownertextEditingController = TextEditingController();
  TextEditingController ownerIdtextEditingController = TextEditingController();
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController remarkstextEditingController = TextEditingController();

  String dropdownValueCategory= "Select Category";
  String subCategorydropdownValue = "Select Category" ;
  String dropDownValueItem="Select Item";
  String ownerNamedropdownValue = "Select the Owner Name";
  String dropdownvalueLocation = 'Select Location';
  String _selectedSupplierName;
  String _selectedDepreciation;
  String _selectedType;
  String _selectedItem;
  int _selectedItemId;
  int _selectedCategory;
  int _selectedSubCategory;
  int _selectedOwner;
  int _selectedLocation;
  bool isCheckedAsset=true;
  bool isAsset = false;
  bool isDep1=false;
  bool isDep2=false;
  ByteData byteData;
  void initState() {
    // ZebraRfid.setEventHandler(ZebraEngineEventHandler(
    //   readRfidCallback: (datas) async {
    //     addDatas(datas);
    //   },
    //   errorCallback: (err) {
    //     ZebraRfid.toast(err.errorMessage);
    //   },
    //   connectionStatusCallback: (status) {
    //     setState(() {
    //       connectionStatus = status;
    //
    //     });
    //   },
    // ));
    final itemdata = Provider.of<ItemListProvider>(context, listen: false);
    itemdata.fetchAllItem(context);
    // final categorydata = Provider.of<CategoryListProvider>(context, listen: false);
    // categorydata.fetchAllCategory(context);
    // ZebraRfid.connect();
    // log(androidBatteryInfo.pluggedStatus);

    super.initState();
    // initPlatformState();

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
    context.read<CategoryListProvider>().fetchAllCategory();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.indigo;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Enroll Assets"),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery
                .of(context)
                .size
                .width,

            decoration: const BoxDecoration(
              // boxShadow: [

              // borderRadius: BorderRadius.all(
              //   Radius.circular(10.0),
              // ),
              // color:Color(0xfff4f7ff),
            ),
            child: Column(
              children: [

                Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: dropDownsDecoration,
                  child: Consumer<ItemListProvider>(
                      builder: ((context, item, child) {
                        return DropdownButton<Result>(
                          elevation: 24,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${dropDownValueItem.isEmpty
                                ? "Select Items"
                                : dropDownValueItem}"),
                          ),
                          // value: snapshotData.first,
                          iconSize: 24.0,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: item.allItem
                              .map<DropdownMenuItem<Result>>((Result items) {
                            return DropdownMenuItem<Result>(
                              value: items,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),
                          onChanged: (Result newValue) {
                            setState(
                                  () {
                                _selectedItem = newValue.name.toString();
                                _selectedItemId = newValue.id;
                                dropDownValueItem = newValue.name;

                                log("--------------------------------" +
                                    _selectedItem.toString());
                                log("--------------------------------" +
                                    _selectedItemId.toString());
                              },
                            );
                          },
                        );

                      })),
                ),
                Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: dropDownsDecoration,
                  child: Consumer<CategoryListProvider>(
                      builder: ((context, item, child) {
                        return DropdownButton<ResultCategory>(
                          elevation: 24,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${dropdownValueCategory.isEmpty
                                ? "Select Category"
                                : dropdownValueCategory}"),
                          ),
                          // value: snapshotData.first,
                          iconSize: 24.0,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: item.allCategory
                              .map<DropdownMenuItem<ResultCategory>>((
                              ResultCategory items) {
                            return DropdownMenuItem<ResultCategory>(
                              value: items,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),

                          onChanged: (ResultCategory newValue) {
                            setState(
                                  () {
                                dropdownValueCategory =
                                    newValue.name.toString();
                                _selectedCategory = newValue.id;

                                log("--------------------------------" +
                                    _selectedCategory.toString());
                                log("--------------------------------" +
                                    dropdownValueCategory.toString());
                              },
                            );
                          },
                        );

                      })),
                ),
                Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: dropDownsDecoration,

                    child: _selectedCategory.toString() == null
                        ? Container()
                        : FutureBuilder(
                      future:
                      subCategoryClass.fetchSubCategory(_selectedCategory)
                          .then((value) async {
                        if (_selectedCategory != null) {
                          await context
                              .read<SubCategoryListProvider>()
                              .fetchAllCategory(
                              _selectedCategory);
                        }
                      }),
                      builder: (BuildContext context,
                          AsyncSnapshot snapshot) {
                        log(snapshot.hasData.toString());
                        if (snapshot.data == null &&
                            _selectedCategory == null) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Select Category"),
                          );
                        }

                        return Consumer<SubCategoryListProvider>(
                            builder:
                                (context, message, child) {
                              // log("--------+$message");
                              return DropdownButton<ResultSubCategory>(
                                elevation: 24,
                                isExpanded: true,
                                hint: Text("$subCategorydropdownValue"),
                                // value: snapshotData.first,

                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                items: message.allSubCategory
                                    .map<DropdownMenuItem<ResultSubCategory>>((
                                    ResultSubCategory items) {
                                  return DropdownMenuItem<ResultSubCategory>(
                                    value: items,
                                    child: Text(items.name.toString()),
                                  );
                                }).toList(),

                                onChanged: (ResultSubCategory newValue) {
                                  setState(
                                        () {
                                      subCategorydropdownValue =
                                          newValue.name.toString();
                                      _selectedSubCategory = newValue.id;

                                      log("--------------------------------" +
                                          subCategorydropdownValue.toString());
                                      log("--------------------------------" +
                                          _selectedSubCategory.toString());
                                    },
                                  );
                                },

                              );
                              //   SearchChoices.single(
                              //   items: message.allSubCategory.map(
                              //           (ResultSubCategory value) {
                              //         return (DropdownMenuItem(
                              //           child: Padding(
                              //             padding:
                              //             const EdgeInsets.only(
                              //                 left: 10,
                              //                 top: 5.0),
                              //             child: Text(
                              //               "${value.name}",
                              //               style: const TextStyle(
                              //                   fontSize: 14),
                              //             ),
                              //           ),
                              //           value: value.name
                              //               .toString(),
                              //           onTap: () {
                              //             _selectedSubCategory= value.id;
                              //             subCategorydropdownValue = value.name;
                              //
                              //
                              //             log(
                              //                 'selected item is Taxable or not : ${_selectedSubCategory
                              //                     .toString()}');
                              //             // log('selected item is Taxable or not : ${value.batchNo.toString()}');
                              //             // });
                              //           },
                              //         ));
                              //       }).toList(),
                              //   value: subCategorydropdownValue,
                              //   clearIcon: const Icon(
                              //     Icons.close,
                              //     size: 0,
                              //   ),
                              //   icon: const Visibility(
                              //     visible: false,
                              //     child: Icon(
                              //         Icons.arrow_downward),
                              //   ),
                              //   underline:
                              //   DropdownButtonHideUnderline(
                              //       child: Container()),
                              //   padding: 0,
                              //   hint: const Padding(
                              //     padding: EdgeInsets.only(
                              //         top: 15, left: 8),
                              //     child: Text(
                              //       "Select Batch",
                              //       style:
                              //       TextStyle(fontSize: 15),
                              //     ),
                              //   ),
                              //   searchHint: "Select Batch",
                              //   onChanged:
                              //       (ResultSubCategory value) {},
                              //   dialogBox: true,
                              //   keyboardType:
                              //   TextInputType.text,
                              //   isExpanded: true,
                              // );
                            });
                      },
                    )),


                Visibility(
                  visible: isCheckedAsset,
                  child: Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: assetContainerDecoration,
                    child: TextField(
                      controller: titletextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter the Title',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                //for document

                //for Vehicle


                //for asset
                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: assetContainerDecoration,
                    child: TextField(
                      // obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: descriptiontextEditingController,
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Describe the document',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),


                ///////---------------------
                Visibility(
                  visible: isCheckedAsset,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 10.0, right: 10),
                    child: Container(
                      // height: 40,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.1,
                              blurRadius: 6,
                              offset: Offset(4, 4),
                            )
                          ]),

                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: const Text(
                            "Depreciation Method", style: TextStyle(
                            fontSize: 16, color: Colors.black87,),),
                        ),

                        icon: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: const Visibility (visible: false, child: Icon(
                            Icons.arrow_downward,
                            color: Color.fromRGBO(105, 131, 162, 20),
                            size: 14,)),
                        ),
                        items: <String>['STRAIGHT_LINE', 'DECLINING_BALANCE']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Text(value.toString()),
                            ),
                            onTap: () {
                              value == 'STRAIGHT_LINE' ?
                              _selectedType = '1' : value ==
                                  'DECLINING_BALANCE'
                                  ? _selectedType = '2'
                                  : _selectedType = '0';
                              _selectedDepreciation = value.toString();
                              log("ejkd" + _selectedType.toString());
                              log(_selectedDepreciation.toString());
                            },
                          );
                        }).toList(),
                        value: _selectedDepreciation,
                        underline:
                        DropdownButtonHideUnderline(
                            child: Container()),
                        onChanged: (newValue) {
                          setState(() {
                            newValue = _selectedType.toString();
                          });
                        },
                      ),

                    ),
                  ),
                ),
                // for asset
                Visibility(
                  visible: isCheckedAsset,
                  child: Visibility(
                    visible: _selectedType == "1" ||
                        _selectedType == "2" ? true : false,
                    child: Row(
                      children: [
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: netvaluetextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Net Value',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: costtextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Cost',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: qtytextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Qty',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isCheckedAsset,
                  child: Visibility(
                    visible: _selectedType == "1" ||
                        _selectedType == "2" ? true : false,
                    child: Row(
                      children: [
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: warrentytextEditingController,
                            decoration: InputDecoration(


                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Warrenty',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: amctextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'AMC',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4.5,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: maintaintextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Maintainance',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isCheckedAsset,
                  child: Visibility(
                    visible: _selectedType == "1" ? true : false,
                    child: Row(
                      children: [
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.75,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: eoltextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'EOL',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.5,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: salvagetextEditingController,
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Salvage',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isCheckedAsset,
                  child: Visibility(
                    visible: _selectedType == "2"
                        ? true
                        : false,
                    child: Row(
                      children: [
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.75,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: depRatetextEditingController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Depreciation Rate',
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        Container(
                          decoration: assetContainerDecoration,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.5,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            // obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: bookValueRatetextEditingController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Adjusted Book value',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                //for asset

                // for document

                // kHeightSmall,kHeightSmall,kHeightSmall,kHeightSmall,

                // for Save asset
                Visibility(
                  visible: isCheckedAsset,
                  child: Container(
                    padding: const EdgeInsets.only(left: 120, right: 120),
                    child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EnrollAssetsSecondPage(
                            itemId: _selectedItemId,
                            categoryId: _selectedCategory,
                            subCategoryId: _selectedSubCategory,
                            tittle: titletextEditingController.text,
                            describe: descriptiontextEditingController.text,
                            depMethod: _selectedType,
                            net: netvaluetextEditingController.text,
                            qty: qtytextEditingController.text,
                            warrnety: warrentytextEditingController.text,
                            amc: amctextEditingController.text,
                            maintain: maintaintextEditingController.text,
                            eol: eoltextEditingController.text,
                            salvage: salvagetextEditingController.text,
                            depRate: depRatetextEditingController.text,
                            book: bookValueRatetextEditingController.text,
                          )
                          )) ;
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
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),


              ],
            )
        ),


      ),
    );
  }

  // Future SaveAsset(BuildContext context) async {
  //   final SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //
  //   final responseBody = {
  //     "asset_details": [
  //       {
  //         "packing_type_detail_code": document
  //       }
  //     ],
  //     "registration_no": "string",
  //     "scrapped": true,
  //     "available": true,
  //     "qty": 0,
  //     "adjusted_book_value": "string",
  //     "net_value": "string",
  //     "remarks": "string",
  //     "salvage_value": "string",
  //     "depreciation_rate": "string",
  //     "amc_rate": "string",
  //     "depreciation_method": 1,
  //     "end_of_life_in_years": 0,
  //     "warranty_duration": 0,
  //     "maintenance_duration": 0,
  //     "category": 0,
  //     "sub_category": 0,
  //     "item": 0
  //   };
  //   log(json.encode(responseBody));
  //   final response = await http.post(
  //       Uri.parse(ApiConstant.baseUrl + ApiConstant.saveDocument),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  //       },
  //       body: json.encode(responseBody));
  //   log(response.body);
  //   if (response.statusCode == 201) {
  //     Fluttertoast.showToast(msg: "Done Successfully!",backgroundColor: Colors.red);
  //
  //     log(responseBody.toString());
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DocumentMaster()));
  //
  //   } else if (response.statusCode == 400) {
  //     Fluttertoast.showToast(msg: json.decode(response.body)["message"],backgroundColor: Colors.red);
  //   }
  //
  //   return response;
  // }
  Future OpenDialogToEnrollOwner(BuildContext context) =>
      showDialog(
        barrierColor: Colors.black38,

        context: context,

        builder: (context) => Dialog(
          backgroundColor: Colors.indigo.shade50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(

                  // height: MediaQuery.of(context).size.height/1.5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(left: 40,right: 40),
                              child: TextField(
                                controller: nametextEditingController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Owner Name',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15))),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/4,
                                  margin: const EdgeInsets.only(top:5,left: 40,right: 10),
                                  child: TextField(
                                    controller: ownerIdtextEditingController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Owner Id',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        contentPadding: const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15))),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {},
                                  child: Container(
                                    height: 50 ,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Icon(Icons.camera),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top:10,left: 40,right: 40),
                              child: TextField(
                                controller: emailtextEditingController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Email',
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
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top:10,left: 40,right: 40),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phonetextEditingController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Phone',
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
                              padding: EdgeInsets.only(top:10),

                              child: ElevatedButton(
                                  onPressed: () async {
                                    // CreateOwner(context);

                                    // SaveDocumentMultipart();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff789cc8),

                                    // minimumSize: const Size.fromHeight(30),
                                    // maximumSize: const Size.fromHeight(56),
                                  ),
                                  child: const Text(
                                    "Create",
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  )),
                            ),





                          ],
                        ),


                      ],
                    ),
                  ),

                ),
              ),
              Positioned(
                  top:-35,

                  child: CircleAvatar(
                    child: Icon(Icons.book_outlined,size: 40,),
                    radius: 40,

                  )),

            ],
          ),
        ),

      );
  Future EnrollAssets() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final responseBody = {
      "asset_details": [
        {
          "packing_type_detail_code": 1234
        }
      ],
      // "registration_no": "string",
      "scrapped": true,
      "available": true,
      "qty": qtytextEditingController.text.toString(),
      "adjusted_book_value": bookValueRatetextEditingController.text.toString(),
      "net_value": netvaluetextEditingController.text.toString(),
      "remarks": " ",
      "salvage_value": salvagetextEditingController.text.toString(),
      "depreciation_rate": depRatetextEditingController.text.toString(),
      "amc_rate": amctextEditingController.text.toString(),
      "depreciation_method":_selectedType,
      "end_of_life_in_years": eoltextEditingController.text.toString(),
      "warranty_duration": warrentytextEditingController.text.toString(),
      "maintenance_duration": maintaintextEditingController.text.toString(),
      "category": _selectedCategory,
      "sub_category": _selectedSubCategory,
      "item": _selectedItemId
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl${StringConst.enrollAssetsPost}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201) {
      // qtyController.clear();
      // pricecontroller.clear();
      // discountPercentageController.clear();
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }

}

