import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost/ucua/api/v4');

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
      home: SplashScreen(apiService: apiService),
    );
  }
}