import 'package:flutter/cupertino.dart';

import '../model/customer_model.dart';
import '../services/customer_api.dart';

class CustomerListProvider extends ChangeNotifier {
  List<AllCustomer> _allCustomer = [];

  CustomerServices customerServices = CustomerServices();
  List<AllCustomer> get allCustomer => [..._allCustomer];
  Future<void> fetchAllCustomer(BuildContext context) async {
    _allCustomer = [];
    List<AllCustomer> fetchAllCustomerList = [];
    final result = await customerServices.fetchCustomerFromUrl();

    result['results'].forEach(
      (element) {
        fetchAllCustomerList.add(
          AllCustomer.fromJson(element),
        );
      },
    );
    _allCustomer = fetchAllCustomerList;
    notifyListeners();
  }
}
