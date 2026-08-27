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
  String? clientName;
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

  String? connectingChannelId;
  String? connectingStatusId;
  String? connectingReasonId;
  String? triedToReduceRejection;
  dynamic reduceRejectionMethodIds;
  String? reductionChallenges;
  String? rejectionToRelation;
  dynamic relationActionIds;
  String? relationChallenges;
  String? prospectQualified;
  dynamic prospectParameterIds;
  dynamic prospectParamValues;
  String? prospectPurpose;
  String? prospectPainPoint;
  String? prospectChallenges;
  String? productCustomization;
  dynamic customizationParameterIds;
  String? customizationChallenges;
  String? customerSummary;
  String? customerChallenges;
  String? customerRating;
  String? callStatusReasonId;
  Map<String, String>? callResultReasonMap;
  String? relationshipBuild;
  dynamic relationshipParameterIds;
  String? relationshipChallenges;

  Data({
    this.callDetailsId,
    this.callMasterId,
    this.clientName,
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
    this.connectingChannelId,
    this.connectingStatusId,
    this.connectingReasonId,
    this.triedToReduceRejection,
    this.reduceRejectionMethodIds,
    this.reductionChallenges,
    this.rejectionToRelation,
    this.relationActionIds,
    this.relationChallenges,
    this.prospectQualified,
    this.prospectParameterIds,
    this.prospectParamValues,
    this.prospectPurpose,
    this.prospectPainPoint,
    this.prospectChallenges,
    this.productCustomization,
    this.customizationParameterIds,
    this.customizationChallenges,
    this.customerSummary,
    this.customerChallenges,
    this.customerRating,
    this.callStatusReasonId,
    this.callResultReasonMap,
    this.relationshipBuild,
    this.relationshipParameterIds,
    this.relationshipChallenges,
  });

  static String? _normalizeYesNo(dynamic val) {
    if (val == null) return null;
    String str = val.toString().trim().toLowerCase();
    if (str == 'yes' || str == 'true') return 'Yes';
    if (str == 'no' || str == 'false') return 'No';
    return val.toString();
  }

  Data.fromJson(Map<String, dynamic> json) {
    callDetailsId = json['call_details_id']?.toString();
    callMasterId = json['call_master_id']?.toString();
    clientName = json['client_name']?.toString() ?? json['name']?.toString();
    cost = json['cost']?.toString();
    leadCategoryId = json['lead_category_id']?.toString();
    leadCategory = json['lead_category']?.toString();
    leadSubCategoryId = json['lead_sub_category_id']?.toString();
    leadSubCategory = json['lead_sub_category']?.toString();
    calledDate = json['called_date']?.toString();
    callResultId = json['call_result_id']?.toString();
    callResult = json['call_result']?.toString();
    followupDate = json['followup_date']?.toString();
    remarks = json['remarks']?.toString();
    address = json['address']?.toString();
    job = json['job']?.toString();
    location = json['location']?.toString();
    customerNeed = json['customer_need']?.toString();
    purpose = json['purpose']?.toString();
    challenges = json['challenges']?.toString();
    newObjection = json['new_objection']?.toString();
    googleReviewStatus = json['google_review_status']?.toString();
    reasonForLostSales = json['reason_for_lost_sales']?.toString();
    callResponse = json['call_response']?.toString();
    callResponseId = json['call_response_id']?.toString();
    connectingChannelId = (json['connecting_channel_id'] ?? json['connecting_channel'])?.toString();
    connectingStatusId = (json['connecting_status_id'] ?? json['connecting_status'])?.toString();
    connectingReasonId = (json['connecting_reason_id'] ?? json['connecting_reason'])?.toString();
    if (connectingReasonId == '0') connectingReasonId = null;

    triedToReduceRejection = _normalizeYesNo(json['tried_to_reduce_rejection'] ?? json['tried_to_reduce']);
    reduceRejectionMethodIds = json['reduce_rejection_method_ids'] ?? json['reduce_rejection_methods'];
    reductionChallenges = (json['reduction_challenges'] ?? json['reduce_rejection_challenges'])?.toString();

    rejectionToRelation = _normalizeYesNo(json['rejection_to_relation'] ?? json['rejection_to_relationship']);
    relationActionIds = json['relation_action_ids'] ?? json['rejection_relation_actions'];
    relationChallenges = (json['relation_challenges'] ?? json['rejection_relation_challenges'])?.toString();

    prospectQualified = _normalizeYesNo(json['prospect_qualified']);
    prospectParameterIds = json['prospect_parameter_ids'] ?? json['prospect_parameters'];
    prospectParamValues = json['prospect_param_values'];
    prospectPurpose = json['prospect_purpose']?.toString();
    prospectPainPoint = json['prospect_pain_point']?.toString();
    prospectChallenges = json['prospect_challenges']?.toString();

    productCustomization = _normalizeYesNo(json['product_customization']);
    customizationParameterIds = json['customization_parameter_ids'] ?? json['product_customization_parameters'];
    customizationChallenges = (json['customization_challenges'] ?? json['product_customization_challenges'])?.toString();

    relationshipBuild = _normalizeYesNo(json['relationship_build']);
    relationshipParameterIds = json['relationship_parameter_ids'] ?? json['relationship_parameters'];
    relationshipChallenges = (json['relationship_challenges'] ?? json['relationship_build_challenges'])?.toString();

    customerSummary = json['customer_summary']?.toString();
    customerChallenges = json['customer_challenges']?.toString();
    customerRating = json['customer_rating']?.toString();

    if (json['call_status_reason_id'] != null) {
      callStatusReasonId = json['call_status_reason_id'].toString();
    } else if (json['call_result_reason'] is Map) {
      callResultReasonMap = Map<String, String>.from(
        (json['call_result_reason'] as Map).map(
          (k, v) => MapEntry(k.toString(), v.toString()),
        ),
      );
      callStatusReasonId = callResultReasonMap!.keys.join(',');
    } else if (json['call_result_reason'] is String) {
      callStatusReasonId = json['call_result_reason'];
    }
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
    data['customer_summary'] = this.customerSummary;
    data['customer_challenges'] = this.customerChallenges;
    data['customer_rating'] = this.customerRating;
    return data;
  }
}
