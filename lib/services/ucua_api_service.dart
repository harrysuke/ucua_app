import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/unsafe_action.dart';
import '../models/unsafe_condition.dart';

class ApiService {
  // IMPORTANT: Replace with your actual API URL.
  // If using a physical device, use your computer's IP address.
  // Example: http://192.168.1.10/safety-api/api
  static const String _baseUrl = 'http://localhost/ucua/api/v4'; // For Android Emulator

  // --- Unsafe Actions ---

  Future<List<UnsafeAction>> getUnsafeActions() async {
    final response = await http.get(Uri.parse('$_baseUrl/unsafe_actions'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => UnsafeAction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load unsafe actions');
    }
  }

  Future<void> createUnsafeAction(UnsafeAction action) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/unsafe_actions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(action.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create unsafe action');
    }
  }

  Future<void> updateUnsafeAction(int id, UnsafeAction action) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/unsafe_actions?id=$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(action.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update unsafe action');
    }
  }

  Future<void> deleteUnsafeAction(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/unsafe_actions?id=$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete unsafe action');
    }
  }

  // --- Unsafe Conditions ---

  Future<List<UnsafeCondition>> getUnsafeConditions() async {
    final response = await http.get(Uri.parse('$_baseUrl/unsafe_conditions'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => UnsafeCondition.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load unsafe conditions');
    }
  }

  Future<void> createUnsafeCondition(UnsafeCondition condition) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/unsafe_conditions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(condition.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create unsafe condition');
    }
  }
}