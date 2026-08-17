class PushNotificationModel {
  String? title;
  String? message;
  String? type;
  int? notificationId;
  int? detailId;
  int? detailParentId;
  bool? editLead;
  bool? deleteLead;
  bool? cloudcall;
  PushNotificationModel({
    this.title,
    this.message,
    this.type,
    this.detailId,
    this.detailParentId,
    this.notificationId,
    this.editLead,
    this.deleteLead,
    this.cloudcall,
  });
  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    message = json['message']?.toString();
    type = json['type']?.toString();
    notificationId = json['notificationId'] != null
        ? int.tryParse(json['notificationId'].toString())
        : null;
    detailId = json['detailId'] != null
        ? int.tryParse(json['detailId'].toString())
        : null;
    detailParentId = json['detailParentId'] != null
        ? int.tryParse(json['detailParentId'].toString())
        : null;
    editLead = json['editLead']?.toString() == 'true';
    deleteLead = json['deleteLead']?.toString() == 'true';
    cloudcall = json['cloudcall']?.toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    data['notificationId'] = notificationId;
    data['detailId'] = detailId;
    data['detailParentId'] = detailParentId;
    data['editLead'] = editLead;
    data['deleteLead'] = deleteLead;
    data['cloudcall'] = cloudcall;
    return data;
  }
}
