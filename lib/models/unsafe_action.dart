class UnsafeAction {
  final int? id;
  final String locationId;
  final String offenceCode;
  final String staffId;
  final String violatorName;
  final String violatorContactNo;
  final String violatorDept;
  final String violatorCompany;
  final String violatorIc;
  final String violatorDatetime;
  final String submitdate;
  final String actionTaken;
  final String remark;
  final String createby;
  final String createdate;
  final String observerName;
  final String observerDepartment;
  final String observerEmail;
  final String observerDatetime;

  UnsafeAction({
    this.id,
    required this.locationId,
    required this.offenceCode,
    required this.staffId,
    required this.violatorName,
    required this.violatorContactNo,
    required this.violatorDept,
    required this.violatorCompany,
    required this.violatorIc,
    required this.violatorDatetime,
    required this.submitdate,
    required this.actionTaken,
    required this.remark,
    required this.createby,
    required this.createdate,
    required this.observerName,
    required this.observerDepartment,
    required this.observerEmail,
    required this.observerDatetime,
  });

  factory UnsafeAction.fromJson(Map<String, dynamic> json) {
    return UnsafeAction(
      id: json['id'],
      locationId: json['LocationId'],
      offenceCode: json['OffenceCode'] ?? '',
      staffId: json['staffId'],
      violatorName: json['ViolatorName'] ?? '',
      violatorContactNo: json['violatorContactNo'] ?? '',
      violatorDept: json['ViolatorDept'] ?? '',
      violatorCompany: json['violatorCompany'] ?? '',
      violatorIc: json['ViolatorIc'] ?? '',
      violatorDatetime: json['violatorDatetime'] ?? '',
      submitdate: json['submitdate'],
      actionTaken: json['ActionTaken'] ?? '',
      remark: json['remark'] ?? '',
      createby: json['createby'],
      createdate: json['createdate'],
      observerName: json['observerName'],
      observerDepartment: json['observerDepartment'],
      observerEmail: json['observerEmail'],
      observerDatetime: json['observerDatetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LocationId': locationId,
      'OffenceCode': offenceCode,
      'staffId': staffId,
      'ViolatorName': violatorName,
      'violatorContactNo': violatorContactNo,
      'ViolatorDept': violatorDept,
      'violatorCompany': violatorCompany,
      'ViolatorIc': violatorIc,
      'violatorDatetime': violatorDatetime,
      'submitdate': submitdate,
      'ActionTaken': actionTaken,
      'remark': remark,
      'createby': createby,
      'createdate': createdate,
      'observerName': observerName,
      'observerDepartment': observerDepartment,
      'observerEmail': observerEmail,
      'observerDatetime': observerDatetime,
    };
  }
}