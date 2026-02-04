class CallHistoryModel {
  Data? data;
  bool? status;
  String? message;

  CallHistoryModel({this.data, this.status, this.message});

  CallHistoryModel.fromJson(Map<String, dynamic> json) {
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
  bool? createLead;
  bool? viewLead;
  bool? updateLead;
  bool? deleteLead;
  bool? createLeadCategory;
  bool? viewLeadCategory;
  bool? updateLeadCategory;
  bool? deleteLeadCategory;
  bool? viewLeadReport;
  bool? viewWhatsappSettings;
  bool? updateWhatsappSettings;
  bool? createFacebookSettings;
  bool? updateFacebookSettings;
  bool? deleteFacebookSettings;
  bool? createLeadImports;
  bool? cloudCall;
  bool? accessCallHistory;
  bool? accessCallRecording;
  List<StaffList>? staffList;
  List<CallHistory>? callHistory;

  Data(
      {this.createLead,
        this.viewLead,
        this.updateLead,
        this.deleteLead,
        this.createLeadCategory,
        this.viewLeadCategory,
        this.updateLeadCategory,
        this.deleteLeadCategory,
        this.viewLeadReport,
        this.viewWhatsappSettings,
        this.updateWhatsappSettings,
        this.createFacebookSettings,
        this.updateFacebookSettings,
        this.deleteFacebookSettings,
        this.createLeadImports,
        this.cloudCall,
        this.accessCallHistory,
        this.accessCallRecording,
        this.staffList,
        this.callHistory});

  Data.fromJson(Map<String, dynamic> json) {
    createLead = json['create_lead'];
    viewLead = json['view_lead'];
    updateLead = json['update_lead'];
    deleteLead = json['delete_lead'];
    createLeadCategory = json['create_lead_category'];
    viewLeadCategory = json['view_lead_category'];
    updateLeadCategory = json['update_lead_category'];
    deleteLeadCategory = json['delete_lead_category'];
    viewLeadReport = json['view_lead_report'];
    viewWhatsappSettings = json['view_whatsapp_settings'];
    updateWhatsappSettings = json['update_whatsapp_settings'];
    createFacebookSettings = json['create_facebook_settings'];
    updateFacebookSettings = json['update_facebook_settings'];
    deleteFacebookSettings = json['delete_facebook_settings'];
    createLeadImports = json['create_lead_imports'];
    cloudCall = json['cloud_call'];
    accessCallHistory = json['access_call_history'];
    accessCallRecording = json['access_call_recording'];
    if (json['staff_list'] != null) {
      staffList = <StaffList>[];
      json['staff_list'].forEach((v) {
        staffList!.add(StaffList.fromJson(v));
      });
    }
    if (json['callHistory'] != null) {
      callHistory = <CallHistory>[];
      json['callHistory'].forEach((v) {
        callHistory!.add(CallHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create_lead'] = createLead;
    data['view_lead'] = viewLead;
    data['update_lead'] = updateLead;
    data['delete_lead'] = deleteLead;
    data['create_lead_category'] = createLeadCategory;
    data['view_lead_category'] = viewLeadCategory;
    data['update_lead_category'] = updateLeadCategory;
    data['delete_lead_category'] = deleteLeadCategory;
    data['view_lead_report'] = viewLeadReport;
    data['view_whatsapp_settings'] = viewWhatsappSettings;
    data['update_whatsapp_settings'] = updateWhatsappSettings;
    data['create_facebook_settings'] = createFacebookSettings;
    data['update_facebook_settings'] = updateFacebookSettings;
    data['delete_facebook_settings'] = deleteFacebookSettings;
    data['create_lead_imports'] = createLeadImports;
    data['cloud_call'] = cloudCall;
    data['access_call_history'] = accessCallHistory;
    data['access_call_recording'] = accessCallRecording;
    if (staffList != null) {
      data['staff_list'] = staffList!.map((v) => v.toJson()).toList();
    }
    if (callHistory != null) {
      data['callHistory'] = callHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffList {
  String? userId;
  String? staffName;

  StaffList({this.userId, this.staffName});

  StaffList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['staff_name'] = staffName;
    return data;
  }
}

class CallHistory {
  String? date;
  List<History>? history;

  CallHistory({this.date, this.history});

  CallHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String? leadCategory;
  String? clientName;
  String? callResult;
  String? callMasterId;
  String? calledTime;
  String? callHistoryImage;
  String? sourceNumber;
  String? destinationNumber;
  String? calledDate;
  String? time;
  String? startTime;
  String? endTime;
  int? callDuration;
  String? callDurationHr;
  String? resourceURL;
  String? status;
  bool? isAttended;
  String? direction;
  bool? isplayed;
  bool? audioplayed;
  int? currentpos;
  String? currentpostlabel;

  History(
      {this.leadCategory,
        this.clientName,
        this.callResult,
        this.callMasterId,
        this.calledTime,
        this.callHistoryImage,
        this.sourceNumber,
        this.destinationNumber,
        this.calledDate,
        this.time,
        this.startTime,
        this.endTime,
        this.callDuration,
        this.callDurationHr,
        this.resourceURL,
        this.status,
        this.isAttended,
        this.direction,
        this.isplayed,
        this.audioplayed,
        this.currentpos,
        this.currentpostlabel});

  History.fromJson(Map<String, dynamic> json) {
    leadCategory = json['lead_category'];
    clientName = json['client_name'];
    callResult = json['call_result'];
    callMasterId = json['call_master_id'];
    calledTime = json['calledTime'];
    callHistoryImage = json['callHistoryImage'];
    sourceNumber = json['SourceNumber'];
    destinationNumber = json['DestinationNumber'];
    calledDate = json['called_date'];
    time = json['time'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    callDuration = json['CallDuration'];
    callDurationHr = json['CallDurationHr'];
    resourceURL = json['ResourceURL'];
    status = json['Status'];
    isAttended = json['isAttended'];
    direction = json['Direction'];
    isplayed = json['isplayed'];
    audioplayed = json['audioplayed'];
    currentpos = json['currentpos'];
    currentpostlabel = json['currentpostlabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_category'] = leadCategory;
    data['client_name'] = clientName;
    data['call_result'] = callResult;
    data['call_master_id'] = callMasterId;
    data['calledTime'] = calledTime;
    data['callHistoryImage'] = callHistoryImage;
    data['SourceNumber'] = sourceNumber;
    data['DestinationNumber'] = destinationNumber;
    data['called_date'] = calledDate;
    data['time'] = time;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['CallDuration'] = callDuration;
    data['CallDurationHr'] = callDurationHr;
    data['ResourceURL'] = resourceURL;
    data['Status'] = status;
    data['isAttended'] = isAttended;
    data['Direction'] = direction;
    data['isplayed'] = isplayed;
    data['audioplayed'] = audioplayed;
    data['currentpos'] = currentpos;
    data['currentpostlabel'] = currentpostlabel;
    return data;
  }
}