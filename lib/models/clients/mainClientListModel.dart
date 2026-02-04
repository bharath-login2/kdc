class MainClientListModel {
  bool? status;
  String? message;
  List<Data>? data;

  MainClientListModel({this.status, this.message, this.data});

  MainClientListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? clientName;
  String? phoneNumber;
  String? location;

  Data({this.id, this.clientName, this.phoneNumber, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['clientName'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientName'] = this.clientName;
    data['phoneNumber'] = this.phoneNumber;
    data['location'] = this.location;
    return data;
  }
}