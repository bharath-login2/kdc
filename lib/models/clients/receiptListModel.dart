class ReceiptListModel {
  List<Data>? data;
  bool? status;
  String? message;

  ReceiptListModel({this.data, this.status, this.message});

  ReceiptListModel.fromJson(Map<String, dynamic> json) {
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
  String? receiptNumber;
  String? invoiceNumber;
  String? receiptDate;
  String? customerName;
  String? recieptAmount;
  String? collectedStaff;

  Data(
      {this.id,
        this.receiptNumber,
        this.invoiceNumber,
        this.receiptDate,
        this.customerName,
        this.recieptAmount,
        this.collectedStaff});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptNumber = json['receipt_number'];
    invoiceNumber = json['invoice_number'];
    receiptDate = json['receipt_date'];
    customerName = json['customer_name'];
    recieptAmount = json['reciept_amount'];
    collectedStaff = json['collected_staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receipt_number'] = this.receiptNumber;
    data['invoice_number'] = this.invoiceNumber;
    data['receipt_date'] = this.receiptDate;
    data['customer_name'] = this.customerName;
    data['reciept_amount'] = this.recieptAmount;
    data['collected_staff'] = this.collectedStaff;
    return data;
  }
}