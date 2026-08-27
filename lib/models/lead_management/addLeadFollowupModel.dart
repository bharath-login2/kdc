class AddLeadFollowupModel {
  bool? status;
  String? message;
  dynamic data;

  AddLeadFollowupModel({this.status, this.message, this.data});

  AddLeadFollowupModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] is bool) {
      status = json['status'];
    } else if (json['status'] != null) {
      String s = json['status'].toString().toLowerCase().trim();
      status = (s == 'true' || s == '1' || s == 'success');
    } else {
      status = false;
    }

    message = json['message']?.toString();
    data = json['data']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    dataMap['data'] = data;
    return dataMap;
  }
}