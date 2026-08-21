class CallResultResonModel {
  List<CallResultResonData>? data;
  bool? status;
  String? message;

  CallResultResonModel({this.data, this.status, this.message});

  CallResultResonModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <CallResultResonData>[];
      json['data'].forEach((v) {
        data!.add(CallResultResonData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class CallResultResonData {
  String? id;
  String? reason;

  CallResultResonData({this.id, this.reason});

  CallResultResonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    return data;
  }
}