class SearchModel {
  Data? data;
  bool? status;
  String? message;

  SearchModel({this.data, this.status, this.message});

  SearchModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Details>? details;
  int? totalLeads;

  Data({this.details, this.totalLeads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    totalLeads = json['totalLeads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['totalLeads'] = totalLeads;
    return data;
  }
}

class Details {
  String? callMasterId;
  String? calledDate;
  int? callResultId;
  String? callStatusId;
  String? scheduledDate;
  String? clientName;
  String? contactNumber1;
  String? callResult;
  String? proPicThumb;
  String? staffName;
  String? leadCategory;
  String? priority;
  String? profilePic;
  bool? isCalled;

  Details(
      {this.callMasterId,
        this.calledDate,
        this.callResultId,
        this.callStatusId,
        this.scheduledDate,
        this.clientName,
        this.contactNumber1,
        this.callResult,
        this.proPicThumb,
        this.staffName,
        this.leadCategory,
        this.priority,
        this.profilePic,
        this.isCalled});

  Details.fromJson(Map<String, dynamic> json) {
    callMasterId = json['call_master_id'];
    calledDate = json['called_date'];
    callResultId = json['call_result_id'];
    callStatusId = json['call_status_id'];
    scheduledDate = json['scheduled_date'];
    clientName = json['client_name'];
    contactNumber1 = json['contact_number1'];
    callResult = json['call_result'];
    proPicThumb = json['pro_pic_thumb'];
    staffName = json['staff_name'];
    leadCategory = json['lead_category'];
    priority = json['priority'];
    profilePic = json['profile_pic'];
    isCalled = json['is_called'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_master_id'] = callMasterId;
    data['called_date'] = calledDate;
    data['call_result_id'] = callResultId;
    data['call_status_id'] = callStatusId;
    data['scheduled_date'] = scheduledDate;
    data['client_name'] = clientName;
    data['contact_number1'] = contactNumber1;
    data['call_result'] = callResult;
    data['pro_pic_thumb'] = proPicThumb;
    data['staff_name'] = staffName;
    data['lead_category'] = leadCategory;
    data['priority'] = priority;
    data['profile_pic'] = profilePic;
    data['is_called'] = isCalled;
    return data;
  }
}