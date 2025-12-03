import 'package:flutter/material.dart';
import 'package:ucua_app/models/unsafe_condition.dart';
import 'package:ucua_app/services/ucua_api_service.dart';

class UnsafeConditionsReportScreen extends StatelessWidget {
  const UnsafeConditionsReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsafe Conditions Report'),
      ),
      body: FutureBuilder<List<UnsafeCondition>>(
        future: _apiService.getUnsafeConditions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports found.'));
          }

          final conditions = snapshot.data!;
          return ListView.builder(
            itemCount: conditions.length,
            itemBuilder: (context, index) {
              final condition = conditions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text(condition.conditionDetails ?? 'NA'),
                  subtitle: Text('Location: ${condition.locationId ?? 'NA'}\nDate: ${condition.submitdate ?? 'NA'}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}