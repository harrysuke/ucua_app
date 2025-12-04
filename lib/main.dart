import 'package:flutter/material.dart';
import 'models/user.dart';
import 'services/api_service.dart';
import 'screens/splash_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/unsafe_conditions_screen.dart';
import 'screens/unsafe_actions_screen.dart';
import 'screens/unsafe_conditions_report_screen.dart';
import 'screens/unsafe_actions_report_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost/ucua/api/v4');
  late final UserModel user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCUA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: const HomeScreen(),
      //home: SplashScreen(apiService: apiService),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(apiService: apiService),
        '/splash': (context) => SplashScreen(apiService: apiService),
        '/register': (context) => RegisterScreen(apiService: apiService),
        '/login': (context) => LoginScreen(apiService: apiService),
        '/forgot_password': (context) => ForgotPasswordScreen(apiService: apiService),
        '/onboarding': (context) => const OnboardingScreen(),
        //'/home_screen': (context) => HomeScreen(),
        '/profile_screen': (context) => ProfileScreen(
          user: UserModel(companyCode: '', branchCode: '', staffId: '', name: '', phoneNo: '', companyID: 0, department: '', designation: '', accessLevel: 0, email: '', status: 0),
        ),
        '/settings_screen': (context) => const SettingsScreen(),
        '/unsafe_conditions_screen': (context) => const UnsafeConditionsScreen(),
        '/unsafe_actions_screen': (context) => const UnsafeActionsScreen(),
        '/unsafe_conditions_report_screen': (context) => const UnsafeConditionsReportScreen(),
        '/unsafe_actions_report_screen': (context) => const UnsafeActionsReportScreen(),
      },
    );
  }
}