class AddLeadCommonDataModel {
  Data? data;
  
  bool? status;
  String? message;

  AddLeadCommonDataModel({this.data, this.status, this.message});

  AddLeadCommonDataModel.fromJson(Map<String, dynamic> json) {
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
  List<LeadCategory>? leadCategory;
  List<CallResult>? callResult;
  List<CallResultNew>? callResultNew;
  List<Branch>? branch;
  List<Staff>? staff;
   List<AssignedStaff>? assignedStaff;
  List<TransferStaffs>? transferStaffs;
  List<Priority>? priority;
  List<String>? callResponse;
  List<CallStatus>? callStatus; // New field
  List<LeadSource>? leadSource; // New field
  List<AdditionalFields>? additionalFields;
  String? countryCode;
  bool? customerAddPermission;
  bool? customerAddInvoicePermission;
  List<TargetGroup>? targetGroups; // Added field
  List<ColloctedStaff>? colloctedStaff; // Added field
 Data({
    this.leadCategory,
    this.callResult,
    this.callResultNew,
    this.branch,
    this.staff,
    this.transferStaffs,
    this.priority,
    this.callResponse,
    this.callStatus,
    this.leadSource,
    this.additionalFields,
    this.countryCode,
    this.customerAddPermission,
    this.customerAddInvoicePermission,
    this.targetGroups, // Added to constructor
    this.colloctedStaff, // Added to constructor
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['lead_category'] != null) {
      leadCategory = <LeadCategory>[];
      json['lead_category'].forEach((v) {
        leadCategory!.add(LeadCategory.fromJson(v));
      });
    }
    if (json['call_result'] != null) {
      callResult = <CallResult>[];
      json['call_result'].forEach((v) {
        callResult!.add(CallResult.fromJson(v));
      });
    }
    if (json['call_result_new'] != null) {
      callResultNew = <CallResultNew>[];
      json['call_result_new'].forEach((v) {
        callResultNew!.add(CallResultNew.fromJson(v));
      });
    }
    if (json['branch'] != null) {
      branch = <Branch>[];
      json['branch'].forEach((v) {
        branch!.add(Branch.fromJson(v));
      });
    }
    if (json['staff'] != null) {
      staff = <Staff>[];
      json['staff'].forEach((v) {
        staff!.add(Staff.fromJson(v));
      });
    }
     if (json['assign_staff_list'] != null) {  // ← Changed from 'assignedStaff' to 'assign_staff_list'
    assignedStaff = <AssignedStaff>[];
    json['assign_staff_list'].forEach((v) {
      assignedStaff!.add(AssignedStaff.fromJson(v));
    });
  }
    if (json['transfer_staffs'] != null) {
      transferStaffs = <TransferStaffs>[];
      json['transfer_staffs'].forEach((v) {
        transferStaffs!.add(TransferStaffs.fromJson(v));
      });
    }
    if (json['priority'] != null) {
      priority = <Priority>[];
      json['priority'].forEach((v) {
        priority!.add(Priority.fromJson(v));
      });
    }
    callResponse = json['call_response'] != null 
        ? json['call_response'].cast<String>() 
        : null;
        
    if (json['call_status'] != null) {
      callStatus = <CallStatus>[];
      json['call_status'].forEach((v) {
        callStatus!.add(CallStatus.fromJson(v));
      });
    }

    // Parse lead_source array
    if (json['lead_source'] != null) {
      leadSource = <LeadSource>[];
      json['lead_source'].forEach((v) {
        leadSource!.add(LeadSource.fromJson(v));
      });
    }
    
    if (json['additionalFields'] != null) {
      additionalFields = <AdditionalFields>[];
      json['additionalFields'].forEach((v) {
        additionalFields!.add(AdditionalFields.fromJson(v));
      });
    }
    
    countryCode = json['country_code'];
    customerAddPermission = json['customerAddPermission'];
    customerAddInvoicePermission = json['customerAddInvoicePermission'];
    
    // Added: Parse target_groups array
    if (json['target_groups'] != null) {
      targetGroups = <TargetGroup>[];
      json['target_groups'].forEach((v) {
        targetGroups!.add(TargetGroup.fromJson(v));
      });
    }
    
    // Added: Parse collocted_staff array
    if (json['collocted_staff'] != null) {
      colloctedStaff = <ColloctedStaff>[];
      json['collocted_staff'].forEach((v) {
        colloctedStaff!.add(ColloctedStaff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leadCategory != null) {
      data['lead_category'] = leadCategory!.map((v) => v.toJson()).toList();
    }
    if (callResult != null) {
      data['call_result'] = callResult!.map((v) => v.toJson()).toList();
    }
    if (callResultNew != null) {
      data['call_result_new'] = callResultNew!.map((v) => v.toJson()).toList();
    }
    if (branch != null) {
      data['branch'] = branch!.map((v) => v.toJson()).toList();
    }
    if (staff != null) {
      data['staff'] = staff!.map((v) => v.toJson()).toList();
    }
     if (assignedStaff != null) {
      data['assigned_staff'] = assignedStaff!.map((v) => v.toJson()).toList();
    }
    if (transferStaffs != null) {
      data['transfer_staffs'] = transferStaffs!.map((v) => v.toJson()).toList();
    }
    if (priority != null) {
      data['priority'] = priority!.map((v) => v.toJson()).toList();
    }
    data['call_response'] = callResponse;
    if (callStatus != null) {
      data['call_status'] = callStatus!.map((v) => v.toJson()).toList();
    }
    if (leadSource != null) {
      data['lead_source'] = leadSource!.map((v) => v.toJson()).toList();
    }
    if (additionalFields != null) {
      data['additionalFields'] = additionalFields!.map((v) => v.toJson()).toList();
    }
    data['country_code'] = countryCode;
    data['customerAddPermission'] = customerAddPermission;
    data['customerAddInvoicePermission'] = customerAddInvoicePermission;
    if (targetGroups != null) {
      data['target_groups'] = targetGroups!.map((v) => v.toJson()).toList();
    }
    
    if (colloctedStaff != null) {
      data['collocted_staff'] = colloctedStaff!.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class LeadCategory {
  String? leadCategoryId;
  String? leadCategory;

  LeadCategory({this.leadCategoryId, this.leadCategory});

  LeadCategory.fromJson(Map<String, dynamic> json) {
    leadCategoryId = json['lead_category_id'];
    leadCategory = json['lead_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_category_id'] = leadCategoryId;
    data['lead_category'] = leadCategory;
    return data;
  }
}

class CallResult {
  String? callResultId;
  String? callResult;

  CallResult({this.callResultId, this.callResult});

  CallResult.fromJson(Map<String, dynamic> json) {
    callResultId = json['call_result_id'];
    callResult = json['call_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['call_result_id'] = callResultId;
    data['call_result'] = callResult;
    return data;
  }
}

class CallResultNew {
  String? callResultIdNew;
  String? callResultNew;
  String? type;

  CallResultNew({this.callResultIdNew, this.callResultNew, this.type});

  CallResultNew.fromJson(Map<String, dynamic> json) {
    callResultIdNew = json['call_result_id_new']?.toString();
    callResultNew = json['call_result_new']?.toString();
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['call_result_id_new'] = callResultIdNew;
    data['call_result_new'] = callResultNew;
    data['type'] = type;
    return data;
  }
}

class CallStatus {
  String? callResponseId;
  String? callResponse;

  CallStatus({this.callResponseId, this.callResponse});

  CallStatus.fromJson(Map<String, dynamic> json) {
    callResponseId = json['call_response_id'];
    callResponse = json['call_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_response_id'] = callResponseId;
    data['call_response'] = callResponse;
    return data;
  }
}

// New: LeadSource class
class LeadSource {
  String? leadSourceId;
  String? leadSource;

  LeadSource({this.leadSourceId, this.leadSource});

  LeadSource.fromJson(Map<String, dynamic> json) {
    leadSourceId = json['lead_source_id'];
    leadSource = json['lead_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_source_id'] = leadSourceId;
    data['lead_source'] = leadSource;
    return data;
  }
}

class Branch {
  String? branchId;
  String? branchName;

  Branch({this.branchId, this.branchName});

  Branch.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    return data;
  }
}

class Staff {
  String? staffId;
  String? staffName;

  Staff({this.staffId, this.staffName});

  Staff.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staff_id'] = staffId;
    data['staff_name'] = staffName;
    return data;
  }
}
class AssignedStaff {
  String? assignedStaffId;
  String? assignedStaffName;

  AssignedStaff({this.assignedStaffId, this.assignedStaffName});

  AssignedStaff.fromJson(Map<String, dynamic> json) {
    assignedStaffId = json['assigned_staff_id'];
    assignedStaffName = json['assigned_staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_staff_id'] = assignedStaffId;
    data['assigned_staff_name'] = assignedStaffName;
    return data;
  }
}

class TransferStaffs {
  String? tranStaffId;
  String? tranStaffName;

  TransferStaffs({this.tranStaffId, this.tranStaffName});

  TransferStaffs.fromJson(Map<String, dynamic> json) {
    tranStaffId = json['tran_staff_id'];
    tranStaffName = json['tran_staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tran_staff_id'] = tranStaffId;
    data['tran_staff_name'] = tranStaffName;
    return data;
  }
}

class Priority {
  String? priorityId;
  String? priority;

  Priority({this.priorityId, this.priority});

  Priority.fromJson(Map<String, dynamic> json) {
    priorityId = json['priority_id'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority_id'] = priorityId;
    data['priority'] = priority;
    return data;
  }
}

class AdditionalFields {
  String? id;
  String? fieldName;

  AdditionalFields({this.id, this.fieldName});

  AdditionalFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldName = json['field_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_name'] = fieldName;
    return data;
  }
}

// Added: TargetGroup class
class TargetGroup {
  String? id;
  String? groupName;

  TargetGroup({this.id, this.groupName});

  TargetGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    return data;
  }
}

// Added: ColloctedStaff class
class ColloctedStaff {
  String? accountId;
  String? accountName;

  ColloctedStaff({this.accountId, this.accountName});

  ColloctedStaff.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['account_name'] = accountName;
    return data;
  }
}