import 'dart:developer';
import 'package:classic_simra/warehouse/ui/Tasks/services/master.dart';
import 'package:classic_simra/warehouse/ui/Tasks/taskDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:classic_simra/warehouse/ui/Tasks/model/taskMaster.dart';
import '../../../../Constants/stringConst.dart';
import '../../../../Constants/styleConst.dart';


class TaskMasterPage extends StatefulWidget {
  const TaskMasterPage({Key key}) : super(key: key);

  @override
  State<TaskMasterPage> createState() => _TaskMasterPageState();
}

class _TaskMasterPageState extends State<TaskMasterPage> {

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

  http.Response response;
  // ProgressDialog pd;
  Future<List<Results>> pickUpList;
  final TextEditingController _searchController = TextEditingController();
  // ScrollController scrollController = ScrollController();

  String _search = '';

  // searchHandling<Result>() {
  //   log(" SEARCH ${_searchController.text}");
  //   if (_search == "") {
  //     pickUpList = pickUpOrders("");
  //     return pickUpList;
  //   } else {
  //     pickUpList = pickUpOrders(_search);
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

    // pd = initProgressDialog(context);

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
        title: Text("Task Pickup List"),
        backgroundColor: Color(0xff2c51a4),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // controller: controller,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
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
                      // value: dropdownValue,
                      hint: Text(dropdownValue),
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
                          dropdownValue = value;
                          value=="Pending"?status='1':value=="Cancelled"?status='2':value=="Approved"?status='3':value=="Completed"?status='4':'';
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
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
                          log(value);
                          value=="Today"?StartdateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString()
                              :value=="Yesterday"?StartdateController.text=DateTime.now().subtract(Duration(days:1)).year.toString()+'-'+DateTime.now().subtract(Duration(days:1)).month.toString()+'-'+DateTime.now().subtract(Duration(days:1)).day.toString()
                              :value=="Last Week"?StartdateController.text=DateTime.now().subtract(Duration(days:7)).year.toString()+'-'+DateTime.now().subtract(Duration(days:7)).month.toString()+'-'+DateTime.now().subtract(Duration(days:7)).day.toString():""
                          ;
                          value=="Today"?EnddateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString()
                              :value=="Yesterday"?EnddateController.text=DateTime.now().subtract(Duration(days:1)).year.toString()+'-'+DateTime.now().subtract(Duration(days:1)).month.toString()+'-'+DateTime.now().subtract(Duration(days:1)).day.toString()
                              :value=="Last Week"?EnddateController.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString():""
                          ;
                          log(StartdateController.text);
                          log(EnddateController.text);
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
            SizedBox(height: 10,),
            // TextFormField(
            //   controller: _searchController,
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //     hintText: "Search",
            //     hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
            //       fontSize: 18,
            //       color: Colors.grey,
            //     ),
            //     // filled: true,
            //     // fillColor: Theme.of(context).backgroundColor,
            //     prefixIcon: const Icon(Icons.search),
            //     border: InputBorder.none,
            //     errorBorder: InputBorder.none,
            //     errorMaxLines: 4,
            //   ),
            //   // validator: validator,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   onChanged: (query) {
            //     setState(() {
            //       _search = query;
            //       log(_search);
            //     });
            //   },
            //   textCapitalization: TextCapitalization.sentences,
            // ),
            ListView(
              // controller: controller,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                FutureBuilder<List<Results>>(
                    future: fetchTaskList(StartdateController.text,EnddateController.text,status),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
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

  _pickOrderCards(List<Results> data) {

    return data != null
        ? ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: data.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              data[index].isApproved==false
                  ? displayToast(msg: "Not Verified")
                  :data[index].status==4?displayToast(msg: "Lot Picked"):
              goToPage(context,
                  TaskDetailPage( data[index].id));
            },
            child: Card(
              margin: kMarginPaddSmall,
              color:  data[index].isApproved==true?Colors.white:Colors.grey.shade400,
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
                            "Task Name:",
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
                                "${data[index].name }",
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
                                "${data[index].taskNo}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                    // kHeightMedium,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           data[index].isApproved==false
                    //               ? displayToast(msg: "Not Verified")
                    //               :data[index].status==4?displayToast(msg: "Lot Picked"):
                    //           goToPage(context,
                    //               TaskDetailPage( data[index].id));
                    //         },
                    //         child: Icon(Icons.check),
                    //         style: ButtonStyle(
                    //           shadowColor: MaterialStateProperty.all<Color>(
                    //               Colors.grey),
                    //           backgroundColor:
                    //           MaterialStateProperty.all<Color>(        data[index].isApproved==false||data[index].status==4
                    //               ? Color.fromARGB(255, 68, 110, 201)
                    //               .withOpacity(0.3)
                    //               : Color.fromARGB(255, 68, 110, 201)),
                    //           shape: MaterialStateProperty.all<
                    //               RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15),
                    //               side: BorderSide(color: Colors.grey),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //
                    //   ],
                    // ),
                  ],
                ),
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
//
// Future<List<Results>> pickUpOrders(String search) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String finalUrl = prefs.getString("subDomain").toString();
//
//   final response = await http.get(
//       Uri.parse('https://$finalUrl${StringConst.urlCustomerOrderApp}order-master?ordering=-id&approved=true&limit=0&offset=0&search=$search'),
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
//     // replacePage(LoginScreen(), context);
//   } else {
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // printResponse(response);
//       return Task(response.body.toString()).results;
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
