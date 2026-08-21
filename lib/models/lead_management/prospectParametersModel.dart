class ProspectParametersModel {
  List<ProspectParameterData>? data;
  bool? status;
  String? message;

  ProspectParametersModel({this.data, this.status, this.message});

  ProspectParametersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <ProspectParameterData>[];
      json['data'].forEach((v) {
        data!.add(ProspectParameterData.fromJson(v));
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

class ProspectParameterData {
  String? parameterId;
  String? parameterName;
  String? createdDate;
  String? createdBy;
  String? isDeleted;
  String? deletedDate;
  String? deletedBy;
  String? companyId;
  String? staffName;

  ProspectParameterData({
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

  ProspectParameterData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parameter_id'] = parameterId;
    data['parameter_name'] = parameterName;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['is_deleted'] = isDeleted;
    data['deleted_date'] = deletedDate;
    data['deleted_by'] = deletedBy;
    data['company_id'] = companyId;
    data['staff_name'] = staffName;
    return data;
  }
}
