class InvoiceListModel {
  List<Data>? data;
  bool? status;
  String? message;

  InvoiceListModel({this.data, this.status, this.message});

  InvoiceListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? invoiceNumber;
  String? invoiceDate;
  String? customerName;
  String? paymentMode;
  String? totalAmount;
  String? totalPaid;
  String? balance;
  String? status;
  bool? isPaid;
  String? receiptId;
  String? recieptAmount;
  String? clientId;

  Data(
      {this.id,
        this.invoiceNumber,
        this.invoiceDate,
        this.customerName,
        this.paymentMode,
        this.totalAmount,
        this.totalPaid,
        this.balance,
        this.status,
        this.isPaid,
        this.receiptId,
        this.recieptAmount,
        this.clientId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    customerName = json['customer_name'];
    paymentMode = json['payment_mode'];
    totalAmount = json['total_amount'];
    totalPaid = json['total_paid'];
    balance = json['balance'];
    status = json['status'];
    isPaid = json['is_paid'];
    receiptId = json['receipt_id'];
    recieptAmount = json['reciept_amount'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_date'] = this.invoiceDate;
    data['customer_name'] = this.customerName;
    data['payment_mode'] = this.paymentMode;
    data['total_amount'] = this.totalAmount;
    data['total_paid'] = this.totalPaid;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['is_paid'] = this.isPaid;
    data['receipt_id'] = this.receiptId;
    data['reciept_amount'] = this.recieptAmount;
    data['client_id'] = this.clientId;
    return data;
  }
}