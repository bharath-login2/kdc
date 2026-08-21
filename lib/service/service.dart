import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:kdc_chitty_mainnew/models/clients/deleteMainClientModel.dart';
import 'package:kdc_chitty_mainnew/models/clients/receiptDeleteModel.dart';
import 'package:kdc_chitty_mainnew/models/lead_management/addMileStoneModel.dart';
import 'package:kdc_chitty_mainnew/models/lead_management/callResultReasonModel.dart';
import 'package:kdc_chitty_mainnew/models/lead_management/fileManagerPermissionModel.dart';
import 'package:kdc_chitty_mainnew/models/userManagement/editUserBasicDetailsModel.dart';
import '../../models/commonConfigureModel.dart';
import '../../models/commonsettingsModel.dart';
import '../../models/contactGroup/addContactGroupModel.dart';
import '../../models/contactGroup/addContactNumberModel.dart';
import '../../models/contactGroup/contactFGroupModel.dart';
import '../../models/contactGroup/contactGroupDeatailsModel.dart';
import '../../models/contactGroup/deleteContactNumberModel.dart';
import '../../models/contactGroup/deleteContatGroupModel.dart';
import '../../models/contactGroup/editContactGroupModel.dart';
import '../../models/contactGroup/editContactNumberModel.dart';
import '../../models/contactGroup/groupInfoModel.dart';
import '../../models/contactGroup/sendMessageModel.dart';
import '../../models/dashboardModel.dart';
import '../../models/lead_management/addLeadCategoryModel.dart';
import '../../models/lead_management/addLeadCommonDataModel.dart';
import '../../models/lead_management/addLeadFollowupModel.dart';
import '../../models/lead_management/addLeadModel.dart';
import '../../models/lead_management/callHistoryModel.dart';
import '../../models/lead_management/cloudCallModel.dart';
import '../../models/lead_management/deleteLeadFollowupModel.dart';
import '../../models/lead_management/deleteLeadModel.dart';
import '../../models/lead_management/editDesignationDetailsModel.dart';
import '../../models/lead_management/editLeadCategoryModel.dart';
import '../../models/lead_management/editLeadFollowupModel.dart';
import '../../models/lead_management/editLeadModel.dart';
import '../../models/lead_management/followupDetailsModel.dart';
import '../../models/lead_management/leadCategoryDeleteModel.dart';
import '../../models/lead_management/leadDashboardModel.dart';
import '../../models/lead_management/leadDeatailsModel.dart';
import '../../models/lead_management/leadProgressbarModel.dart';
import '../../models/lead_management/leadTransferModel.dart';
import '../../models/lead_management/searchModel.dart';
import '../../models/lead_management/viewLeadCategoryModel.dart';
import '../../models/lead_management/viewLeadsModel.dart';
import '../../models/lead_management/connectingChannelModel.dart';
import '../../models/lead_management/connectingStatusModel.dart';
import '../../models/lead_management/connectingReasonsModel.dart';
import '../../models/lead_management/reduceRejectionMethodModel.dart';
import '../../models/lead_management/rejectionRelationActionModel.dart';
import '../../models/lead_management/prospectParametersModel.dart';
import '../../models/lead_management/productCustomizationParameterModel.dart';
import '../../models/lead_management/relationshipParametersModel.dart';
import '../../models/loginCheckModel.dart';
import '../../models/loginModel.dart';
import '../../models/sendOtpModel.dart';
import '../../models/settings/addWhatsappSettingsModel.dart';
import '../../models/settings/addWhatsappSettingsOffModel.dart';
import '../../models/settings/whatsappSettings%20MOdel.dart';
import '../../models/updateModel.dart';
import '../../models/userChangePassword.dart';
import '../../models/userManagement/addUserCommonDataModel.dart';
import '../../models/userManagement/addUserImageModel.dart';
import '../../models/userManagement/addUserModel.dart';
import '../../models/userManagement/changePasswordModel.dart';
import '../../models/userManagement/deleteStaffModel.dart';
import '../../models/userManagement/designationListModel.dart';
import '../../models/userManagement/menuModel.dart';
import '../../models/userManagement/postEditSubmenuModel.dart';
import '../../models/userManagement/postSubmenuModel.dart';
import '../../models/userManagement/viewStaffModel.dart';
import 'package:dio/dio.dart';
import '../models/callLogs/callLogHistoryModel.dart';
import '../models/callLogs/callLogUploadModel.dart';
import '../models/callLogs/deleteCallHistoryModel.dart';
import '../models/clients/addClientsModel.dart';
import '../models/clients/addInvoiceModel.dart';
import '../models/clients/branchListModel.dart';
import '../models/clients/customerListModel.dart';
import '../models/clients/deleteInvoiceModel.dart';
import '../models/clients/editClientDetailsModel.dart';
import '../models/clients/editClientsModel.dart';
import '../models/clients/editReceiptDetailsModel.dart';
import '../models/clients/editReceiptModel.dart';
import '../models/clients/invoiceListModel.dart';
import '../models/clients/ivoiceAddCommonDetailsModel.dart';
import '../models/clients/leadConvertToClientModel.dart';
import '../models/clients/mainClientDetailsModel.dart';
import '../models/clients/mainClientListModel.dart';
import '../models/clients/postalCodeModel.dart';
import '../models/clients/receiptAddCommonDetailsModel.dart';
import '../models/clients/receiptAddModel.dart';
import '../models/clients/receiptListModel.dart';
import '../models/fileManager/deleteFileModel.dart';
import '../models/fileManager/fileMagerMOdel.dart';
import '../models/fileManager/mainFileManagerPermissionModel.dart';
import '../models/fileManager/renameFileModel.dart';
import '../models/lead_management/BulkTransferLeadModel.dart';
import '../models/lead_management/addBulkContactGroupModel.dart';
import '../models/lead_management/addLeadSubCategoryModel.dart';
import '../models/lead_management/bulkDeleteLeadModel.dart';
import '../models/lead_management/checkLeadPhoneNumberModel.dart';
import '../models/lead_management/createFolderModel.dart';
import '../models/lead_management/deleteFolderAndFileModel.dart';
import '../models/lead_management/deleteLeadMileStoneModel.dart';
import '../models/lead_management/editLeadSubCategoryModel.dart';
import '../models/lead_management/leadCategoryStaffWiseModel.dart';
import '../models/lead_management/leadDeatailsModelAdd.dart';
import '../models/lead_management/leadMileStoneListModel.dart';
import '../models/lead_management/leadNotificationListModel.dart';
import '../models/lead_management/leadSubCategoryDeleteModel.dart';
import '../models/lead_management/leadSubTypeModel.dart';
import '../models/lead_management/listFolderName.dart';
import '../models/lead_management/readLeadNotificationModel.dart';
import '../models/lead_management/renameFolderModel.dart';
import '../models/lead_management/testListApiModel.dart';
import '../models/lead_management/unsetReminderModel.dart';
import '../models/lead_management/updateReminderSetings.dart';
import '../models/lead_management/uploadAudioRecoed.dart';
import '../models/lead_management/viewLeadSubCategoryModel.dart';
import '../models/removeUserModel.dart';
import '../models/resetPasswordModel.dart';
import '../models/settings/deleteFbLeadsModel.dart';
import '../models/settings/facebookSettingsModel.dart';
import '../models/settings/sendNotificationModel.dart';
import '../models/settings/updateFbLeadAssignStaff.dart';
import '../models/userManagement/deleteDesignationModel.dart';
import '../models/userManagement/postEditStaffPermissionModel.dart';
import '../models/userManagement/postEditStaffSubmenuModel.dart';
import '../models/userManagement/staffDetailsModel.dart';
import '../models/verifyPhoneModel.dart';

