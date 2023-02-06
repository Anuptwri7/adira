class StringConst{
  // static String branchUrl ='https://api.sooritechnology.com.np/api/v1/branches';
// static String branchUrl ='https://api-soori-ims-staging.dipendranath.com.np/api/v1/branches';

 ///staging
static String branchUrl ='https://api-staging-adira.sooritechnology.com.np/api/v1/branches';

//local
// static String branchUrl ='http://192.168.101.5:8081/api/v1/branches';

///Production
// static String branchUrl ='https://adira-api.sooritechnology.com.np/api/v1/branches?limit=0';


// static String baseUrl = 'https://api-soori-ims-staging.dipendranath.com.np';
  // static String baseUrl = "https://api.sooritechnology.com.np";

 static String enrollAssets = '/api/v1/asset-app/asset-item-list?limit=0';
 static String category = '/api/v1/asset-app/asset-category?limit=0';
 static String subCategory = '/api/v1/asset-app/asset-sub-category?limit=0&asset_category=';
 static String enrollAssetsPost= '/api/v1/asset-app/asset';
 static String availableCodes= '/api/v1/asset-app/packing-type-detail-code-list?limit=50&item_id=';
 static String enrolledAssetMaster= '/api/v1/asset-app/asset?offset=0&limit=0&ordering=-id';
 static String assetAssign= '/api/v1/asset-app/asset-assign/';
 static String assetRfidSummary= '/api/v1/asset-app/asset-dispatch-tags/';
 // static String tagInfo= '/api/v1/asset-app/asset-info/';
 static String assettagInfo= '/api/v1/asset-app/asset-info/';
 static String dispatchtagInfo= '/api/v1/asset-app/asset-dispatch-info/';
 static String assetDetailMobile= '/api/v1/asset-app/asset-mobile/';
 static const String userList = "/api/v1/financial-report/user-list";
 static const String creditReport =
     "api/v1/financial-report/customer-credit?limit=0";
 static const String clearCreditInvoice =
     "api/v1/credit-management-app/clear-credit-invoice";
 static const String postPaymentMode = 'api/v1/core-app/payment-mode';
 static const String allCreditClearance =
     "api/v1/credit-management-app/credit-clearance?limit=0&ordering=-id&search=";
 static const String getCreditInvoice =
     "api/v1/credit-management-app/get-credit-invoice?limit=0&customer=";

 static const String creditCustomer =
     "api/v1/credit-management-app/customer-list?&limit=0";

 static const String paymentMethod =
     "api/v1/credit-management-app/payment-mode-list";

 static const String clearPartyInvoice =
     "party-payment-app/clear-party-invoice";
 static const String partyPayment =
     "api/v1/party-payment-app/party-payment?limit=0&ordering=-id";
 static const String partyPaymentSupplier =
     "api/v1/party-payment-app/supplier-list?limit=0";
 static const String getPartyInvoice =
     "api/v1/party-payment-app/get-party-invoice?&limit=0&supplier=";
 static const String itemList = "api/v1/customer-order-app/item-list?limit=0";
 static const String byBatch =
     "api/v1/customer-order-app/batch-list?&limit=0&search=";
 static const String allCustomer =
     "api/v1/customer-app/customer?limit=0&ordering=-id&search=";
 static const String orderMaster =
     "api/v1/customer-order-app/order-master?&ordering=-id&search=&limit=0";
 static const String orderDetails =
     "api/v1/customer-order-app/order-detail?limit=0&order=";
 static const String orderSummary = "api/v1/customer-order-app/order-summary/";

 static const String cancelOrder = "api/v1/customer-order-app/cancel-order/";
 static const String cancelSingleOrder =
     "api/v1/customer-order-app/cancel-single-order/";
 //save by batch
 static const String saveCustomerOrderByBatch =
     "api/v1/customer-order-app/save-customer-order-by-batch";

 static const String saveCustomerOrder =
     "api/v1/customer-order-app/save-customer-order";
 static const String quotation =
     "api/v1/quotation-app/quotation?offset=0&limit=0&ordering=-id";
 static const String viewQuotation =
     "api/v1/quotation-app/quotation-detail?quotation=";
// cancel quotation
 static const String cancelQuotation =
     "api/v1/quotation-app/cancel-quotation-master/";
//Quoatation Order Summary
 static const String quotationOrderSummary =
     "api/v1/quotation-app/quotation-summary/";
// update quotation
 static const String updateQuotation =
     "api/v1/quotation-app/update-quotation/";
//save Quotation
 static const String saveQuotation = "api/v1/quotation-app/save-quotation";
// item quotation
 static const String itemQuotation =
     "api/v1/quotation-app/item-list?search=&offset=0&limit=0";
 static const String readAllNotification =
     "api/v1/notification-app/user-notification/read-all";
// cancel single item Quotation
 static const String cancelItemQuotation =
     "api/v1/quotation-app/cancel-quotation-detail/";
 static const String stockListLocation =
     "api/v1/warehouse-location-app/location-items?limit=0&ordering=-id&search=";
 static const String stockListBatch =
     "api/v1/stock-analysis-app/stock-by-batch?limit=0&ordering=-id&search=";

 static const String stockList =
     "api/v1/stock-analysis-app/stock-analysis?limit=0&ordering=name&search=";
 static const String editCustomerOrderByBatch =
     "api/v1/customer-order-app/update-customer-order-by-batch/";
 static const String editCustomerOrder =
     "api/v1/customer-order-app/update-customer-order/";
 static const String createCustomer = "api/v1/customer-app/customer";
 static const String partyReport =
     'api/v1/financial-report/supplier-party-payment?limit=0';
 static const String supplierList = 'api/v1/financial-report/supplier-list';
 static const String customerOrderReport =
     'api/v1/financial-report/order-master?limit=0';
 static const String user = "api/v1/user-app/users/";
















 /*/ WareHouse Asset Api's */


 static String pickUp= '/api/v1/asset-app/asset-rfid-summary/';
 static String assetDispatch= '/api/v1/asset-app/dispatch-asset-dispatch?offset=0&limit=0&ordering=-id';
 static String assetSummary= '/api/v1/asset-app/dispatch-asset-detail?asset_dispatch=';
 static String location= '/api/v1/warehouse-location-app/location';
 static String assetDrop= '/api/v1/asset-app/location-asset-list';
 static String sendPickupDetail= '/api/v1/asset-app/pickup-asset-dispatch';
 static String assetDispatchReturn= '/api/v1/asset-app/dispatch-asset-return';
 static String assetDispatchTags= '/api/v1/asset-app/asset-dispatch-tags/';
 static String dispatchReturnMaster= '/api/v1/asset-app/dispatch-asset-return?ordering=-dispatch_no';
 static String assetDispatchReturnDrop= '/api/v1/asset-app/dispatch-return-drop';
 static String departmentTrasnferMaster= '/api/v1/department-transfer-app/department-transfer-master-from?limit=0&ordering=-id';
 static String departmentTrasnferSummary= '/api/v1/department-transfer-app/department-transfer-detail?limit=0&ordering=id&department_transfer_master=';
 static String getCodes= '/api/v1/department-transfer-app/pack-type-code-list?limit=0&purchase_detail=';
 static String getCodesByLocation= '/api/v1/department-transfer-app/pack-type-code-list?';
 static String postPickupRequestedDepartment= '/api/v1/department-transfer-app/pickup-department-transfer';
 static String taskMaster= '/api/v1/ppb-app/task-main?offset=0&limit=0&ordering=-id';
 static String taskDetail= '/api/v1/ppb-app/task-lot?offset=0&limit=0&ordering=-id&task_main=';
 static String lotOutputMaster= '/api/v1/ppb-app/task-output-purchase-master?ordering=-id&';
 static String lotOutputDetail= '/api/v1/ppb-app/location-task-output-purchase-details?limit=0&purchase=';
 static String updateLocationlot= '/api/v1/ppb-app/location-task-output-purchase-details';
 static String bulkUpdateLocationlot= '/api/v1/ppb-app/location-task-output-bulk-purchase-details';
 static String updateWeightLot= '/api/v1/ppb-app/weight-task-output-purchase-details';
 static String taskPickLotDetail= '/api/v1/ppb-app/task-lot-detail?lot_main=';
 static String taskPickupScan= '/api/v1/ppb-app/packing-type-code-list?limit=10&purchase_detail=';
 static String pickupTask= '/api/v1/ppb-app/pickup-task-lot';


 // Warehouse inventory api's
 static const String poIn = "IN";
 static const String poOut = "PICK UP";
 static const String locationShifting = "LOCATION SHIFT";
 static const String sale = "SALE";
 static const String info = "INFO";
 static const String chalan = "CHALAN";
 static const String chalanreturn = "Chalan Return";
 static const String chalanReturndrop = "Chalan Return Drop";
 static const String salereturn = "Sale Return";
 static const String salereturndrop = "Sale Return Drop";
 static const String bulkDrop = "Drop";
 static const String assetInfo = "Asset";
 static const String dispatchInfo = "Dispatch";
 static const String singleDrop = "Single Drop";
 static const String getPackInfo = "Pack Info";
 static const String serialInfo = "Serial Info";

 static const String poDrop = "DROP";
 static const String poAudit = "AUDIT";
 static const String openingStock = "OPEN STOCK";
 static const String transfer = "TRANSFER ORDER";
 static const String appName = "Soori Warehouses";

 /*Login Page*/
 static String loginWelcome = "Welcome !";
 static String loginText = " Login To Continue";
 static String rememberMe = "Remember Me";
 static String userName = 'Username';
 static String password = 'Password';
 static String subDomain = 'subDomain';

 /*Network */
 static String mainUrl = '';
 // static String branchUrl = 'http://192.168.101.19:8081/api/v1/branches';
 // static String branchUrl = 'http://default.api.v1.soori.ims.merakitechs.com/api/v1/branches';
 // static String branchUrl =
 //     'https://api.sooritechnology.com.np/api/v1/branches';
 // static String branchUrl =
 //     'https://api-soori-ims-staging.dipendranath.com.np/api/v1/branches';
 // static String baseUrl = 'https://api-soori-ims-staging.dipendranath.com.np';
 static const String refreshToken = "user-app/login/refresh";
 static const String logout = "user-app/logout";
 static String baseUrl = "https://api.sooritechnology.com.np";
 /*http://192.168.101.13:8000/api/v1/branches*/
 static String urlMidPoint = '/api/v1/user-app/';
 static String customerList = "api/v1/chalan-app/customer-list?limit=0";
 static String getPackCodes =
     "/api/v1/customer-order-app/batch-save-pickup-order";
 static String pickupVerify =
     '/api/v1/customer-order-app/verify-pickup-customer-order';
 static const String allNotification =
     "api/v1/notification-app/user-notification?limit=0&ordering=-created_date_ad";
 static const String notificationCount =
     "api/v1/notification-app/user-notification/count";
 static const String notificationReceive =
     "api/v1/notification-app/user-notification/receive";


 static String pendingPurchaseSummary = "/api/v1/purchase-app/";
 static String chalanReturnDrop =
     '/api/v1/chalan-app/chalan-master-returned?offset=0&limit=0&return_dropped=false';
 static String chalanReturn =
     '/api/v1/chalan-app/chalan-master-returned?search=&offset=0&limit=0';
 static String chalanReturnView =
     '/api/v1/chalan-app/chalan-detail?chalan_master=';
 static String chalanReturnDropUpdate =
     '/api/v1/chalan-app/chalan-return-drop';
 static String chalanReturnAddChalanNo =
     '/api/v1/chalan-app/chalan-master-chalan?';
 static String chalanReturnDropScanNow =
     '/api/v1/chalan-app/chalan-return-info?limit=0&chalan_master=';
 static String chalanReturnDropScanService =
     '/api/v1/chalan-app/chalan-return-drop';
 static String saleReturn = '/api/v1/sale-app/sale-master-return';
 static String saleReturnView =
     '/api/v1/sale-app/sale-detail?limit=0&sale_master=';
 static String saleReturnDrop =
     '/api/v1/sale-app/sale-master-return?offset=0&limit=0&return_dropped=false';
 static String urlPurchaseApp = '/api/v1/purchase-app/';
 static String bulkDropApi = '/api/v1/purchase-app/location-bulk-purchase-order-details';
 static String urlAuditApp = '/api/v1/audit-app/';
 static String urlCustomerOrderApp = '/api/v1/customer-order-app/';
 static String urlOpeningStockApp = '/api/v1/opening-stock-app/location-bulk-purchase-details';
 static String openingStockMaster = '/api/v1/opening-stock-app/opening-stock?offset=0&limit=10&ordering=-id&';
 static String openingStockDetailFromMaster = '/api/v1/purchase-app/purchase-detail?purchase=';
 static String locationShiftingApi =
     '/api/v1/item-serialization-app/update-pack-location';
 static String locationShiftingGetId =
     '/api/v1/item-serialization-app/pack-code-location/';
 static String packInfoGetData = '/api/v1/item-serialization-app/pack-code-info/';
 static String serialInfoGetData = '/api/v1/item-serialization-app/serial-no-info/';
 static String transferMaster= "/api/v1/transfer-app/";
 static String pickupDetail= "/api/v1/transfer-app/pack-type?purchase_detail=";
 static String getSerialCode= "/api/v1/transfer-app/pack-type-detail?";
 static String postPickupTransfer= "/api/v1/transfer-app/pickup-transfer";

 /*For Headers*/
 static const contentType = 'application/json; charset=UTF-8';
 static const xRequestedWith = 'XMLHttpRequest';
 static String bearerAuthToken = 'BearerAuthToken';

 /*Others*/
 static String pendingOrders = 'Pending Orders';
 static String purchaseOrdersDetail = 'Purchase Order Details';
 static String selectBranch = 'Select Branch';

 static var somethingWrongMsg = '';
 static String loading = 'Loading...';

 static String updateSerialNumber = 'Update Serial Numbers';

 static String pQty = 'purchaseQty';
 static String pItem = 'purchaseItem';
 static String pPackingType = 'purchasePackingType';
 static String pPackingTypeDetail = 'purchaseTypeDetail';
 static String pRefPurchaseOrderDetail = 'purchaseRefPurchaseOrderDetail';
 static String pTotalUnitBoxes = 'totalUnitBoxes';

 static String pSerialNo = "purchaseSerialNo";

 static String packSerialNo = "Serial No";

 static String saveButton = 'SAVE';
 static String updateButton = 'UPDATE';
 static String packingType = 'Packing Type';

 static String noDataAvailable = 'No Data Available';

 static String serverErrorMsg = 'We ran into problem, Please Try Again';

/*Drop Items*/
 static String dropOrders = 'Drop Received Orders';
 static String bulkdropOrders = 'Bulk Drop Received Orders';
 static String dropOrdersDetail = 'Drop Order Details';
 static String bulkdropOrdersDetail = 'Bulk Drop Order Details';
 static String dropOrderID = 'dropID';

 /*PickUp*/
 static String pickOrders = 'Pickup Orders';
 static String pickUpOrderID = 'pickUpOrderID';
 static String pickUpOrdersDetail = 'Pickup Details';
 static String pickUpSavedPackCodesID = 'pickUpSavedPackCodesID';
 static String pickUpsSavedItemID = 'pickUpsSavedItemID';
 static String pickUpsScannedIndex = 'pickUpsScannedIndex';

 /*Opening Stock*/
 static String openingStocks = 'Opening Stocks ';
 static String openingStockDetail = 'Opening Stock Details';
 static String openingStockOrderID = 'openStockID';

}