import 'package:flutter/material.dart';
import 'package:ucua_app/models/unsafe_condition.dart';
import 'package:ucua_app/services/ucua_api_service.dart';

class UnsafeConditionsScreen extends StatefulWidget {
  const UnsafeConditionsScreen({super.key});

  @override
  _UnsafeConditionsScreenState createState() => _UnsafeConditionsScreenState();
}

class _UnsafeConditionsScreenState extends State<UnsafeConditionsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<UnsafeCondition>> _futureConditions;

  @override
  void initState() {
    super.initState();
    _futureConditions = _apiService.getUnsafeConditions();
  }

  void _refreshConditions() {
    setState(() {
      _futureConditions = _apiService.getUnsafeConditions();
    });
  }

  void _showAddConditionDialog() {
    final TextEditingController detailsController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Unsafe Condition'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: detailsController,
                    decoration: const InputDecoration(labelText: 'Condition Details')),
                TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location ID')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final now = DateTime.now();
                final newCondition = UnsafeCondition(
                  locationId: locationController.text,
                  conditionDetails: detailsController.text,
                  staffId: 'STAFF-01',
                  submitdate: now.toIso8601String(),
                  createby: 'App User',
                  createdate: now.toIso8601String(),
                  observerName: 'App User',
                  observerDepartment: 'Safety',
                  observerEmail: 'safety@example.com',
                  observerDatetime: now.toIso8601String(),
                );
                await _apiService.createUnsafeCondition(newCondition);
                Navigator.pop(context);
                _refreshConditions();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsafe Conditions'),
      ),
      body: FutureBuilder<List<UnsafeCondition>>(
        future: _futureConditions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No unsafe conditions found.'));
          }

          final conditions = snapshot.data!;
          return ListView.builder(
            itemCount: conditions.length,
            itemBuilder: (context, index) {
              final condition = conditions[index];
              return ListTile(
                title: Text(condition.conditionDetails ?? 'NA'),
                subtitle: Text('Location: ${condition.locationId ?? 'NA'}\nDate: ${condition.submitdate ?? 'NA'}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddConditionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}