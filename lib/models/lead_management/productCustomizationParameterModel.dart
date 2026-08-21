class ProductCustomizationParameterModel {
  List<ProductCustomizationParameterData>? data;
  bool? status;
  String? message;

  ProductCustomizationParameterModel({this.data, this.status, this.message});

  ProductCustomizationParameterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <ProductCustomizationParameterData>[];
      json['data'].forEach((v) {
        data!.add(ProductCustomizationParameterData.fromJson(v));
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

class ProductCustomizationParameterData {
  String? id;
  String? parameterName;
  String? companyId;
  String? isDeleted;
  String? createdBy;
  String? createdDate;
  String? deletedBy;
  String? deletedDate;
  String? staffName;

  ProductCustomizationParameterData({
    this.id,
    this.parameterName,
    this.companyId,
    this.isDeleted,
    this.createdBy,
    this.createdDate,
    this.deletedBy,
    this.deletedDate,
    this.staffName,
  });

  ProductCustomizationParameterData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    parameterName = json['parameter_name']?.toString();
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
    data['parameter_name'] = parameterName;
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
