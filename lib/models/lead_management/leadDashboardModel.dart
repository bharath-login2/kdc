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
  String? totalStaffLeads;
  int? unreadNotification;

  Data(
      {this.newLeads,
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
        this.totalStaffLeads,
        this.unreadNotification});

  Data.fromJson(Map<String, dynamic> json) {
    newLeads = json['newLeads'];
    followupLeads = json['followupLeads'];
    closedLeads = json['closedLeads'];
    totalCalled = json['totalCalled'];
    missedLeads = json['missedLeads'];
    transferLeads = json['transferLeads'];
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
    totalStaffLeads = json['total_staff_leads'];
    unreadNotification = json['unread_notification'];
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
    return data;
  }
}