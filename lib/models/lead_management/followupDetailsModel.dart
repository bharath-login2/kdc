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

  Data(
      {this.callDetailsId,
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
        this.remarks});

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
    return data;
  }
}