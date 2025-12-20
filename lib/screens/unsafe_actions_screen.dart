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


  void _showEditActionDialog(UnsafeAction action) {
    // 1. Guard Clause: Check if ID exists before even opening or processing
    if (action.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: '+ action.id.toString() +' Action ID is missing.')),
      );
      return;
    }

    final TextEditingController violatorNameController = TextEditingController(text: action.violatorName);
    final TextEditingController locationController = TextEditingController(text: action.locationId);
    final TextEditingController actionTakenController = TextEditingController(text: action.actionTaken);
    final TextEditingController remarkController = TextEditingController(text: action.remark);
    final TextEditingController id = TextEditingController(text: action.id.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Unsafe Action'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: violatorNameController, decoration: const InputDecoration(labelText: 'Violator Name')),
                TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location ID')),
                TextField(controller: actionTakenController, decoration: const InputDecoration(labelText: 'Action Taken')),
                TextField(controller: remarkController, decoration: const InputDecoration(labelText: 'Remark')),
                TextField(controller: id, decoration: const InputDecoration(labelText: 'ID'), enabled: false),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                final updatedAction = UnsafeAction(
                  id: action.id,
                  locationId: locationController.text,
                  offenceCode: action.offenceCode,
                  staffId: action.staffId,
                  violatorName: violatorNameController.text,
                  violatorContactNo: action.violatorContactNo,
                  violatorDept: action.violatorDept,
                  violatorCompany: action.violatorCompany,
                  violatorIc: action.violatorIc,
                  violatorDatetime: action.violatorDatetime,
                  submitdate: action.submitdate,
                  actionTaken: actionTakenController.text,
                  remark: remarkController.text,
                  createby: action.createby,
                  createdate: action.createdate,
                  observerName: action.observerName,
                  observerDepartment: action.observerDepartment,
                  observerEmail: action.observerEmail,
                  observerDatetime: action.observerDatetime,
                );

                try {
                  // Use action.id safely since we checked it above
                  await _apiService.updateUnsafeAction(action.id!, updatedAction);

                  if (!mounted) return;
                  Navigator.pop(context);
                  _refreshActions();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Action updated successfully')),
                  );
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update action: $e')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(UnsafeAction action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete the unsafe action by ${action.violatorName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _apiService.deleteUnsafeAction(action.id!);
                  Navigator.pop(context);
                  _refreshActions();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Action deleted successfully')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete action: $e')),
                  );
                }
              },
              child: const Text('Delete'),
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
                subtitle: Text('ID: ${action.id}\nLocation: ${action.locationId}\nDate: ${action.submitdate}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditActionDialog(action),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteConfirmationDialog(action),
                    ),
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