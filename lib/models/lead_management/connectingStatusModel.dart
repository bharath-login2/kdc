class ConnectingStatusModel {
  List<ConnectingStatusData>? data;
  bool? status;
  String? message;

  ConnectingStatusModel({this.data, this.status, this.message});

  ConnectingStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <ConnectingStatusData>[];
      json['data'].forEach((v) {
        data!.add(ConnectingStatusData.fromJson(v));
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

class ConnectingStatusData {
  String? statusId;
  String? statusName;
  String? createdBy;
  String? createdDate;
  String? isDeleted;
  String? deletedBy;
  String? deletedDate;
  String? companyId;
  String? staffName;

  ConnectingStatusData({
    this.statusId,
    this.statusName,
    this.createdBy,
    this.createdDate,
    this.isDeleted,
    this.deletedBy,
    this.deletedDate,
    this.companyId,
    this.staffName,
  });

  ConnectingStatusData.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id']?.toString();
    statusName = json['status_name']?.toString();
    createdBy = json['created_by']?.toString();
    createdDate = json['created_date']?.toString();
    isDeleted = json['is_deleted']?.toString();
    deletedBy = json['deleted_by']?.toString();
    deletedDate = json['deleted_date']?.toString();
    companyId = json['company_id']?.toString();
    staffName = json['staff_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_id'] = statusId;
    data['status_name'] = statusName;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['is_deleted'] = isDeleted;
    data['deleted_by'] = deletedBy;
    data['deleted_date'] = deletedDate;
    data['company_id'] = companyId;
    data['staff_name'] = staffName;
    return data;
  }
}
