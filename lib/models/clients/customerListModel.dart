class CustomerListModel {
  List<Data>? data;
  bool? status;
  String? message;

  CustomerListModel({this.data, this.status, this.message});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? contactNo;
  String? address;
  String? address2;
  String? address3;
  String? pincode;
  String? gstNum;

  Data(
      {this.id,
        this.name,
        this.contactNo,
        this.address,
        this.address2,
        this.address3,
        this.pincode,
        this.gstNum});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNo = json['contact_no'];
    address = json['address'];
    address2 = json['address2'];
    address3 = json['address3'];
    pincode = json['pincode'];
    gstNum = json['gst_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['pincode'] = this.pincode;
    data['gst_num'] = this.gstNum;
    return data;
  }
}