class ViewLeadsModel {
  Data? data;
  bool? status;
  String? message;

  ViewLeadsModel({this.data, this.status, this.message});

  ViewLeadsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'] is bool
        ? json['status']
        : (json['status']?.toString().toLowerCase() == 'true');
    message = json['message']?.toString();
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
  String? fromdate;
  String? todate;
  bool? callPermission;
  String? warningMessage;
  String? callLeadId;
  bool? leadDeletePermission;

  Data({
    this.details,
    this.totalLeads,
    this.fromdate,
    this.todate,
    this.callPermission,
    this.warningMessage,
    this.callLeadId,
    this.leadDeletePermission,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null && json['details'] is List) {
      details = <Details>[];
      json['details'].forEach((v) {
        if (v != null) {
          details!.add(Details.fromJson(v));
        }
      });
    }
    totalLeads = json['totalLeads'] != null
        ? int.tryParse(json['totalLeads'].toString())
        : null;
    fromdate = json['fromdate']?.toString();
    todate = json['todate']?.toString();
    callPermission = json['callPermission'] is bool
        ? json['callPermission']
        : (json['callPermission']?.toString().toLowerCase() == 'true');
    warningMessage = json['warningMessage']?.toString();
    callLeadId = json['callLeadId']?.toString();
    leadDeletePermission = json['leadDeletePermission'] is bool
        ? json['leadDeletePermission']
        : (json['leadDeletePermission']?.toString().toLowerCase() == 'true');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['totalLeads'] = totalLeads;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['callPermission'] = callPermission;
    data['warningMessage'] = warningMessage;
    data['callLeadId'] = callLeadId;
    data['leadDeletePermission'] = leadDeletePermission;
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

  Details({
    this.callDetailsId,
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
    this.isSelected,
  });

  Details.fromJson(Map<String, dynamic> json) {
    callDetailsId = json['call_details_id']?.toString();
    callMasterId = json['call_master_id']?.toString();
    calledDate = json['called_date']?.toString();
    createdDate = json['created_date']?.toString();
    lastCalledDate = json['last_called_date']?.toString();
    callResultId = json['call_result_id'] != null
        ? int.tryParse(json['call_result_id'].toString())
        : null;
    callStatusId = json['call_status_id']?.toString();
    isNewCall = json['is_new_call'] is bool
        ? json['is_new_call']
        : (json['is_new_call']?.toString().toLowerCase() == 'true' ||
            json['is_new_call']?.toString() == '1');
    followupDate = json['followup_date']?.toString();
    scheduledDate = json['scheduled_date']?.toString();
    clientName = json['client_name']?.toString();
    contactNumber1 = json['contact_number1']?.toString();
    callResult = json['call_result']?.toString();
    proPicThumb = json['pro_pic_thumb']?.toString();
    staffName = json['staff_name']?.toString();
    leadCategory = json['lead_category']?.toString();
    priority = json['priority']?.toString();
    profilePic = json['profile_pic']?.toString();
    isCalled = json['is_called'] is bool
        ? json['is_called']
        : (json['is_called']?.toString().toLowerCase() == 'true' ||
            json['is_called']?.toString() == '1');
    isSelected = json['is_selected'] is bool
        ? json['is_selected']
        : (json['is_selected']?.toString().toLowerCase() == 'true' ||
            json['is_selected']?.toString() == '1');
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
