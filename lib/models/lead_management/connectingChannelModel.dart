class ConnectingChannelModel {
  List<ConnectingChannelData>? data;
  bool? status;
  String? message;

  ConnectingChannelModel({this.data, this.status, this.message});

  ConnectingChannelModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <ConnectingChannelData>[];
      json['data'].forEach((v) {
        data!.add(ConnectingChannelData.fromJson(v));
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

class ConnectingChannelData {
  String? channelId;
  String? channelName;
  String? createdBy;
  String? createdDate;
  String? isDeleted;
  String? deletedBy;
  String? deletedDate;
  String? companyId;
  String? staffName;

  ConnectingChannelData({
    this.channelId,
    this.channelName,
    this.createdBy,
    this.createdDate,
    this.isDeleted,
    this.deletedBy,
    this.deletedDate,
    this.companyId,
    this.staffName,
  });

  ConnectingChannelData.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id']?.toString();
    channelName = json['channel_name']?.toString();
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
    data['channel_id'] = channelId;
    data['channel_name'] = channelName;
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
