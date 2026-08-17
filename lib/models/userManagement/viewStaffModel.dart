class ViewStaffModel {
  bool? status;
  String? message;
  Data? data;

  ViewStaffModel({this.status, this.message, this.data});

  ViewStaffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? createStaff;
  bool? viewStaff;
  bool? updateStaff;
  bool? deleteStaff;
  bool? viewStaffReport;
  bool? createStaffDesignation;
  bool? viewStaffDesignation;
  bool? updateStaffDesignation;
  bool? deleteStaffDesignation;
  bool? updateStaffPassword;
  bool? updateStaffPermission;
   bool? staffManagementPermission;
  List<StaffList>? staffList;

  Data(
      {this.createStaff,
        this.viewStaff,
        this.updateStaff,
        this.deleteStaff,
        this.viewStaffReport,
        this.createStaffDesignation,
        this.viewStaffDesignation,
        this.updateStaffDesignation,
        this.deleteStaffDesignation,
        this.updateStaffPassword,
        this.updateStaffPermission,
        this.staffManagementPermission,
        this.staffList});

  Data.fromJson(Map<String, dynamic> json) {
    createStaff = json['create_staff'];
    viewStaff = json['view_staff'];
    updateStaff = json['update_staff'];
    deleteStaff = json['delete_staff'];
    viewStaffReport = json['view_staff_report'];
    createStaffDesignation = json['create_staff_designation'];
    viewStaffDesignation = json['view_staff_designation'];
    updateStaffDesignation = json['update_staff_designation'];
    deleteStaffDesignation = json['delete_staff_designation'];
    updateStaffPassword = json['update_staff_password'];
    updateStaffPermission = json['update_staff_permission'];
    staffManagementPermission = json['staff_management_menu'];
    if (json['staff_list'] != null) {
      staffList = <StaffList>[];
      json['staff_list'].forEach((v) {
        staffList!.add(StaffList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create_staff'] = createStaff;
    data['view_staff'] = viewStaff;
    data['update_staff'] = updateStaff;
    data['delete_staff'] = deleteStaff;
    data['view_staff_report'] = viewStaffReport;
    data['create_staff_designation'] = createStaffDesignation;
    data['view_staff_designation'] = viewStaffDesignation;
    data['update_staff_designation'] = updateStaffDesignation;
    data['delete_staff_designation'] = deleteStaffDesignation;
    data['update_staff_password'] = updateStaffPassword;
    data['update_staff_permission'] = updateStaffPermission;
    data['staff_management_menu'] = staffManagementPermission;
    if (staffList != null) {
      data['staff_list'] = staffList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffList {
  String? staffId;
  String? name;
  String? email;
  String? phoneNo;
  String? designation;
  String? branchName;
  String? imageUrl;
  bool? editPermission;
  bool? deletePermission;
  bool? changePasswordPermission;

  StaffList(
      {this.staffId,
        this.name,
        this.email,
        this.phoneNo,
        this.designation,
        this.branchName,
        this.imageUrl,
        this.editPermission,
        this.deletePermission,
        this.changePasswordPermission});

  StaffList.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    designation = json['designation'];
    branchName = json['branch_name'];
    imageUrl = json['imageUrl'];
    editPermission = json['edit_permission'];
    deletePermission = json['delete_permission'];
    changePasswordPermission = json['change_password_permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staffId'] = staffId;
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['designation'] = designation;
    data['branch_name'] = branchName;
    data['imageUrl'] = imageUrl;
    data['edit_permission'] = editPermission;
    data['delete_permission'] = deletePermission;
    data['change_password_permission'] = changePasswordPermission;
    return data;
  }
}