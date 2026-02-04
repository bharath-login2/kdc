class ViewLeadsModel {
  Data? data;
  bool? status;
  String? message;

  ViewLeadsModel({this.data, this.status, this.message});

  ViewLeadsModel.fromJson(Map<String, dynamic> json) {
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
  List<Details>? details;
  int? totalLeads;
  String? fromdate;
  String? todate;

  Data({this.details, this.totalLeads, this.fromdate, this.todate});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    totalLeads = json['totalLeads'];
    fromdate = json['fromdate'];
    todate = json['todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['totalLeads'] = totalLeads;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    return data;
  }
}

class Details {
  String? callDetailsId;
  String? callMasterId;
  String? calledDate;
  String? createdDate;
  String? lastCalledDate;
  int? callResultId;
  String? callStatusId;
  bool? isNewCall;
  String? followupDate;
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
  bool? isSelected;

  Details(
      {this.callDetailsId,
        this.callMasterId,
        this.calledDate,
        this.createdDate,
        this.lastCalledDate,
        this.callResultId,
        this.callStatusId,
        this.isNewCall,
        this.followupDate,
        this.scheduledDate,
        this.clientName,
        this.contactNumber1,
        this.callResult,
        this.proPicThumb,
        this.staffName,
        this.leadCategory,
        this.priority,
        this.profilePic,
        this.isCalled,
        this.isSelected});

  Details.fromJson(Map<String, dynamic> json) {
    callDetailsId = json['call_details_id'];
    callMasterId = json['call_master_id'];
    calledDate = json['called_date'];
    createdDate = json['created_date'];
    lastCalledDate = json['last_called_date'];
    callResultId = json['call_result_id'];
    callStatusId = json['call_status_id'];
    isNewCall = json['is_new_call'];
    followupDate = json['followup_date'];
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
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_details_id'] = callDetailsId;
    data['call_master_id'] = callMasterId;
    data['called_date'] = calledDate;
    data['created_date'] = createdDate;
    data['last_called_date'] = lastCalledDate;
    data['call_result_id'] = callResultId;
    data['call_status_id'] = callStatusId;
    data['is_new_call'] = isNewCall;
    data['followup_date'] = followupDate;
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
    data['is_selected'] = isSelected;
    return data;
  }
}