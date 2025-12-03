import 'package:flutter/material.dart';
import 'package:ucua_app/models/unsafe_action.dart';
import 'package:ucua_app/services/ucua_api_service.dart';

class UnsafeActionsScreen extends StatefulWidget {
  const UnsafeActionsScreen({super.key});

  @override
  _UnsafeActionsScreenState createState() => _UnsafeActionsScreenState();
}

class _UnsafeActionsScreenState extends State<UnsafeActionsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<UnsafeAction>> _futureActions;

  @override
  void initState() {
    super.initState();
    _futureActions = _apiService.getUnsafeActions();
  }

  void _refreshActions() {
    setState(() {
      _futureActions = _apiService.getUnsafeActions();
    });
  }

  void _showAddActionDialog() {
    // For simplicity, a basic dialog. A full-screen form would be better.
    final TextEditingController violatorNameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    // Add other controllers as needed...

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Unsafe Action'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: violatorNameController,
                    decoration: const InputDecoration(labelText: 'Violator Name')),
                TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location ID')),
                // Add other TextFields here
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
                final newAction = UnsafeAction(
                  locationId: locationController.text,
                  offenceCode: 'O-001', // Example
                  staffId: 'STAFF-01', // Example
                  violatorName: violatorNameController.text,
                  violatorContactNo: '1234567890',
                  violatorDept: 'Maintenance',
                  violatorCompany: 'ABC Corp',
                  violatorIc: '123456-78-9012',
                  violatorDatetime: now.toIso8601String(),
                  submitdate: now.toIso8601String(),
                  actionTaken: 'Verbal Warning',
                  remark: 'First offense',
                  createby: 'App User',
                  createdate: now.toIso8601String(),
                  observerName: 'App User',
                  observerDepartment: 'Safety',
                  observerEmail: 'safety@example.com',
                  observerDatetime: now.toIso8601String(),
                );
                await _apiService.createUnsafeAction(newAction);
                Navigator.pop(context);
                _refreshActions();
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
        title: const Text('Unsafe Actions'),
      ),
      body: FutureBuilder<List<UnsafeAction>>(
        future: _futureActions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No unsafe actions found.'));
          }

          final actions = snapshot.data!;
          return ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return ListTile(
                title: Text(action.violatorName),
                subtitle: Text('Location: ${action.locationId}\nDate: ${action.submitdate}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit), onPressed: () {
                      // TODO: Implement edit functionality
                    }),
                    IconButton(icon: const Icon(Icons.delete), onPressed: () async {
                      // TODO: Implement delete functionality
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddActionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}