class UserModel {
  final String companyCode;
  final String branchCode;
  final String staffId;
  final String name;
  final String phoneNo;
  final int companyID;
  final String department;
  final String designation;
  final int accessLevel;
  final String email;
  final int status;

  UserModel({
    required this.companyCode,
    required this.branchCode,
    required this.staffId,
    required this.name,
    required this.phoneNo,
    required this.companyID,
    required this.department,
    required this.designation,
    required this.accessLevel,
    required this.email,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      companyCode: json['companyCode'] ?? '',
      branchCode: json['branchCode'] ?? '',
      staffId: json['staffId'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      phoneNo: json['PhoneNo']?.toString() ?? '',
      companyID: int.tryParse(json['CompanyID'].toString()) ?? 0,
      department: json['Department'] ?? '',
      designation: json['Designation'] ?? '',
      accessLevel: int.tryParse(json['AccessLevel'].toString()) ?? 0,
      email: json['Email'] ?? '',
      status: int.tryParse(json['Status'].toString()) ?? 0,
    );
  }
}