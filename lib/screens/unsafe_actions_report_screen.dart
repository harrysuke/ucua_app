import 'package:flutter/material.dart';
import 'package:ucua_app/models/unsafe_action.dart';
import 'package:ucua_app/services/ucua_api_service.dart';

class UnsafeActionsReportScreen extends StatelessWidget {
  const UnsafeActionsReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsafe Actions Report'),
      ),
      body: FutureBuilder<List<UnsafeAction>>(
        future: _apiService.getUnsafeActions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports found.'));
          }

          final actions = snapshot.data!;
          return ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text(action.violatorName),
                  subtitle: Text('Location: ${action.locationId}\nDate: ${action.submitdate}\nAction Taken: ${action.actionTaken}'),
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