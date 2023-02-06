// To parse this JSON data, do
//
//     final pickUpList = pickUpListFromJson(jsonString);

import 'dart:convert';

PickUpList pickUpListFromJson(String str) =>
    PickUpList.fromJson(json.decode(str));

String pickUpListToJson(PickUpList data) => json.encode(data.toJson());

class PickUpList {
  PickUpList({
     this.count,
     this.next,
     this.previous,
     this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory PickUpList.fromJson(Map<String, dynamic> json) => PickUpList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
     this.id,
     this.orderNo,
     this.customer,
     this.customerFirstName,
     this.customerLastName,
     this.pickVerified,
     this.createdByUserName,
     this.statusDisplay,
     this.totalDiscount,
     this.status,
     this.totalTax,
     this.subTotal,
     this.deliveryDateAd,
     this.deliveryDateBs,
     this.deliveryLocation,
     this.grandTotal,
     this.isPicked,
     this.remarks,
     this.createdDateAd,
     this.createdDateBs,
     this.byBatch,
  });

  int id;
  String orderNo;
  Customer customer;
  String customerFirstName;
  String customerLastName;
  bool pickVerified;
  String createdByUserName;
  String statusDisplay;
  String totalDiscount;
  int status;
  String totalTax;
  String subTotal;
  dynamic deliveryDateAd;
  String deliveryDateBs;
  String deliveryLocation;
  String grandTotal;
  bool isPicked;
  String remarks;
  DateTime createdDateAd;
  DateTime createdDateBs;
  bool byBatch;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        orderNo: json["order_no"],
        customer: Customer.fromJson(json["customer"]),
        customerFirstName: json["customer_first_name"],
        customerLastName: json["customer_last_name"],
        pickVerified: json["pick_verified"],
        createdByUserName: json["created_by_user_name"],
        statusDisplay: json["status_display"],
        totalDiscount: json["total_discount"],
        status: json["status"],
        totalTax: json["total_tax"],
        subTotal: json["sub_total"],
        deliveryDateAd: json["delivery_date_ad"],
        deliveryDateBs: json["delivery_date_bs"],
        deliveryLocation: json["delivery_location"],
        grandTotal: json["grand_total"],
        isPicked: json["is_picked"],
        remarks: json["remarks"],
        createdDateAd: DateTime.parse(json["created_date_ad"]),
        createdDateBs: DateTime.parse(json["created_date_bs"]),
        byBatch: json["by_batch"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "customer": customer.toJson(),
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
        "pick_verified": pickVerified,
        "created_by_user_name": createdByUserName,
        "status_display": statusDisplay,
        "total_discount": totalDiscount,
        "status": status,
        "total_tax": totalTax,
        "sub_total": subTotal,
        "delivery_date_ad": deliveryDateAd,
        "delivery_date_bs": deliveryDateBs,
        "delivery_location": deliveryLocation,
        "grand_total": grandTotal,
        "is_picked": isPicked,
        "remarks": remarks,
        "created_date_ad": createdDateAd.toIso8601String(),
        "created_date_bs":
            "${createdDateBs.year.toString().padLeft(4, '0')}-${createdDateBs.month.toString().padLeft(2, '0')}-${createdDateBs.day.toString().padLeft(2, '0')}",
        "by_batch": byBatch,
      };
}

class Customer {
  Customer({
     this.firstName,
     this.lastName,
     this.id,
  });

  String firstName;
  String lastName;
  int id;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firstName: json["first_name"],
        lastName: json["last_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "id": id,
      };
}
