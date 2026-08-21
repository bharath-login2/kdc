class ConnectingReasonsModel {
  List<ConnectingReasonData>? data;
  bool? status;
  String? message;

  ConnectingReasonsModel({this.data, this.status, this.message});

  ConnectingReasonsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <ConnectingReasonData>[];
      json['data'].forEach((v) {
        data!.add(ConnectingReasonData.fromJson(v));
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

class ConnectingReasonData {
  String? id;
  String? reason;
  String? type;

  ConnectingReasonData({this.id, this.reason, this.type});

  ConnectingReasonData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    reason = json['reason']?.toString();
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['type'] = type;
    return data;
  }
}
