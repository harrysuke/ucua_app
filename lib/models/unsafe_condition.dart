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
      id: json['id'],
      locationId: json['LocationId'],
      conditionDetails: json['conditionDetails'],
      staffId: json['staffId'],
      submitdate: json['submitdate'],
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