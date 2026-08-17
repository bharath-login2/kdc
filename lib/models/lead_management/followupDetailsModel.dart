class FollowupDetailsModel {
  bool? status;
  String? message;
  Data? data;

  FollowupDetailsModel({this.status, this.message, this.data});

  FollowupDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? callDetailsId;
  String? callMasterId;
  String? cost;
  String? leadCategoryId;
  String? leadCategory;
  String? leadSubCategoryId;
  String? leadSubCategory;
  String? calledDate;
  String? callResultId;
  String? callResult;
  String? followupDate;
  String? remarks;
    String? address;
  String? job;
  String? location;
  String? customerNeed;
  String? purpose;
  String? challenges;
  String? newObjection;
  String? googleReviewStatus;
  String? reasonForLostSales;
   String? callResponse;
    String? callResponseId;

  Data({
    this.callDetailsId,
    this.callMasterId,
    this.cost,
    this.leadCategoryId,
    this.leadCategory,
    this.leadSubCategoryId,
    this.leadSubCategory,
    this.calledDate,
    this.callResultId,
    this.callResult,
    this.followupDate,
    this.remarks,
     this.address,
    this.job,
    this.location,
    this.customerNeed,
    this.purpose,
    this.challenges,
    this.newObjection,
    this.googleReviewStatus,
    this.reasonForLostSales,
    this.callResponse,
    this.callResponseId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    callDetailsId = json['call_details_id'];
    callMasterId = json['call_master_id'];
    cost = json['cost'];
    leadCategoryId = json['lead_category_id'];
    leadCategory = json['lead_category'];
    leadSubCategoryId = json['lead_sub_category_id'];
    leadSubCategory = json['lead_sub_category'];
    calledDate = json['called_date'];
    callResultId = json['call_result_id'];
    callResult = json['call_result'];
    followupDate = json['followup_date'];
    remarks = json['remarks'];
     address = json['address'];
    job = json['job'];
    location = json['location'];
    customerNeed = json['customer_need'];
    purpose = json['purpose'];
    challenges = json['challenges'];
    newObjection = json['new_objection'];
    googleReviewStatus = json['google_review_status'];
    reasonForLostSales = json['reason_for_lost_sales'];
    callResponse = json['call_response'];
    callResponseId = json['call_response_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['call_details_id'] = this.callDetailsId;
    data['call_master_id'] = this.callMasterId;
    data['cost'] = this.cost;
    data['lead_category_id'] = this.leadCategoryId;
    data['lead_category'] = this.leadCategory;
    data['lead_sub_category_id'] = this.leadSubCategoryId;
    data['lead_sub_category'] = this.leadSubCategory;
    data['called_date'] = this.calledDate;
    data['call_result_id'] = this.callResultId;
    data['call_result'] = this.callResult;
    data['followup_date'] = this.followupDate;
    data['remarks'] = this.remarks;
      data['address'] = this.address;
    data['job'] = this.job;
    data['location'] = this.location;
    data['customer_need'] = this.customerNeed;
    data['purpose'] = this.purpose;
    data['challenges'] = this.challenges;
    data['new_objection'] = this.newObjection;
    data['google_review_status'] = this.googleReviewStatus;
    data['reason_for_lost_sales'] = this.reasonForLostSales;
    data['call_response'] = this.callResponse;
    data['call_response_id'] = this.callResponseId;
    return data;
  }
}
