import 'package:flutter/material.dart';
import 'package:ucua_app/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user; // Add UserModel as a parameter
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center( // This Center widget should contain the Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100),
            const SizedBox(height: 16),
            Text(user.name ?? 'User Name', style: const TextStyle(fontSize: 24)),
            Text(user.email ?? 'user@example.com'),
          ],
        ),
      ),
    );
  }
}