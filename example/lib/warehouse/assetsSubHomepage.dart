import 'dart:convert';


import 'package:classic_simra/warehouse/ui/Tasks/Task%20Lot%20Output/taskLotOutputDrop.dart';
import 'package:classic_simra/warehouse/ui/Tasks/model/taskMaster.dart';
import 'package:classic_simra/warehouse/ui/Tasks/taskMaster.dart';
import 'package:classic_simra/warehouse/ui/drop/homePage.dart';
import 'package:classic_simra/warehouse/ui/info/dispatch/infoPage.dart';
import 'package:classic_simra/warehouse/ui/info/tagInfo.dart';
import 'package:classic_simra/warehouse/ui/pickUp/homePage.dart';
import 'package:classic_simra/warehouse/ui/return/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/stringConst.dart';
import '../Constants/styleConst.dart';
import '../main.dart';

import 'package:http/http.dart' as http;

class AssetsSubHomePage extends StatefulWidget {
  @override
  State<AssetsSubHomePage> createState() => _AssetsSubHomePageState();
}
class _AssetsSubHomePageState extends State<AssetsSubHomePage> {
  String  name;
  int numNotific = 10;

  @override
  void initState() {
    super.initState();



  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:AppBar(
        actions: [
          // const Icon(
          //   Icons.search,
          //   color: Color(0xff2c51a4),
          // ),


          // const SizedBox(
          //   width: 10,
          // ),

          const SizedBox(
            width: 15,
          ),
        ],

        title: Row(
          children:  [

            Text(
              "ASSETS",
              style: TextStyle(color: Colors.blueGrey, fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20,right:20 ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // height: 350,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Color(0x155665df),
                        spreadRadius: 5,
                        blurRadius: 17,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesign(Icons.arrow_drop_up,"Dispatch Pickup",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>PickupHomePage()))),
                          kHeightVeryBig,
                          _poButtonDesign(Icons.arrow_drop_up,"Asset Drop",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>DropMaster()))),
                        ],
                      ),
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesign(Icons.arrow_drop_up,"Dispatch Return",
                              goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AssetDispatchReturnMaster()))),
                          kHeightVeryBig,
                          _poButtonDesign(Icons.arrow_drop_up,"Tag Info",
                              goToPage: () => OpenDialogCustomer(context)),
                        ],
                      ),
                      kHeightVeryBig,

                      _poButtonDesign(Icons.arrow_drop_up,"FG Drop",
                          goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LotOutputMasterPage()))),
                      kHeightVeryBig,

                      _poButtonDesign(Icons.arrow_drop_up,"Task Pickup",
                          goToPage: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskMasterPage()))),





                      kHeightVeryBig,

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  _poButtonDesign(IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.white,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 60,
          width: 150,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
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
          child: Column(
            children: [
              Icon(
                buttonIcon,
                size: 32,
                color: Colors.black,
              ),
              Text(
                buttonString,
                style: kTextStyleBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _poButtonDesignDailog(IconData buttonIcon, String buttonString,
      { VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.white,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 60,
          width: 120,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
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
          child: Column(
            children: [
              SizedBox(height: 10,),
              Icon(
                buttonIcon,
                size: 20,
                color: Colors.black,
              ),
              // SizedBox(height: 5,),
              Text(
                buttonString,
                style: kTextStyleBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_poButtonDesignDailog(IconData buttonIcon, String buttonString,
    { VoidCallback goToPage}) {
  return Card(
    elevation: kCardElevation,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: InkWell(
      focusColor: Colors.white,
      onTap: goToPage,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 60,
        width: 120,
        // color: Colors.blueGrey[700],
        // color: Colors.white10,
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
        child: Column(
          children: [
            SizedBox(height: 10,),
            Icon(
              buttonIcon,
              size: 20,
              color: Colors.black,
            ),
            // SizedBox(height: 5,),
            Text(
              buttonString,
              style: kTextStyleBlack,
            ),
          ],
        ),
      ),
    ),
  );
}


Future OpenDialogCustomer(BuildContext context) =>
    showDialog(
      barrierColor: Colors.black38,

      context: context,

      builder: (context) => Dialog(
        backgroundColor: Colors.indigo.shade50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // height:600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Column(
                    children: [
                      kHeightVeryBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _poButtonDesignDailog(Icons.arrow_circle_down_sharp, StringConst.assetInfo,
                              goToPage: () => goToPage(context, TagInfo())),
                          kHeightVeryBig,
                          _poButtonDesignDailog(Icons.arrow_drop_down, StringConst.dispatchInfo,
                              goToPage: () => goToPage(context, DispatchTagInfo())),
                          kHeightVeryBig,
                          kHeightVeryBig,
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView(
                            // controller: scrollController,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [

                            ],
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
                  child: Icon(Icons.ac_unit_sharp,size: 40,),
                  radius: 40,

                )),

          ],
        ),
      ),

    );