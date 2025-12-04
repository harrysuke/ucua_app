class UnsafeCondition {
  final int? id;
  final String locationId;
  final String conditionDetails;
  final String staffId;
  final String submitdate;
  final String createby;
  final String createdate;
  final String observerName;
  final String observerDepartment;
  final String observerEmail;
  final String observerDatetime;

  UnsafeCondition({
    this.id,
    required this.locationId,
    required this.conditionDetails,
    required this.staffId,
    required this.submitdate,
    required this.createby,
    required this.createdate,
    required this.observerName,
    required this.observerDepartment,
    required this.observerEmail,
    required this.observerDatetime,
  });

  factory UnsafeCondition.fromJson(Map<String, dynamic> json) {
    return UnsafeCondition(
      id: json['id'] ?? 0,
      locationId: json['LocationId'] ?? 0,
      conditionDetails: json['conditionDetails'] ?? 0,
      staffId: json['staffId'] ?? 0,
      submitdate: json['submitdate'] ?? 0,
      createby: json['createby'] ?? 0,
      createdate: json['createdate'] ?? 0,
      observerName: json['observerName'] ?? 0,
      observerDepartment: json['observerDepartment'] ?? 0,
      observerEmail: json['observerEmail'] ?? 0,
      observerDatetime: json['observerDatetime'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LocationId': locationId,
      'conditionDetails': conditionDetails,
      'staffId': staffId,
      'submitdate': submitdate,
      'createby': createby,
      'createdate': createdate,
      'observerName': observerName,
      'observerDepartment': observerDepartment,
      'observerEmail': observerEmail,
      'observerDatetime': observerDatetime,
    };
  }
}