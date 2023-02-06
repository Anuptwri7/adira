import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Constants/stringConst.dart';
import '../model/get_party_invoice_model.dart';
import '../model/supplierListModel.dart';

List<GetPartyInvoiceModel> allSupplier = <GetPartyInvoiceModel>[];

Future fetchSupplierFromUrl() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/${StringConst.partyPaymentSupplier}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });
  List<SupplierListModel> allPartySupplier = [];

  if (response.statusCode == 200) {
    int resultLength = json.decode(response.body)['results'].length;
    for (var i = 0; i < resultLength; i++) {
      allPartySupplier.add(
        SupplierListModel(
          id: json.decode(response.body)['results'][i]['id'],
          name: json.decode(response.body)['results'][i]['name'].toString(),
          creditAmount: json
              .decode(response.body)['results'][i]['credit_amount']
              .toString(),
          paidAmount: json
              .decode(response.body)['results'][i]['paid_amount']
              .toString(),
          dueAmount:
              json.decode(response.body)['results'][i]['due_amount'].toString(),
        ),
      );
    }
    log("Helloe helooee");
    log(allPartySupplier.first.name);
    return allPartySupplier;
  }
}

Future getPartyInvoiceFromUrl(String supplier) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/${StringConst.getPartyInvoice + supplier}'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });

  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        allSupplier.add(
          GetPartyInvoiceModel(
            supplier: json.decode(response.body)['results'][i]['supplier'],
            supplierName: json
                .decode(response.body)['results'][i]['supplier_name']
                .toString(),
            purchaseNo: json
                .decode(response.body)['results'][i]['purchase_number']
                .toString(),
            purchaseId: json.decode(response.body)['results'][i]['purchase_id'],
            totalAmount: json
                .decode(response.body)['results'][i]['total_amount']
                .toString(),
            paidAmount: json
                .decode(response.body)['results'][i]['paid_amount']
                .toString(),
            dueAmount: json
                .decode(response.body)['results'][i]['due_amount']
                .toString(),
          ),
        );
      }
      return allSupplier;
    }
  } catch (e) {
    throw Exception(e);
  }
}
