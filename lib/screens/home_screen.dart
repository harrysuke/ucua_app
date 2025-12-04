import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import 'unsafe_actions_screen.dart';
import 'unsafe_conditions_screen.dart';
import 'unsafe_actions_report_screen.dart';
import 'unsafe_conditions_report_screen.dart';

// We change this to a StatefulWidget to manage the selected tab index
class HomeScreen extends StatefulWidget {
  final ApiService apiService;
  final UserModel user;

  const HomeScreen({super.key, required this.apiService, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Method to handle tab tapping
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Returns the screen for the selected tab
  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 1: // Reports Tab
        return const ReportsTabScreen();
      case 2: // Profile Tab
        return ProfileTabScreen(user: widget.user);
      default: // Home Tab (index 0)
        return _buildHomeTabContent();
    }
  }

  // The original content of the HomeScreen is now a method
  Widget _buildHomeTabContent() {
    return Padding(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UCUA'),
        centerTitle: true,
      ),
      // Add the custom drawer
      drawer: CustomDrawer(user: widget.user),
      // The body now changes based on the selected tab
      body: _getScreenForIndex(_currentIndex),
      // Add the custom bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// --- Placeholder Widgets for other tabs ---
// You can move these to their own files in the screens directory later.

class ReportsTabScreen extends StatelessWidget {
  const ReportsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Reports Tab Content', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfileTabScreen extends StatelessWidget {
  final UserModel user;
  const ProfileTabScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 100),
          const SizedBox(height: 16),
          Text(user.name ?? 'User Name', style: const TextStyle(fontSize: 24)),
          Text(user.email ?? 'user@example.com'),
        ],
      ),
    );
  }
}