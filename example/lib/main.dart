import 'package:classic_simra/provider/availableSerialCodes.dart';
import 'package:classic_simra/provider/categoryListProvider.dart';
import 'package:classic_simra/provider/itemListProvider.dart';
import 'package:classic_simra/provider/subCategoryListProvider.dart';
import 'package:classic_simra/selectOptionPage.dart';
import 'package:classic_simra/warehouse/provider/locatiobDropdown.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/ByBatch/controller/scan_serial_controller.dart';
import 'package:classic_simra/warehouse/ui%20inventory/pick/ui/Verification/scan_verified_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/Notification/controller/notificationController.dart';
import 'Home/provider/byBatchProvider.dart';
import 'Home/provider/customer_list_provider.dart';
import 'Home/provider/item_list_provider.dart';
import 'Login/wareHouseLoginPage.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ItemListProvider>(
          create: (_) => ItemListProvider()),
      ChangeNotifierProvider<CategoryListProvider>(
          create: (_) => CategoryListProvider()),
      ChangeNotifierProvider<SubCategoryListProvider>(
          create: (_) => SubCategoryListProvider()),
      ChangeNotifierProvider<AvailableSerialCodes>(
          create: (_) => AvailableSerialCodes()),
      ChangeNotifierProvider<LocationList>(create: (_) => LocationList()),
      ChangeNotifierProvider<CustomerListProvider>(
          create: (_) => CustomerListProvider()),
      ChangeNotifierProvider<CustomerItemListProvider>(
          create: (_) => CustomerItemListProvider()),
      ChangeNotifierProvider<BatchListProvider>(
          create: (_) => BatchListProvider()),
      ChangeNotifierProvider<NotificationClass>(
          create: (_) => NotificationClass()),
      ChangeNotifierProvider(create: (_) => SerialController()),
      ChangeNotifierProvider(create: (_) => VerifiedController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Soori RFID',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: WareHouseLoginPage(),
    );
  }
}
