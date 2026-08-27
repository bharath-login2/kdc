class LeadDashboardModel {
  Data? data;
  bool? status;
  String? message;

  LeadDashboardModel({this.data, this.status, this.message});

  LeadDashboardModel.fromJson(Map<String, dynamic> json) {
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
  int? newLeads;
  int? followupLeads;
  int? closedLeads;
  int? totalCalled;
  int? missedLeads;
  int? transferLeads;
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
  bool? fileManager;
  bool? phoneCallLog;
  String? callTarget;
  String? callAchieved;
  String? targetPoints;
  String? achievedPoints;
  String? pendingCalls;
  String? pendingPoints;
  String? totalStaffLeads;
  int? unreadNotification;

  int? dayCallCount;
  int? connectedCount;
  int? pendingCount;
  int? totalProspectCount;
  int? achievedCount;
  int? saleClosedCount;
  int? relationshipBuildCount;
  int? todayProspectCount;
  int? todayCreatedCount;
  int? todayNewCalledCount;
  int? reassignedCount;
  int? reassignedCalledCount;
  int? prospectTodayCount;
  int? prospectTodayCalledCount;
  int? followupTodayCount;
  int? followupTodayCalledCount;
  int? demandTorecallTodayCount;
  int? demandTorecallCalledTodayCount;
  int? aboveOneMinCount;

  Data({
    this.newLeads,
    this.followupLeads,
    this.closedLeads,
    this.totalCalled,
    this.missedLeads,
    this.transferLeads,
    this.createLead,
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
    this.fileManager,
    this.phoneCallLog,
    this.callTarget,
    this.callAchieved,
    this.targetPoints,
    this.achievedPoints,
    this.pendingCalls,
    this.pendingPoints,
    this.totalStaffLeads,
    this.unreadNotification,
    this.dayCallCount,
    this.connectedCount,
    this.pendingCount,
    this.totalProspectCount,
    this.achievedCount,
    this.saleClosedCount,
    this.relationshipBuildCount,
    this.todayProspectCount,
    this.todayCreatedCount,
    this.todayNewCalledCount,
    this.reassignedCount,
    this.reassignedCalledCount,
    this.prospectTodayCount,
    this.prospectTodayCalledCount,
    this.followupTodayCount,
    this.followupTodayCalledCount,
    this.demandTorecallTodayCount,
    this.demandTorecallCalledTodayCount,
    this.aboveOneMinCount,
  });

  static int? _parseInt(dynamic val) {
    if (val == null) return null;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString());
  }

  Data.fromJson(Map<String, dynamic> json) {
    newLeads = _parseInt(json['newLeads']);
    followupLeads = _parseInt(json['followupLeads']);
    closedLeads = _parseInt(json['closedLeads']);
    totalCalled = _parseInt(json['totalCalled']);
    missedLeads = _parseInt(json['missedLeads']);
    transferLeads = _parseInt(json['transferLeads']);
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
    fileManager = json['file_manager'];
    phoneCallLog = json['phone_call_log'];
    callTarget = json['call_target']?.toString();
    callAchieved = json['call_achieved']?.toString();
    targetPoints = json['target_point']?.toString();
    achievedPoints = json['achieved_points']?.toString();
    pendingCalls = json['pending_calls']?.toString();
    pendingPoints = json['pending_points']?.toString();
    totalStaffLeads = json['total_staff_leads']?.toString();
    unreadNotification = _parseInt(json['unread_notification']);

    dayCallCount = _parseInt(json['dayCallCount']);
    connectedCount = _parseInt(json['connectedCount']);
    pendingCount = _parseInt(json['pendingCount']);
    totalProspectCount = _parseInt(json['totalProspectCount']);
    achievedCount = _parseInt(json['achievedCount']);
    saleClosedCount = _parseInt(json['saleClosedCount']);
    relationshipBuildCount = _parseInt(json['relationshipBuildCount']);
    todayProspectCount = _parseInt(json['todayProspectCount']);
    todayCreatedCount = _parseInt(json['todayCreatedCount']);
    todayNewCalledCount = _parseInt(json['todayNewCalledCount']);
    reassignedCount = _parseInt(json['reassignedCount']);
    reassignedCalledCount = _parseInt(json['reassignedCalledCount']);
    prospectTodayCount = _parseInt(json['prospectTodayCount']);
    prospectTodayCalledCount = _parseInt(json['prospectTodayCalledCount']);
    followupTodayCount = _parseInt(json['followupTodayCount']);
    followupTodayCalledCount = _parseInt(json['followupTodayCalledCount']);
    demandTorecallTodayCount = _parseInt(json['demandTorecallTodayCount']);
    demandTorecallCalledTodayCount = _parseInt(json['demandTorecallCalledTodayCount']);
    aboveOneMinCount = _parseInt(json['aboveOneMinCount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newLeads'] = newLeads;
    data['followupLeads'] = followupLeads;
    data['closedLeads'] = closedLeads;
    data['totalCalled'] = totalCalled;
    data['missedLeads'] = missedLeads;
    data['transferLeads'] = transferLeads;
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
    data['file_manager'] = fileManager;
    data['phone_call_log'] = phoneCallLog;
    data['total_staff_leads'] = totalStaffLeads;
    data['unread_notification'] = unreadNotification;

    data['dayCallCount'] = dayCallCount;
    data['connectedCount'] = connectedCount;
    data['pendingCount'] = pendingCount;
    data['totalProspectCount'] = totalProspectCount;
    data['achievedCount'] = achievedCount;
    data['saleClosedCount'] = saleClosedCount;
    data['relationshipBuildCount'] = relationshipBuildCount;
    data['todayProspectCount'] = todayProspectCount;
    data['todayCreatedCount'] = todayCreatedCount;
    data['todayNewCalledCount'] = todayNewCalledCount;
    data['reassignedCount'] = reassignedCount;
    data['reassignedCalledCount'] = reassignedCalledCount;
    data['prospectTodayCount'] = prospectTodayCount;
    data['prospectTodayCalledCount'] = prospectTodayCalledCount;
    data['followupTodayCount'] = followupTodayCount;
    data['followupTodayCalledCount'] = followupTodayCalledCount;
    data['demandTorecallTodayCount'] = demandTorecallTodayCount;
    data['demandTorecallCalledTodayCount'] = demandTorecallCalledTodayCount;
    data['aboveOneMinCount'] = aboveOneMinCount;

    return data;
  }
}
