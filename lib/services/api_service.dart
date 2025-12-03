import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> _post(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> _get(String path, Map<String, String> params) async {
    final uri = Uri.parse('$baseUrl/$path').replace(queryParameters: params);
    final response = await http.get(uri);
    return jsonDecode(response.body);
  }

  Future<UserModel?> login(String staffId, String password) async {
    final res = await _post('login.php', {
      'staffId': staffId,
      'password': password,
    });

    if (res['success'] == true && res['data'] != null) {
      return UserModel.fromJson(res['data']);
    } else {
      throw Exception(res['message'] ?? 'Login failed');
    }
  }

  Future<void> register({
    required String companyCode,
    required String branchCode,
    required String staffId,
    required String password,
    required String name,
    required String phoneNo,
    required String department,
    required String designation,
    required String email,
    int companyID = 0,
    int accessLevel = 1,
  }) async {
    final res = await _post('register.php', {
      'companyCode': companyCode,
      'branchCode': branchCode,
      'staffId': staffId,
      'password': password,
      'name': name,
      'phoneNo': phoneNo,
      'department': department,
      'designation': designation,
      'email': email,
      'companyID': companyID,
      'accessLevel': accessLevel,
    });

    if (res['success'] != true) {
      throw Exception(res['message'] ?? 'Registration failed');
    }
  }

  Future<void> forgotPassword({
    required String staffId,
    required String email,
    required String newPassword,
  }) async {
    final res = await _post('forgot_password.php', {
      'staffId': staffId,
      'email': email,
      'newPassword': newPassword,
    });

    if (res['success'] != true) {
      throw Exception(res['message'] ?? 'Password reset failed');
    }
  }

  Future<UserModel> getProfile(String staffId) async {
    final res = await _get('profile.php', {'staffId': staffId});
    if (res['success'] == true && res['data'] != null) {
      return UserModel.fromJson(res['data']);
    } else {
      throw Exception(res['message'] ?? 'Profile load failed');
    }
  }

  Future<dynamic> searchReports(String text) async {}
}