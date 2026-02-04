class EditReceiptModelDetailsModel {
  Data? data;
  bool? status;
  String? message;

  EditReceiptModelDetailsModel({this.data, this.status, this.message});

  EditReceiptModelDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? receiptId;
  String? displayRecNumber;
  String? receiptNumber;
  String? displayInvNumber;
  String? receiptDate;
  String? collectedBy;
  String? paymentMethod;
  String? totalAmount;
  String? amountDue;
  String? paidAmount;
  String? checkAmount;
  String? clientName;
  String? particulars;
  List<Staff>? staff;
  List<PaymentMethods>? paymentMethods;

  Data(
      {this.receiptId,
        this.displayRecNumber,
        this.receiptNumber,
        this.displayInvNumber,
        this.receiptDate,
        this.collectedBy,
        this.paymentMethod,
        this.totalAmount,
        this.amountDue,
        this.paidAmount,
        this.checkAmount,
        this.clientName,
        this.particulars,
        this.staff,
        this.paymentMethods});

  Data.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    displayRecNumber = json['display_rec_number'];
    receiptNumber = json['receipt_number'];
    displayInvNumber = json['display_inv_number'];
    receiptDate = json['receipt_date'];
    collectedBy = json['collected_by'];
    paymentMethod = json['payment_method'];
    totalAmount = json['total_amount'];
    amountDue = json['amount_due'];
    paidAmount = json['paid_amount'];
    checkAmount = json['check_amount'];
    clientName = json['client_name'];
    particulars = json['particulars'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['display_rec_number'] = this.displayRecNumber;
    data['receipt_number'] = this.receiptNumber;
    data['display_inv_number'] = this.displayInvNumber;
    data['receipt_date'] = this.receiptDate;
    data['collected_by'] = this.collectedBy;
    data['payment_method'] = this.paymentMethod;
    data['total_amount'] = this.totalAmount;
    data['amount_due'] = this.amountDue;
    data['paid_amount'] = this.paidAmount;
    data['check_amount'] = this.checkAmount;
    data['client_name'] = this.clientName;
    data['particulars'] = this.particulars;
    if (this.staff != null) {
      data['staff'] = this.staff!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
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