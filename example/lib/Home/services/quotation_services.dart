import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constants/stringConst.dart';
import '../model/item_quotation_model.dart';
import '../model/quotation_model.dart';
import '../model/quotation_order_summary_model.dart';

class QuotationServices {
  final player = AudioPlayer();
  // void Notification() {
  //   player.play(AssetSource('images/notificationIMS.mp3'));
  // }

  List<Quotation> allQuotation = <Quotation>[];
  List<ItemQuotation> allItems = <ItemQuotation>[];

  Future fetchQuotationFromUrl(String search) async {
    // CustomerList? custom erList;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${StringConst.quotation + search}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return <Quotation>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchViewQuotationFromUrl(String id) async {
    // CustomerList? custom erList;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${StringConst.viewQuotation + id}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    // log(":::::::::::::::::::::::::::"+id);
    // log("me::::::::::::::::::::::::"+response.body);
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return <Quotation>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future cancelQuotationFromUrl(String id) async {
    log("This is cancel order id :::$id");
    // log("This is cancel order item :::$itemId");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.patch(
      Uri.parse(StringConst.baseUrl + StringConst.cancelQuotation + id),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
    );
    log("::::::::::::::" + id);
    log(response.statusCode.toString());
    log(response.body.toString());
    try {
      if (response.statusCode == 200) {
        // Notification();

        return response.body;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchQuotationOrderSummaryListFromUrl(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(StringConst.baseUrl + StringConst.quotationOrderSummary + id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
    try {
      if (response.statusCode == 200) {
        for (int i = 0;
            i < json.decode(response.body)['quotation_details'].length;
            i++) {
          sharedPreferences.setString(
              "item_name",
              json.decode(response.body)['quotation_details'][i]['item']
                  ['name']);
          sharedPreferences.setString("item_sale_cost",
              json.decode(response.body)['quotation_details'][i]['sale_cost']);
        }
        log(sharedPreferences.getString("item_name").toString());
        log(sharedPreferences.getString("item_sale_cost").toString());
        return response.body;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchQuotationOrderSummaryListFromUrlWithoutCancelled(
      String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(StringConst.baseUrl + StringConst.quotationOrderSummary + id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
    try {
      if (response.statusCode == 200) {
        var newvar =
            QuotationOrderSummeryModel.fromJson(json.decode(response.body));
        List<QuotationDetail> newDetail = [];
        for (int i = 0; i < newvar.quotationDetails.length; i++) {
          if (newvar.quotationDetails[i].cancelled == false) {
            newDetail.add(newvar.quotationDetails[i]);
          }
        }
        return newDetail;
      } else {
        log("${response.statusCode}");
        return <QuotationOrderSummeryModel>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchItemQuotationFromUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(StringConst.baseUrl + StringConst.itemQuotation),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    try {
      if (response.statusCode == 200) {
        for (int i = 0; i < json.decode(response.body)['results'].length; i++) {
          allItems.add(ItemQuotation(
              id: json.decode(response.body)['results'][i]['id'],
              itemCategory: ItemCategory.fromJson(
                  json.decode(response.body)['results'][i]['item_category']),
              name: json.decode(response.body)['results'][i]['name']));
        }
        return allItems;
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
