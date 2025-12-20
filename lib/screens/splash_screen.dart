import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
//import 'home_screen.dart';
//import 'screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  final ApiService apiService;
  const SplashScreen({super.key, required this.apiService});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    // In real app, check persisted login/session
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(apiService: widget.apiService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Text(
            'UCUA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}