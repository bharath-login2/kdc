class RelationshipParametersModel {
  List<RelationshipParameterData>? data;
  bool? status;
  String? message;

  RelationshipParametersModel({this.data, this.status, this.message});

  RelationshipParametersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <RelationshipParameterData>[];
      json['data'].forEach((v) {
        data!.add(RelationshipParameterData.fromJson(v));
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

class RelationshipParameterData {
  String? parameterId;
  String? parameterName;
  String? createdDate;
  String? createdBy;
  String? isDeleted;
  String? deletedDate;
  String? deletedBy;
  String? companyId;
  String? staffName;

  RelationshipParameterData({
    this.parameterId,
    this.parameterName,
    this.createdDate,
    this.createdBy,
    this.isDeleted,
    this.deletedDate,
    this.deletedBy,
    this.companyId,
    this.staffName,
  });

  RelationshipParameterData.fromJson(Map<String, dynamic> json) {
    parameterId = json['parameter_id']?.toString();
    parameterName = json['parameter_name']?.toString();
    createdDate = json['created_date']?.toString();
    createdBy = json['created_by']?.toString();
    isDeleted = json['is_deleted']?.toString();
    deletedDate = json['deleted_date']?.toString();
    deletedBy = json['deleted_by']?.toString();
    companyId = json['company_id']?.toString();
    staffName = json['staff_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['parameter_id'] = parameterId;
    dataMap['parameter_name'] = parameterName;
    dataMap['created_date'] = createdDate;
    dataMap['created_by'] = createdBy;
    dataMap['is_deleted'] = isDeleted;
    dataMap['deleted_date'] = deletedDate;
    dataMap['deleted_by'] = deletedBy;
    dataMap['company_id'] = companyId;
    dataMap['staff_name'] = staffName;
    return dataMap;
  }
}
