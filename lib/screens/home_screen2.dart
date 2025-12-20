import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService;
  final UserModel user;

  const HomeScreen({super.key, required this.apiService, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Staff ID: ${user.staffId}', style: const TextStyle(fontSize: 16)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
            Text('Phone: ${user.phoneNo}', style: const TextStyle(fontSize: 16)),
            Text('Department: ${user.department}', style: const TextStyle(fontSize: 16)),
            Text('Designation: ${user.designation}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}