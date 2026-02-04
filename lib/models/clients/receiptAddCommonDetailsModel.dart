class ReceiptAddCommonDetailsModel {
  Data? data;
  bool? status;
  String? message;

  ReceiptAddCommonDetailsModel({this.data, this.status, this.message});

  ReceiptAddCommonDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? name;
  String? displayRecNumber;
  String? displayInvNumber;
  List<Staff>? staff;
  List<PaymentMethods>? paymentMethods;
  String? invoiceId;
  String? customerId;
  String? receiptNumber;
  String? totalAmount;
  String? amountDue;
  String? particulars;

  Data(
      {this.name,
        this.displayRecNumber,
        this.displayInvNumber,
        this.staff,
        this.paymentMethods,
        this.invoiceId,
        this.customerId,
        this.receiptNumber,
        this.totalAmount,
        this.amountDue,
        this.particulars});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayRecNumber = json['display_rec_number'];
    displayInvNumber = json['display_inv_number'];
    if (json['staff'] != null) {
      staff = <Staff>[];
      json['staff'].forEach((v) {
        staff!.add(new Staff.fromJson(v));
      });
    }
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    invoiceId = json['invoice_id'];
    customerId = json['customer_id'];
    receiptNumber = json['receipt_number'];
    totalAmount = json['total_amount'];
    amountDue = json['amount_due'];
    particulars = json['particulars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['display_rec_number'] = this.displayRecNumber;
    data['display_inv_number'] = this.displayInvNumber;
    if (this.staff != null) {
      data['staff'] = this.staff!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    data['invoice_id'] = this.invoiceId;
    data['customer_id'] = this.customerId;
    data['receipt_number'] = this.receiptNumber;
    data['total_amount'] = this.totalAmount;
    data['amount_due'] = this.amountDue;
    data['particulars'] = this.particulars;
    return data;
  }
}

class Staff {
  String? userId;
  String? staffName;

  Staff({this.userId, this.staffName});

  Staff.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['staff_name'] = this.staffName;
    return data;
  }
}

class PaymentMethods {
  String? id;
  String? name;

  PaymentMethods({this.id, this.name});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}