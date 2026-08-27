class EditLeadFollowupModel {
  bool? status;
  String? message;
  dynamic data;

  EditLeadFollowupModel({this.status, this.message, this.data});

  EditLeadFollowupModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] is bool) {
      status = json['status'];
    } else if (json['status'] != null) {
      String s = json['status'].toString().toLowerCase().trim();
      status = (s == 'true' || s == '1' || s == 'success');
    } else {
      status = false;
    }

    message = json['message']?.toString();

    if (json['data'] is bool) {
      data = json['data'];
    } else if (json['data'] != null) {
      String d = json['data'].toString().toLowerCase().trim();
      if (d == 'true' || d == '1') {
        data = true;
      } else if (d == 'false' || d == '0') {
        data = false;
      } else {
        data = json['data'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    dataMap['data'] = data;
    return dataMap;
  }
}