class HttpService {
  static final Dio _dio = Dio();

  // static String get baseUrl => Platform.isIOS
  //     ? "https://account.login2.in/index.php/Mobile_app_api_ios_v1/"
  //     : "https://account.login2.in/index.php/Mobile_app_api_v1/";

  static String get baseUrl => Platform.isIOS
      ? "https://account.login2.in/index.php/Mobile_app_api_ios_v3/"
      : "https://kdc.login2.in/index.php/Mobile_app_api_v1/";

  static Future configure(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}check_package_expired",
        queryParameters: params,
      );
      if (kDebugMode) {
        print(result);
      }
      CommonConfigureModel model = CommonConfigureModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future forceUpdate() async {
    try {
      var result = await _dio.get("${baseUrl}force_updation_data");
      if (kDebugMode) {
        print(result);
      }
      UpdateModel model = UpdateModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future commonSettings() async {
    try {
      var result = await _dio.get("${baseUrl}contact_us");
      CommonSettingsModel model = CommonSettingsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future login(username, pass, firebaseToken) async {
    var params = {
      "phoneNumber": username,
      "password": pass,
      "firebaseId": firebaseToken,
    };
    try {
      var result = await _dio.get("${baseUrl}login", queryParameters: params);
      LoginModel model = LoginModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future loginCheck(token, firebaseToken) async {
    var params = {"token": token, "firebaseId": firebaseToken};
    try {
      var result = await _dio.get(
        "${baseUrl}if_token_expired",
        queryParameters: params,
      );
      LoginCheckModel model = LoginCheckModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future sendOtp(phoneNumber, otp) async {
    var params = {"phoneNumber": phoneNumber, "otp": otp};
    try {
      var result = await _dio.get(
        "${baseUrl}send_otp",
        queryParameters: params,
      );
      SendOtpModel model = SendOtpModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  /* Lead Management  Starts Here..*/
  static Future leadDashboard(
    token,
    fromDate,
    toDate,
    fromDate1,
    toDate1,
  ) async {
    var params = {
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "fromDate1": fromDate1,
      "toDate1": toDate1,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}lead_dashboard",
        queryParameters: params,
      );
      LeadDashboardModel model = LeadDashboardModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadDashboard1(
    token,
    fromDate,
    toDate,
    fromDate1,
    toDate1,
  ) async {
    var params = {
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "fromDate1": fromDate1,
      "toDate1": toDate1,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}lead_category_staff_wise",
        queryParameters: params,
      );
      LeadCategoryStaffWiseModel model = LeadCategoryStaffWiseModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadDashboardStaff(
    token,
    fromDate,
    toDate,
    fromDate1,
    toDate1,
    staffId,
  ) async {
    var params = {
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "fromDate1": fromDate1,
      "toDate1": toDate1,
      "staffId": staffId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}staff_dashboard",
        queryParameters: params,
      );
      LeadDashboardModel model = LeadDashboardModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadDashboard1Staff(
    token,
    fromDate,
    toDate,
    fromDate1,
    toDate1,
    staffId,
  ) async {
    var params = {
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "fromDate1": fromDate1,
      "toDate1": toDate1,
      "staffId": staffId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}staff_lead_category_wise",
        queryParameters: params,
      );
      LeadCategoryStaffWiseModel model = LeadCategoryStaffWiseModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future allViewLeads(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}view_total_lead_report",
        data: jsonEncode(body),
      );
      ViewLeadsModel model = ViewLeadsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future viewLeads(
    token,
    fromdate,
    todate,
    category,
    status,
    staff,
    isCalled,
    priority,
    sort,
    page,
    pageSize,
    isFirst,
    leadType,
    branchId, {
    String? search,
  }) async {
    var params = {
      "token": token,
      "fromDate": fromdate,
      "toDate": todate,
      "leadCategoryId": category,
      "callResultId": status,
      "staffId": staff,
      "isCalled": isCalled,
      "priority": priority,
      "sort": sort,
      "page": page,
      "pageSize": pageSize,
      "isFirst": isFirst,
      "leadType": leadType,
      "branchId": branchId,
      "search": search,
    };

    try {
      var result = await _dio.get(
        "${baseUrl}view_lead_report",
        queryParameters: params,
      );
      ViewLeadsModel model = ViewLeadsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future viewLeadsSts(
    token,
    fromdate,
    todate,
    type,
    id,
    status,
    sort,
    page,
    pageSize,
    isFirst,
    branchId, {
    String? search,
  }) async {
    var params = {
      "token": token,
      "fromDate": fromdate,
      "toDate": todate,
      "type": type,
      "id": id,
      "status": status,
      "sort": sort,
      "page": page,
      "pageSize": pageSize,
      "isFirst": isFirst,
      "branchId": branchId,
      "search": search,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}view_category_staff_wise_lead_report",
        queryParameters: params,
      );
      ViewLeadsModel model = ViewLeadsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addLeadCommonData(token, {branchId}) async {
    var params = {"token": token, "branchId": branchId};

    try {
      var result = await _dio.get(
        "${baseUrl}lead_management_master_data",
        queryParameters: params,
      );
      print('lead_management_master_data:$result');
      AddLeadCommonDataModel model = AddLeadCommonDataModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future<ConnectingChannelModel?> getConnectingChannel(String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_connecting_channel",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ConnectingChannelModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getConnectingChannel error: $e');
      return null;
    }
  }

  static Future<ConnectingStatusModel?> getConnectingStatus(String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_connecting_status",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ConnectingStatusModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getConnectingStatus error: $e');
      return null;
    }
  }

  static Future<ConnectingReasonsModel?> getConnectingReasons(
      String token, String statusId, String type) async {
    var params = {
      "token": token,
      "status_id": statusId,
      "type": type,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}get_connecting_reasons",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ConnectingReasonsModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getConnectingReasons error: $e');
      return null;
    }
  }

  static Future<CallResultResonModel?> getLeadResultReasons(
      String token, String callResultId) async {
    var params = {
      "token": token,
      "callResultId": callResultId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}get_lead_result_reasons",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return CallResultResonModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getLeadResultReasons error: $e');
      return null;
    }
  }

  static Future<ReduceRejectionMethodModel?> getReduceRejectionMethod(
      String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_reduce_rejection_method",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ReduceRejectionMethodModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getReduceRejectionMethod error: $e');
      return null;
    }
  }

  static Future<RejectionRelationActionModel?> getRejectionRelationAction(
      String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_rejection_relation_action",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return RejectionRelationActionModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getRejectionRelationAction error: $e');
      return null;
    }
  }

  static Future<ProspectParametersModel?> getProspectParameters(
      String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_prospect_parameters",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ProspectParametersModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getProspectParameters error: $e');
      return null;
    }
  }

  static Future<ProductCustomizationParameterModel?>
      getProductCustomizationParameter(String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_product_customization_parameter",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return ProductCustomizationParameterModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getProductCustomizationParameter error: $e');
      return null;
    }
  }

  static Future<RelationshipParametersModel?> getRelationshipParameters(
      String token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_relationship_parameters",
        queryParameters: params,
      );
      var data = result.data is String ? jsonDecode(result.data) : result.data;
      return RelationshipParametersModel.fromJson(data);
    } on Exception catch (e) {
      if (kDebugMode) print('getRelationshipParameters error: $e');
      return null;
    }
  }

  static Future addLeads(
    token,
    branchId,
    clientName,
    leadType,
    leadSubType,
    contactNo,
    staffId,
    cost,
    priorityId,
    address,
    remark,
    callResultId,
    nextFollowupDate,
    descriptions,
    code,
    job,
    location,
    customerNeed,
    purpose,
    challenges,
    newObjection,
    googleReviewStatus,
    reasonForLostSales, {
    Map<String, dynamic>? dynamicFormData,
  }) async {
    Map<String, dynamic> map = {
      'token': token,
      'branchId': branchId,
      'next_followup_date': nextFollowupDate,
      'call_result_id': callResultId,
      'lead_category_id': leadType,
      'lead_sub_category_id': leadSubType,
      'clientName': clientName,
      'contactNumber': contactNo,
      'address': address,
      'cost': cost,
      'user_id': staffId,
      'remarks': remark,
      'priority': priorityId,
      'country_code': code,
      "additionalFields": jsonEncode(descriptions),
      "job": job,
      "location": location,
      "customer_need": customerNeed,
      "purpose": purpose,
      "challenges": challenges,
      "new_objection": newObjection,
      "google_review_status": googleReviewStatus,
      "reason_for_lost_sales": reasonForLostSales,
    };

    if (dynamicFormData != null) {
      dynamicFormData.forEach((key, value) {
        if (value is List || value is Map) {
          map[key] = jsonEncode(value);
        } else {
          map[key] = value;
        }
      });
    }

    var formData = FormData.fromMap(map);

    try {
      var result = await _dio.post("${baseUrl}add_leads", data: formData);
      AddLeadModel model = AddLeadModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future viewLeadsCategory(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}lead_category",
        queryParameters: params,
      );
      ViewLeadCategoryModel model = ViewLeadCategoryModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addLeadCategory(token, categoryName) async {
    var params = {"token": token, "leadCategory": categoryName};
    try {
      var result = await _dio.get(
        "${baseUrl}add_lead_category",
        queryParameters: params,
      );
      AddLeadCategoryModel model = AddLeadCategoryModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editLeadCategory(token, categoryName, categoryId) async {
    var params = {
      "token": token,
      "leadCategory": categoryName,
      'leadCategoryId': categoryId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}edit_lead_category",
        queryParameters: params,
      );
      EditLeadCategoryModel model = EditLeadCategoryModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteLeadCategory(token, categoryId) async {
    var params = {"token": token, "leadCategoryId": categoryId};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_lead_category",
        queryParameters: params,
      );
      LeadCategoryDeleteModel model = LeadCategoryDeleteModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future viewLeadsSubCategory(token, categoryId) async {
    var params = {"token": token, "leadCategoryId": categoryId};
    try {
      var result = await _dio.get(
        "${baseUrl}lead_sub_category",
        queryParameters: params,
      );
      ViewLeadSubCategoryModel model = ViewLeadSubCategoryModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addLeadSubCategory(token, categoryName, categoryId) async {
    var params = {
      "token": token,
      "leadSubCategory": categoryName,
      "leadCategoryId": categoryId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}add_lead_sub_category",
        queryParameters: params,
      );
      AddLeadSubCategoryModel model = AddLeadSubCategoryModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editLeadSubCategory(
    token,
    subCategoryName,
    subCategoryId,
  ) async {
    var params = {
      "token": token,
      "leadSubCategory": subCategoryName,
      'leadSubCategoryId': subCategoryId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}edit_lead_sub_category",
        queryParameters: params,
      );
      EditLeadSubCategoryModel model = EditLeadSubCategoryModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteLeadSubCategory(token, subCategoryId) async {
    var params = {"token": token, "leadSubCategoryId": subCategoryId};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_lead_sub_category",
        queryParameters: params,
      );
      LeadSubCategoryDeleteModel model = LeadSubCategoryDeleteModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadSubType(categoryId) async {
    var params = {"leadCategoryId": categoryId};
    try {
      var result = await _dio.get(
        "${baseUrl}get_sub_categories",
        queryParameters: params,
      );
      LeadSubTypeModel model = LeadSubTypeModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadDetails(token, callMasterId) async {
    var params = {"token": token, "call_master_id": callMasterId};
    try {
      var result = await _dio.get(
        "${baseUrl}lead_details",
        queryParameters: params,
      );  
      print('leadDetails:$result');
      LeadDeatailsModel model = LeadDeatailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  // static Future addLeadsFollowup(
  //   token,
  //   callResultId,
  //   callStatusId,
  //   nextFollowupDate,
  //   cost,
  //   address,
  //   leadTypeId,
  //   leadSubType,
  //   remarks,
  //   callMasterId,
  //   calledDate,
  //   callHistoryId,
  //   priorityId,
  //   checked,
  //   timeBefore,
  //   addClient,
  // ) async {
  //   var formData = FormData.fromMap({
  //     "token": token,
  //     "next_followup_date": nextFollowupDate,
  //     "call_result_id": callResultId,
  //     "call_status_id": callStatusId,
  //     "lead_category_id": leadTypeId,
  //     "lead_sub_category_id": leadSubType,
  //     "cost": cost,
  //     "remarks": remarks,
  //     "call_master_id": callMasterId,
  //     "called_date": calledDate,
  //     "cloud_call_id": callHistoryId,
  //     "address": address,
  //     "priority": priorityId,
  //     "reminder": checked,
  //     "time_before": timeBefore,
  //     "is_lead_to_customer": addClient,
  //   });
  //   try {
  //     var result = await _dio.post(
  //       "${baseUrl}add_lead_followup",
  //       data: formData,
  //     );
  //     AddLeadFollowupModel model = AddLeadFollowupModel.fromJson(result.data);
  //     return model;
  //   } on Exception {
  //     return null;
  //   }
  // }

  static Future<AddLeadFollowupModel?> addLeadsFollowup(
    token,
    callResultId,
    callStatusId,
    nextFollowupDate,
    cost,
    address,
    leadTypeId,
    leadSubType,
    remarks,
    callMasterId,
    calledDate,
    callHistoryId,
    callResultReasonId,
    priorityId,
    checked,
    timeBefore,
    addClient,
    job,
    location,
    customerNeed,
    purpose,
    challenges,
    newObjection,
    googleReviewStatus,
    reasonForLostSales, {
    Map<String, dynamic>? dynamicFormData,
  }) async {
    Map<String, dynamic> map = {
      "token": token,
      "next_followup_date": nextFollowupDate,
      "call_result_id": callResultId,
      "call_status_id": callStatusId,
      "lead_category_id": leadTypeId,
      "lead_sub_category_id": leadSubType,
      "cost": cost,
      "remarks": remarks,
      "call_master_id": callMasterId,
      "called_date": calledDate,
      "cloud_call_id": callHistoryId,
      "call_reason": callResultReasonId,
      "address": address,
      "priority": priorityId,
      "reminder": checked,
      "time_before": timeBefore,
      "is_lead_to_customer": addClient,
      "job": job,
      "location": location,
      "customer_need": customerNeed,
      "purpose": purpose,
      "challenges": challenges,
      "new_objection": newObjection,
      "google_review_status": googleReviewStatus,
      "reason_for_lost_sales": reasonForLostSales,
    };

    if (dynamicFormData != null) {
      dynamicFormData.forEach((key, value) {
        if (value is List || value is Map) {
          map[key] = jsonEncode(value);
        } else {
          map[key] = value;
        }
      });
    }

    var formData = FormData.fromMap(map);
    try {
      var result = await _dio.post(
        "${baseUrl}add_lead_followup_new",
        data: formData,
      );
      AddLeadFollowupModel model = AddLeadFollowupModel.fromJson(result.data);
      print('addLeadsFollowup result: ${result.data}'); // Debug print
      return model;
    } on Exception {
      return null;
    }
  }

  static Future<EditLeadFollowupModel> editLeadsFollowup(
    token,
    callFollowupId,
    callResultId,
    nextFollowupDate,
    cost,
    leadTypeId,
    leadSubTypeId,
    callResultReasonId,
    remarks,
    calledDate,
    callMasterId, {
    String? address,
    String? job,
    String? location,
    String? customerNeed,
    String? purpose,
    String? challenges,
    String? newObjection,
    String? googleReviewStatus,
    String? reasonForLostSales,
    String? priorityId,
    Map<String, dynamic>? dynamicFormData,
  }) async {
    Map<String, dynamic> map = {
      "token": token,
      "next_followup_date": nextFollowupDate,
      "call_result_id": callResultId,
      "lead_category_id": leadTypeId,
      "lead_sub_category_id": leadSubTypeId,
      "call_reason": callResultReasonId,
      "cost": cost,
      "remarks": remarks,
      "call_details_id": callFollowupId,
      "called_date": calledDate,
      'call_master_id': callMasterId,
      "address": address ?? "",
      "job": job ?? "",
      "location": location ?? "",
      "customer_need": customerNeed ?? "",
      "purpose": purpose ?? "",
      "challenges": challenges ?? "",
      "new_objection": newObjection ?? "",
      "google_review_status": googleReviewStatus ?? "",
      "reason_for_lost_sales": reasonForLostSales ?? "",
      "priority_id": priorityId ?? "2",
    };

    if (dynamicFormData != null) {
      dynamicFormData.forEach((key, value) {
        if (value is List || value is Map) {
          map[key] = jsonEncode(value);
        } else {
          map[key] = value;
        }
      });
    }

    var formData = FormData.fromMap(map);

    try {
      var result = await _dio.post(
        "${baseUrl}edit_lead_followup_new",
        data: formData,
      );
      EditLeadFollowupModel model = EditLeadFollowupModel.fromJson(result.data);
      return model;
    } on Exception {
      return EditLeadFollowupModel(
        status: false,
        message: "Network error occurred",
      );
    }
  }

  static Future deleteLeadFollowup(token, followupId, callMasterId) async {
    var formData = FormData.fromMap({
      "token": token,
      'call_master_id': callMasterId,
      "call_details_id": followupId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}delete_lead_followup",
        data: formData,
      );
      DeleteLeadFollowModel model = DeleteLeadFollowModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editLeads(
    token,
    callMasterId,
    branchId,
    clientName,
    leadType,
    leadSubTypeId,
    contactNo,
    staffId,
    cost,
    priorityId,
    address,
    remark,
    descriptions,
    code, {
    String? job,
    String? location,
    String? customerNeed,
    String? purpose,
    String? challenges,
    String? newObjection,
    String? googleReviewStatus,
    String? reasonForLostSales,
  }) async {
    var formData = FormData.fromMap({
      'token': token,
      'branchId': branchId,
      'lead_category_id': leadType,
      'lead_sub_category_id': leadSubTypeId,
      'clientName': clientName,
      'contactNumber': contactNo,
      'address': address,
      'cost': cost,
      'user_id': staffId,
      'remarks': remark,
      'priority': priorityId,
      'call_master_id': callMasterId,
      'country_code': code,
      "additionalFields": jsonEncode(descriptions),
      "job": job ?? "",
      "location": location ?? "",
      "customer_need": customerNeed ?? "",
      "purpose": purpose ?? "",
      "challenges": challenges ?? "",
      "new_objection": newObjection ?? "",
      "google_review_status": googleReviewStatus ?? "",
      "reason_for_lost_sales": reasonForLostSales ?? "",
    });
    try {
      //print('cgf');
      var result = await _dio.post("${baseUrl}edit_lead_data", data: formData);
      //print(result);

      EditLeadModel model = EditLeadModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadTransfer(token, callMasterId, staff, remark) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMasterId,
      "staff_id": staff,
      "remarks": remark,
    });

    try {
      var result = await _dio.post("${baseUrl}transfer_leads", data: formData);
      LeadTransferModel model = LeadTransferModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future followupDetails(token, callDetailsId) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_details_id": callDetailsId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}get_lead_followup_details",
        data: formData,
      );
      print('get_lead_followup_details:$result');
      FollowupDetailsModel model = FollowupDetailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadProgressbar(token, fromDate, toDate, callStatus) async {
    var formData = FormData.fromMap({
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "callStatus": callStatus,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}lead_progressbar_data",
        data: formData,
      );
      LeadProgressbarModel model = LeadProgressbarModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadProgressbarStaff(
    token,
    fromDate,
    toDate,
    callStatus,
    staffId,
  ) async {
    var formData = FormData.fromMap({
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "callStatus": callStatus,
      "staffId": staffId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}staff_lead_progressbar_data",
        data: formData,
      );
      LeadProgressbarModel model = LeadProgressbarModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteLead(token, callMasterId) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMasterId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}delete_lead_master",
        data: formData,
      );
      DeleteLeadModel model = DeleteLeadModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future bulkDeleteLead(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}lead_bulk_delete",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      BulkDeleteLeadModel model = BulkDeleteLeadModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future bulkTransferLead(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}bulk_transfer_leads",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      BulkTransferLeadModel model = BulkTransferLeadModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future addBulkContactGroup(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}lead_bulk_message",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      AddBulkContactGroupModel model = AddBulkContactGroupModel.fromJson(
        result.data,
      );

      return model;
    } on Exception {
      return null;
    }
  }

  static Future addCloudCall(token, callMasterId, phoneNumber) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMasterId,
      "phoneNumber": phoneNumber,
    });

    try {
      var result = await _dio.post("${baseUrl}add_cloud_call", data: formData);
      // print(result);
      CloudCallModel model = CloudCallModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future callHistory(token, userId, fromDate, toDate, direction) async {
    //print(userId);
    var formData = FormData.fromMap({
      "token": token,
      "staff_id": userId,
      "fromDate": fromDate,
      "toDate": toDate,
      "direction": direction,
    });

    try {
      var result = await _dio.post("${baseUrl}call_history", data: formData);
      //print(result);
      CallHistoryModel model = CallHistoryModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future searchLead(token, search) async {
    var params = {"token": token, "searchKey": search};
    try {
      var result = await _dio.get(
        "${baseUrl}search_lead_clients",
        queryParameters: params,
      );
      //  print(params);
      //print(result);

      SearchModel model = SearchModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  /* Lead Management  Ends Here..*/
  /* User Management Starts Here..*/
  static Future menuList(token) async {
    var params = {"token": token};
    //print(params);
    try {
      var result = await _dio.get(
        "${baseUrl}get_package_menus",
        queryParameters: params,
      );

      MenuModel model = MenuModel.fromJson(result.data);
      // print(result);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future editMenuList(token, designationId) async {
    var formData = FormData.fromMap({
      "token": token,
      "designation_id": designationId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}designation_details",
        data: formData,
      );
      //print(result);
      EditDesignationDetailsModel model = EditDesignationDetailsModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future postSubMenu(body) async {
    //print(body);
    try {
      var result = await _dio.post(
        "${baseUrl}post_designation",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      PostSubmenuModel model = PostSubmenuModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future postEditSubMenu(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}edit_designation",
        data: jsonEncode(body),
      );

      PostEditSubmenuModel model = PostEditSubmenuModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future postEditStaffSubMenu(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}edit_staff_modules",
        data: jsonEncode(body),
      );

      PostEditStaffSubmenuModel model = PostEditStaffSubmenuModel.fromJson(
        result.data,
      );

      return model;
    } on Exception {
      return null;
    }
  }

  static Future postEditStaffPermission(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}edit_staff_permissions",
        data: jsonEncode(body),
      );

      PostEditStaffPermissionModel model =
          PostEditStaffPermissionModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future designationList(token) async {
    var params = {"token": token};

    try {
      var result = await _dio.get(
        "${baseUrl}get_designation_list",
        queryParameters: params,
      );

      DesignationListModel model = DesignationListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future viewStaffs(token) async {
    var formData = FormData.fromMap({"token": token});

    try {
      var result = await _dio.post("${baseUrl}staff_list", data: formData);
      ViewStaffModel model = ViewStaffModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addUserCommonData(token) async {
    var formData = FormData.fromMap({"token": token});

    try {
      var result = await _dio.post("${baseUrl}userDetailsData", data: formData);
      AddUserCommonDataModel model = AddUserCommonDataModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future postUserData(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}add_staff",
        data: jsonEncode(body),
      );
      AddUserModel model = AddUserModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editUserBasicData(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}update_staff",
        data: jsonEncode(body),
      );
      EditUserBasicDetailsModel model = EditUserBasicDetailsModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future uploadImages(formData) async {
    try {
      var result = await _dio.post("${baseUrl}add_staff_image", data: formData);

      AddUserImageModel model = AddUserImageModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future updateUploadImages(formData) async {
    try {
      var result = await _dio.post(
        "${baseUrl}update_staff_image",
        data: formData,
      );

      AddUserImageModel model = AddUserImageModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteStaff(token, staffId) async {
    var formData = FormData.fromMap({"token": token, "staffUserId": staffId});

    try {
      var result = await _dio.post("${baseUrl}delete_staff", data: formData);

      DeleteStaffModel model = DeleteStaffModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future changePassword(token, confirmPassword, staffUserId) async {
    var formData = FormData.fromMap({
      "token": token,
      "staffUserId": staffUserId,
      "password": confirmPassword,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}change_staff_password",
        data: formData,
      );
      ChangePasswordModel model = ChangePasswordModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future staffDetails(token, staffId) async {
    var params = {"token": token, "staff_id": staffId};
    try {
      var result = await _dio.get(
        "${baseUrl}staff_details",
        queryParameters: params,
      );
      if (kDebugMode) {
        print(result);
      }
      StaffDetailsModel model = StaffDetailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  /* User Management Ends Here..*/
  /* Settings Starts Hers */
  static Future whatsappSettings(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}get_whatsapp_settings",
        queryParameters: params,
      );

      WhatsappSettingsModel model = WhatsappSettingsModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future addWhatsappSettings(
    accessToken,
    instanceId,
    token,
    phoneNumber,
  ) async {
    var params = {
      "accessToken": accessToken,
      "instanceId": instanceId,
      "token": token,
      "phoneNumber": phoneNumber,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}update_unofficial_whatsapp",
        queryParameters: params,
      );

      AddWhatsappSettingsModel model = AddWhatsappSettingsModel.fromJson(
        result.data,
      );

      return model;
    } on Exception {
      return null;
    }
  }

  static Future addWhatsappSettingsOffical(
    phoneNumberId,
    accountId,
    token,
    permanentToken,
  ) async {
    var params = {
      "accountId": accountId,
      "permanentToken": permanentToken,
      "token": token,
      "phoneNumberId": phoneNumberId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}update_official_whatsapp",
        queryParameters: params,
      );

      AddWhatsappSettingsOffModel model = AddWhatsappSettingsOffModel.fromJson(
        result.data,
      );

      return model;
    } on Exception {
      return null;
    }
  }

  /* Settings Ends Here */

  /* Main User Starts Here.. */
  static Future mainDashboard(token) async {
    var formData = FormData.fromMap({"token": token});
    try {
      var result = await _dio.post(
        "${baseUrl}get_active_package",
        data: formData,
      );
      DashboardModel model = DashboardModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future<CallResultResonModel?> callResultReasonList(
    String token,
    String callResultId,
  ) async {
    var formData = FormData.fromMap({
      "token": token,
      "callResultId": callResultId,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}get_lead_result_reasons",
        data: formData,
      );

      CallResultResonModel model = CallResultResonModel.fromJson(result.data);
      return model;
    } on Exception catch (e) {
      log("error: $e");
      return null;
    }
  }

  static Future changeUserPassword(token, password) async {
    var formData = FormData.fromMap({"token": token, "password": password});
    try {
      var result = await _dio.post("${baseUrl}reset_password", data: formData);
      UserChangePasswordModel model = UserChangePasswordModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  /* Main Users Ends Here..*/
  /* Contact Group Starts Here..*/
  static Future contactGroup(token) async {
    var formData = FormData.fromMap({"token": token});
    try {
      var result = await _dio.post(
        "${baseUrl}get_contact_group",
        data: formData,
      );

      ContactGroupModel model = ContactGroupModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future contactGroupDetails(token, id) async {
    var formData = FormData.fromMap({"token": token, "group_id": id});
    try {
      var result = await _dio.post(
        "${baseUrl}get_group_messages",
        data: formData,
      );
      ContactGroupDeatailsModel model = ContactGroupDeatailsModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future sendWhatsappBulkMessage(formData) async {
    try {
      var result = await _dio.post(
        "${baseUrl}send_bulk_message",
        data: formData,
      );

      SendMessageModel model = SendMessageModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addContactGroup(token, groupName, numbers) async {
    var formData = FormData.fromMap({
      "token": token,
      "group_name": groupName,
      "contact_numbers": numbers,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}add_new_contact_group",
        data: formData,
      );

      AddContactGroupModel model = AddContactGroupModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future groupInfo(token, groupId) async {
    var formData = FormData.fromMap({"token": token, "group_id": groupId});
    try {
      var result = await _dio.post(
        "${baseUrl}get_group_details",
        data: formData,
      );
      GroupInfoModel model = GroupInfoModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editContactGroupName(token, groupName, groupId) async {
    var formData = FormData.fromMap({
      "token": token,
      "contact_group_name": groupName,
      "contact_group_id": groupId,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}update_group_name",
        data: formData,
      );
      EditContactGroupModel model = EditContactGroupModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteContactGroup(token, groupId) async {
    var formData = FormData.fromMap({
      "token": token,
      "contact_group_id": groupId,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}delete_contact_group",
        data: formData,
      );
      DeleteContactGroupModel model = DeleteContactGroupModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addContactNumber(token, numbers, groupId) async {
    var formData = FormData.fromMap({
      "token": token,
      "contact_group_id": groupId,
      "contact_numbers": numbers,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}add_contact_numbers",
        data: formData,
      );
      AddContactNumberModel model = AddContactNumberModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editContactNumber(token, number, contactNumberId) async {
    var formData = FormData.fromMap({
      "token": token,
      "contct_number_id": contactNumberId,
      "contact_number": number,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}edit_contact_number",
        data: formData,
      );
      EditContactNumberModel model = EditContactNumberModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteContactNumber(token, id) async {
    var formData = FormData.fromMap({"token": token, "contct_number_id": id});
    try {
      var result = await _dio.post(
        "${baseUrl}delete_contact_number",
        data: formData,
      );

      DeleteContactNumberModel model = DeleteContactNumberModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  /* Contact Group Ends Here...*/

  static Future verifyPhone(phoneNumber) async {
    var params = {"phoneNumber": phoneNumber};
    try {
      var result = await _dio.get(
        "${baseUrl}verify_phone",
        queryParameters: params,
      );
      VerifyPhoneModel model = VerifyPhoneModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future resetPassword(phoneNumber, password) async {
    var params = {"phoneNumber": phoneNumber, "password": password};
    try {
      var result = await _dio.get(
        "${baseUrl}forgot_password",
        queryParameters: params,
      );
      ResetPasswordModel model = ResetPasswordModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future removeUser(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_user",
        queryParameters: params,
      );
      RemoveUserModel model = RemoveUserModel.fromJson(result.data);

      return model;
    } on Exception {
      return null;
    }
  }

  static Future createFolder(token, callMaterId, path) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMaterId,
      "path": path,
    });
    try {
      var result = await _dio.post("${baseUrl}createFolder", data: formData);
      CreateFolderModel model = CreateFolderModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future uploadRecord(
    token,
    callMaterId,
    path,
    uploadFile,
    fileName,
  ) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMaterId,
      "path": path,
      "file_name": fileName,
      "uploadFile": await MultipartFile.fromFile(uploadFile),
    });
    try {
      var result = await _dio.post("${baseUrl}uploadFile", data: formData);
      UploadAudioRecord model = UploadAudioRecord.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future listFolderAndFiles(token, callMaterId, path) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMaterId,
      "path": path,
    });
    try {
      var result = await _dio.post("${baseUrl}getUploads", data: formData);
      ListFolderNameModel model = ListFolderNameModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteLeadFolderAndFiles(
    token,
    callMasterId,
    path,
    rawId,
  ) async {
    var formData = FormData.fromMap({
      "token": token,
      'call_master_id': callMasterId,
      "path": path,
      "row_id": rawId,
    });
    try {
      var result = await _dio.post("${baseUrl}deleteUploads", data: formData);
      DeleteFolderAndFileModel model = DeleteFolderAndFileModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future renameFolder(
    token,
    callMaterId,
    path,
    prevName,
    newName,
    rawId,
  ) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_master_id": callMaterId,
      "path": path,
      "prev_name": prevName,
      "new_name": newName,
      "row_id": rawId,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}renameUploadedFile",
        data: formData,
      );
      RenameFolderModel model = RenameFolderModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fetchData(page, pageSize) async {
    var params = {"page": page, "pageSize": pageSize};

    try {
      var result = await _dio.get(
        "${baseUrl}view_leads_test",
        queryParameters: params,
      );
      TestListApiModel model = TestListApiModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future listAddonDet(token, callMaterId) async {
    var params = {"token": token, "call_master_id": callMaterId};

    try {
      var result = await _dio.get(
        "${baseUrl}lead_details_data",
        queryParameters: params,
      );
      LeadDeatailsModelAdd model = LeadDeatailsModelAdd.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fileManagerPermission(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}file_manager_data",
        queryParameters: params,
      );
      FileManagerPermissionModel model = FileManagerPermissionModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future updateReminder(token, detailsId, checked, time) async {
    var formData = FormData.fromMap({
      "token": token,
      "call_details_id": detailsId,
      "reminder": checked,
      "time_before": time,
    });

    try {
      var result = await _dio.post(
        "${baseUrl}update_followup_reminder",
        data: formData,
      );
      UpdateReminderSetting model = UpdateReminderSetting.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteDesignation(token, designationId) async {
    var params = {"token": token, "designation_id": designationId};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_designation",
        queryParameters: params,
      );
      DeleteDesignationModel model = DeleteDesignationModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fileManagerPermissionMain(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}file_manager_permission",
        queryParameters: params,
      );
      MainFileManagerPermissionModel model =
          MainFileManagerPermissionModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future mainListFolderAndFiles(token, path) async {
    var formData = FormData.fromMap({"token": token, "folderName": path});
    try {
      var result = await _dio.post("${baseUrl}getUploadsData", data: formData);
      FileManagerModel model = FileManagerModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fileUpload(token, folderName, uploadFile, fileName) async {
    var formData = FormData.fromMap({
      "token": token,
      "folderName": folderName,
      "file_name": fileName,
      "uploadFile": await MultipartFile.fromFile(uploadFile),
    });
    try {
      var result = await _dio.post("${baseUrl}uploadNewFile", data: formData);
      UploadAudioRecord model = UploadAudioRecord.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future renameFile(token, folderName, prevName, newName, rawId) async {
    var formData = FormData.fromMap({
      "token": token,
      "folderName": folderName,
      "prev_name": prevName,
      "new_name": newName,
      "row_id": rawId,
    });
    try {
      var result = await _dio.post("${baseUrl}renameFile", data: formData);
      RenameFileModel model = RenameFileModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteFiles(token, folderName, fileName, rawId) async {
    var formData = FormData.fromMap({
      "token": token,
      "folderName": folderName,
      "fileName": fileName,
      "row_id": rawId,
    });
    try {
      var result = await _dio.post(
        "${baseUrl}deleteUploadFile",
        data: formData,
      );
      DeleteFileModel model = DeleteFileModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future unsetReminder(token, callDetailsId) async {
    var params = {"token": token, "call_details_id": callDetailsId};
    try {
      var result = await _dio.get(
        "${baseUrl}unset_reminder",
        queryParameters: params,
      );
      UnsetReminderModel model = UnsetReminderModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fbDetails(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}fbSettingDetails",
        queryParameters: params,
      );
      FacebookSettingsModel model = FacebookSettingsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future updateAssignStaffFbLead(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}update_fb_lead_assigned_staff",
        data: jsonEncode(body),
      );
      UpdateFbLeadAssignStaff model = UpdateFbLeadAssignStaff.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteFbLeads(token, fbLeadId) async {
    var params = {"token": token, "fb_settings_id": fbLeadId};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_fb_settings",
        queryParameters: params,
      );
      DeleteFbLeadsModel model = DeleteFbLeadsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future sendLeadNotification(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}update_push_notification_staff",
        data: jsonEncode(body),
      );
      SendNotificationModel model = SendNotificationModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future callLogUpload(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}add_phone_call_log",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      CallLogUploadModel model = CallLogUploadModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future callLogHistory(token, fromDate, toDate, staffId) async {
    var params = {
      "token": token,
      "fromDate": fromDate,
      "toDate": toDate,
      "staffId": staffId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}get_phone_call_log",
        queryParameters: params,
      );
      CallLogHistoryModel model = CallLogHistoryModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteCallHistoryLogs(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}delete_phone_call_log",
        data: jsonEncode(body),
      );
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      DeleteCallHistoryModel model = DeleteCallHistoryModel.fromJson(
        result.data,
      );

      return model;
    } on Exception {
      return null;
    }
  }

  static Future mainClients(token, searchKey) async {
    var params = {"token": token, "search_key": searchKey};
    try {
      var result = await _dio.get(
        "${baseUrl}mainClientList",
        queryParameters: params,
      );
      MainClientListModel model = MainClientListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future mainClientDetails(token, clientId) async {
    var params = {"token": token, "clientId": clientId};
    try {
      var result = await _dio.get(
        "${baseUrl}mainClientDetails",
        queryParameters: params,
      );
      MainClientDetailsModel model = MainClientDetailsModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteMainClients(token, clientId) async {
    var params = {"token": token, "client_id": clientId};
    try {
      var result = await _dio.get(
        "${baseUrl}deleteMainClients",
        queryParameters: params,
      );
      DeleteMainClientModel model = DeleteMainClientModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadConvertToClient(token, leadId, addCustomField) async {
    var params = {
      "token": token,
      "lead_id": leadId,
      "add_custom_fields": addCustomField,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}convert_lead",
        queryParameters: params,
      );
      LeadConvertToClientModel model = LeadConvertToClientModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addClients(body) async {
    try {
      var result = await _dio.post("${baseUrl}postClient", data: body);
      AddClientsModel model = AddClientsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future invoiceCommonDetails(token, clientId) async {
    var params = {"token": token, "client_id": clientId};
    try {
      var result = await _dio.get(
        "${baseUrl}getInvoiceDetails",
        queryParameters: params,
      );
      InvoiceAddCommonDetailsModel model =
          InvoiceAddCommonDetailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addInvoice(body) async {
    try {
      var result = await _dio.post("${baseUrl}postInvoice", data: body);
      if (kDebugMode) {
        print(body);
      }
      if (kDebugMode) {
        print(result);
      }
      AddInvoiceModel model = AddInvoiceModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future invoiceList(token, fromDate, toDate, clientId) async {
    // print('token: '+token);
    // print('fromDate: '+fromDate);
    // print('toDate: '+toDate);
    // print('clientId: '+clientId);
    var formData = FormData.fromMap({
      'token': token,
      'from_date': fromDate,
      'to_date': toDate,
      'client_id': clientId,
    });
    try {
      var result = await _dio.post("${baseUrl}getInvoiceLists", data: formData);
      InvoiceListModel model = InvoiceListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteInvoice(token, invoiceId) async {
    var params = {"token": token, "invoice_id": invoiceId};
    try {
      var result = await _dio.get(
        "${baseUrl}deleteInvoice",
        queryParameters: params,
      );
      DeleteInvoiceModel model = DeleteInvoiceModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future customerList(token) async {
    var params = {"token": token};
    try {
      var result = await _dio.get(
        "${baseUrl}getCustomerLists",
        queryParameters: params,
      );
      CustomerListModel model = CustomerListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future receptList(token, fromDate, toDate, clientId) async {
    var formData = FormData.fromMap({
      'token': token,
      'from_date': fromDate,
      'to_date': toDate,
      'client_id': clientId,
    });
    try {
      var result = await _dio.post("${baseUrl}getReceiptLists", data: formData);
      ReceiptListModel model = ReceiptListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteReceipt(token, receiptId) async {
    var formData = FormData.fromMap({'token': token, 'receipt_id': receiptId});
    try {
      var result = await _dio.post("${baseUrl}deleteReceipt", data: formData);
      ReceiptDeleteModel model = ReceiptDeleteModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future receiptCommonDetails(token, clientId, invoiceId) async {
    var params = {
      "token": token,
      "client_id": clientId,
      "invoice_id": invoiceId,
    };
    try {
      var result = await _dio.get(
        "${baseUrl}getReceiptDetails",
        queryParameters: params,
      );
      ReceiptAddCommonDetailsModel model =
          ReceiptAddCommonDetailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editClientDetails(token, clientId) async {
    var params = {"token": token, "clientId": clientId};
    print(params);
    try {
      var result = await _dio.get(
        "${baseUrl}getClientById",
        queryParameters: params,
      );
      EditClientDetailsModel model = EditClientDetailsModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editClients(body) async {
    try {
      var result = await _dio.post("${baseUrl}updateClient", data: body);
      EditClientsModel model = EditClientsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future fetchPostOffice(postalCode) async {
    try {
      var result = await _dio.get(
        "https://api.postalpincode.in/pincode/" + postalCode,
      );
      PostalCodeModel model = PostalCodeModel.fromJson(result.data[0]);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addReceipt(
    token,
    invoiceId,
    clientId,
    receiptNumber,
    receiptDate,
    paidAmount,
    collectedBy,
    paymentMethod,
  ) async {
    var formData = FormData.fromMap({
      'token': token,
      'invoice_id': invoiceId,
      'client_id': clientId,
      'receipt_number': receiptNumber,
      'receipt_date': receiptDate,
      'paid_amount': paidAmount,
      'collected_staff': collectedBy,
      'payment_method': paymentMethod,
    });
    try {
      var result = await _dio.post("${baseUrl}postReceipt", data: formData);
      ReceiptAddModel model = ReceiptAddModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editReceiptDetails(token, receiptId) async {
    var params = {"token": token, "receipt_id": receiptId};
    try {
      var result = await _dio.get(
        "${baseUrl}getReceiptById",
        queryParameters: params,
      );
      EditReceiptModelDetailsModel model =
          EditReceiptModelDetailsModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future editReceipt(
    token,
    receiptId,
    receiptDate,
    paidAmount,
    collectedBy,
    paymentMethod,
  ) async {
    var formData = FormData.fromMap({
      'token': token,
      'receipt_id': receiptId,
      'receipt_date': DateFormat(
        "dd-MM-yyyy",
      ).format(DateTime.parse(receiptDate.toString())),
      'paid_amount': paidAmount,
      'collected_staff': collectedBy,
      'payment_method': paymentMethod,
    });
    try {
      var result = await _dio.post("${baseUrl}updateReceipt", data: formData);
      EditReceiptModel model = EditReceiptModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadMileStone(token, subCategoryId) async {
    var params = {"token": token, "leadMasterId": subCategoryId};

    try {
      var result = await _dio.get(
        "${baseUrl}get_milestones",
        queryParameters: params,
      );
      LeadMileStoneListModel model = LeadMileStoneListModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future addMileStone(body) async {
    try {
      var result = await _dio.post(
        "${baseUrl}add_lead_milestones",
        data: jsonEncode(body),
      );
      AddMileStoneModel model = AddMileStoneModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }

  static Future leadNotificationList(token) async {
    var params = {"token": token};

    try {
      var result = await _dio.get(
        "${baseUrl}get_all_lead_milestones",
        queryParameters: params,
      );
      LeadNotificationListModel model = LeadNotificationListModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future readLeadNotification(token, notificationId) async {
    var params = {"token": token, "notification_id": notificationId};
    try {
      var result = await _dio.get(
        "${baseUrl}update_notification_read_status",
        queryParameters: params,
      );
      ReadLeadNotificationModel model = ReadLeadNotificationModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future deleteMileStoneLeads(token, leadMileStoneId) async {
    var params = {"token": token, "lead_milestone_id": leadMileStoneId};
    try {
      var result = await _dio.get(
        "${baseUrl}delete_lead_milestones",
        queryParameters: params,
      );
      DeleteLeadMileStoneModel model = DeleteLeadMileStoneModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future checkLeadPhoneNumber(token, contactNumber, code) async {
    var params = {"token": token, "contactNumber": code + contactNumber};
    try {
      var result = await _dio.get(
        "${baseUrl}check_lead_contact_exist",
        queryParameters: params,
      );
      CheckLeadPhoneNumberModel model = CheckLeadPhoneNumberModel.fromJson(
        result.data,
      );
      return model;
    } on Exception {
      return null;
    }
  }

  static Future getBranchList(token) async {
    var formData = FormData.fromMap({"token": token});
    try {
      var result = await _dio.post("${baseUrl}getBranch", data: formData);
      BranchListModel model = BranchListModel.fromJson(result.data);
      return model;
    } on Exception {
      return null;
    }
  }
}
