class LeadDeatailsModel {
  Data? data;
  bool? status;
  String? message;

  LeadDeatailsModel({this.data, this.status, this.message});

  LeadDeatailsModel.fromJson(Map<String, dynamic> json) {
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
  String? callMasterId;
  String? leadCategoryId;
  String? leadSubCategoryId;
  String? clientName;
  String? address;
  String? cost;
  String? assignedUserId;
  String? callResultId;
  String? calledDate;
  String? createdDate;
  String? nextFollowupDate;
  String? remarks;
  String? leadMethod;
  String? leadCategory;
  String? leadSubCategory;
  String? callResult;
  String? staffName;
  String? priorityId;
  String? priority;
  String? countryCode;
  String? contactNumber1;
  String? branchId;
  bool? callHistoryPermission;
  bool? fileManagerPermission;
  List<LeadCategories>? leadCategories;
  String? job;
  String? location;
  String? customerNeed;
  String? purpose;
  String? challenges;
  String? newObjection;
  String? googleReviewStatus;
  String? reasonForLostSales;

  Data({
    this.callMasterId,
    this.leadCategoryId,
    this.leadSubCategoryId,
    this.clientName,
    this.address,
    this.cost,
    this.assignedUserId,
    this.callResultId,
    this.calledDate,
    this.createdDate,
    this.nextFollowupDate,
    this.remarks,
    this.leadMethod,
    this.leadCategory,
    this.leadSubCategory,
    this.callResult,
    this.staffName,
    this.priorityId,
    this.priority,
    this.countryCode,
    this.contactNumber1,
    this.branchId,
    this.callHistoryPermission,
    this.fileManagerPermission,
    this.leadCategories,
    this.job,
    this.location,
    this.customerNeed,
    this.purpose,
    this.challenges,
    this.newObjection,
    this.googleReviewStatus,
    this.reasonForLostSales,
  });

  Data.fromJson(Map<String, dynamic> json) {
    callMasterId = json['call_master_id'];
    leadCategoryId = json['lead_category_id'];
    leadSubCategoryId = json['lead_sub_category_id'];
    clientName = json['client_name'];
    address = json['address'];
    cost = json['cost'];
    assignedUserId = json['assigned_user_id'];
    callResultId = json['call_result_id'];
    calledDate = json['called_date'];
    createdDate = json['created_date'];
    nextFollowupDate = json['next_followup_date'];
    remarks = json['remarks'];
    leadMethod = json['lead_method'];
    leadCategory = json['lead_category'];
    leadSubCategory = json['lead_sub_category'];
    callResult = json['call_result'];
    staffName = json['staff_name'];
    priorityId = json['priority_id'];
    priority = json['priority'];
    countryCode = json['country_code'];
    contactNumber1 = json['contact_number1'];
    branchId = json['branch_id'];
    callHistoryPermission = json['callHistoryPermission'];
    fileManagerPermission = json['fileManagerPermission'];
    if (json['leadCategories'] != null) {
      leadCategories = <LeadCategories>[];
      json['leadCategories'].forEach((v) {
        leadCategories!.add(LeadCategories.fromJson(v));
      });
    }
    job = json['job'];
    location = json['location'];
    customerNeed = json['customer_need'];
    purpose = json['purpose'];
    challenges = json['challenges'];
    newObjection = json['new_objection'];
    googleReviewStatus = json['google_review_status'];
    reasonForLostSales = json['reason_for_lost_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_master_id'] = callMasterId;
    data['lead_category_id'] = leadCategoryId;
    data['lead_sub_category_id'] = leadSubCategoryId;
    data['client_name'] = clientName;
    data['address'] = address;
    data['cost'] = cost;
    data['assigned_user_id'] = assignedUserId;
    data['call_result_id'] = callResultId;
    data['called_date'] = calledDate;
    data['created_date'] = createdDate;
    data['next_followup_date'] = nextFollowupDate;
    data['remarks'] = remarks;
    data['lead_method'] = leadMethod;
    data['lead_category'] = leadCategory;
    data['lead_sub_category'] = leadSubCategory;
    data['call_result'] = callResult;
    data['staff_name'] = staffName;
    data['priority_id'] = priorityId;
    data['priority'] = priority;
    data['country_code'] = countryCode;
    data['contact_number1'] = contactNumber1;
    data['branch_id'] = branchId;
    data['callHistoryPermission'] = callHistoryPermission;
    data['fileManagerPermission'] = fileManagerPermission;
    if (leadCategories != null) {
      data['leadCategories'] = leadCategories!.map((v) => v.toJson()).toList();
    }
    data['job'] = job;
    data['location'] = location;
    data['customer_need'] = customerNeed;
    data['purpose'] = purpose;
    data['challenges'] = challenges;
    data['new_objection'] = newObjection;
    data['google_review_status'] = googleReviewStatus;
    data['reason_for_lost_sales'] = reasonForLostSales;
    return data;
  }
}

class LeadCategories {
  String? callMasterId;
  String? leadCategoryId;
  String? leadCategory;
  String? leadSubCategory;
   String? createdDate;
  String? leadStatus;
  String? staffName;
  bool? isSelected;

  LeadCategories({
  this.callMasterId,
      this.leadCategoryId,
      this.leadCategory,
      this.leadSubCategory,
        this.createdDate,
        this.leadStatus,
        this.staffName,
      this.isSelected
  });

  LeadCategories.fromJson(Map<String, dynamic> json) {
  callMasterId = json['call_master_id'];
    leadCategoryId = json['lead_category_id'];
    leadCategory = json['lead_category'];
    leadSubCategory = json['lead_sub_category'];
      createdDate = json['created_date'];
     leadStatus = json['lead_status'];
       staffName = json['staff_name'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_master_id'] = callMasterId;
    data['lead_category_id'] = leadCategoryId;
    data['lead_category'] = leadCategory;
    data['lead_sub_category'] = leadSubCategory;
        data['created_date'] = createdDate;
    data['lead_status'] = leadStatus;
    data['staff_name'] = staffName;
    data['is_selected'] = isSelected;
    return data;
  }
}
