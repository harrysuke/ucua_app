import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/user.dart';
import 'screens/unsafe_actions_screen.dart';
import 'screens/unsafe_conditions_screen.dart';
import 'screens/unsafe_actions_report_screen.dart';
import 'screens/unsafe_conditions_report_screen.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService;
  final UserModel user;
  const HomeScreen({super.key, required this.apiService, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UCUA'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.warning_amber_outlined),
              label: const Text('Report Unsafe Action'),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UnsafeActionsScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.report_problem_outlined),
              label: const Text('Report Unsafe Condition'),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UnsafeConditionsScreen()),
                );
              },
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text('View Unsafe Actions Report'),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UnsafeActionsReportScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text('View Unsafe Conditions Report'),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UnsafeConditionsReportScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}