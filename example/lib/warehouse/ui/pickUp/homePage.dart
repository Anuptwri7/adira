import 'dart:developer';

import 'package:classic_simra/warehouse/ui/pickUp/model/disptachModel.dart';
import 'package:classic_simra/warehouse/ui/pickUp/pickupScanPage.dart';
import 'package:classic_simra/warehouse/ui/pickUp/pickupSummary.dart';
import 'package:classic_simra/warehouse/ui/pickUp/services/assetDispatch.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Constants/styleConst.dart';
import 'assetSummaryPage.dart';


class PickupHomePage extends StatefulWidget {
  const PickupHomePage({Key key}) : super(key: key);

  @override
  State<PickupHomePage> createState() => _PickupHomePageState();
}

class _PickupHomePageState extends State<PickupHomePage> {

  int page =0;
  int limit = 10;
  bool isFirstLoadRunning = false;
  List post = [];
  bool hasNextPage=true;
  bool isLoadMoreRunning = false;

  void firstLoad(){
    setState(() {
      isFirstLoadRunning = true;
    });
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void loadMore() async {
    setState(() {
      isLoadMoreRunning = true;
    });
    page+=10;
    setState(() {
      isLoadMoreRunning = false;
    });
  }

  Future<List<Results>> pickUpList;
  final TextEditingController _searchController = TextEditingController();
  // ScrollController scrollController = ScrollController();

  String _search = '';

  // searchHandling<Results>() {
  //   log(" SEARCH ${_searchController.text}");
  //   if (_search == "") {
  //     pickUpList = fetchDispatchList(_search);
  //     return pickUpList;
  //   } else {
  //     pickUpList = fetchDispatchList(_search);
  //     return pickUpList;
  //   }
  // }

  // bool loading = false;
  // bool allLoaded = false;
   ScrollController controller;
  @override
  void initState() {

    controller = ScrollController()..addListener(loadMore);
    firstLoad();

    super.initState();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent &&
    //       !loading) {}
    // });
  }

  @override
  void dispose() {
    // _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset Pickup List"),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // controller: controller,
        child: Column(

          children: [
            TextFormField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                // filled: true,
                // fillColor: Theme.of(context).backgroundColor,
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                errorMaxLines: 4,
              ),
              // validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (query) {
                setState(() {
                  _search = query;
                  log(_search);
                });
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            ListView(
              // controller: controller,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                FutureBuilder<List<Results>>(
                    future: fetchDispatchList(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            log(snapshot.data.toString());
                            return _pickOrderCards(snapshot.data);
                          }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  _pickOrderCards( data) {

    return data != null
        ? ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: data.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>PickUpSummary(id:data[index].id)));
            },
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
                          child: Text(
                            "Asset No:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
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
                                "${data[index].createdByUserName }",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                    kHeightSmall,
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "Order No:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 20,
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
                                "${data[index].dispatchNo}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),


                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        })
        : Center(
      child: Text(
       "jh",
        style: kTextStyleBlack,
      ),
    );
  }

  // Future<List<Result>> pickUpOrders(String search) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String finalUrl = prefs.getString("subDomain").toString();
  //
  //   final response = await http.get(
  //       Uri.parse('https://$finalUrl${StringConst.pickUp}'),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${prefs.get("access_token")}'
  //       });
  //   // http.Response response = await NetworkHelper(
  //   //         '$finalUrl${StringConst.urlCustomerOrderApp}order-master?ordering=-id&limit=0&offset=0&search=$search')
  //   //     .getOrdersWithToken();
  //   print("Response Code Drop: ${response.statusCode}");
  //   log("${response.body}");
  //
  //   if (response.statusCode == 401) {
  //     replacePage(LoginScreen(), context);
  //   } else {
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       printResponse(response);
  //       return pickUpListFromJson(response.body.toString()).results;
  //     } else {
  //       displayToast(msg: StringConst.somethingWrongMsg);
  //     }
  //   }
  //   setState(() {
  //     isFirstLoadRunning = false;
  //   });
  //   return null;
  // }
}
