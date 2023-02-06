class NotificationCountModel {
  int unreadCount;
  int totalCount;
  int customerOrderCount;
  int purchaseOrderCount;

  NotificationCountModel(
      {this.unreadCount,
        this.totalCount,
        this.customerOrderCount,
        this.purchaseOrderCount});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unread_count'];
    totalCount = json['total_count'];
    customerOrderCount = json['customer_order_count'];
    purchaseOrderCount = json['purchase_order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread_count'] = this.unreadCount;
    data['total_count'] = this.totalCount;
    data['customer_order_count'] = this.customerOrderCount;
    data['purchase_order_count'] = this.purchaseOrderCount;
    return data;
  }
}