class RejectionRelationActionModel {
  List<RejectionRelationActionData>? data;
  bool? status;
  String? message;

  RejectionRelationActionModel({this.data, this.status, this.message});

  RejectionRelationActionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <RejectionRelationActionData>[];
      json['data'].forEach((v) {
        data!.add(RejectionRelationActionData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataMap['status'] = status;
    dataMap['message'] = message;
    return dataMap;
  }
}

class RejectionRelationActionData {
  String? id;
  String? actionName;
  String? companyId;
  String? isDeleted;
  String? createdBy;
  String? createdDate;
  String? deletedBy;
  String? deletedDate;
  String? staffName;

  RejectionRelationActionData({
    this.id,
    this.actionName,
    this.companyId,
    this.isDeleted,
    this.createdBy,
    this.createdDate,
    this.deletedBy,
    this.deletedDate,
    this.staffName,
  });

  RejectionRelationActionData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    actionName = json['action_name']?.toString();
    companyId = json['company_id']?.toString();
    isDeleted = json['is_deleted']?.toString();
    createdBy = json['created_by']?.toString();
    createdDate = json['created_date']?.toString();
    deletedBy = json['deleted_by']?.toString();
    deletedDate = json['deleted_date']?.toString();
    staffName = json['staff_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['action_name'] = actionName;
    data['company_id'] = companyId;
    data['is_deleted'] = isDeleted;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['deleted_by'] = deletedBy;
    data['deleted_date'] = deletedDate;
    data['staff_name'] = staffName;
    return data;
  }
}
