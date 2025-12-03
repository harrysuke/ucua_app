import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final ApiService apiService;
  const ForgotPasswordScreen({super.key, required this.apiService});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _staffIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  bool _loading = false;
  String? _message;
  String? _error;

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _message = null;
      _error = null;
    });

    try {
      await widget.apiService.forgotPassword(
        staffId: _staffIdCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        newPassword: _newPasswordCtrl.text,
      );
      setState(() => _message = 'Password updated. You can login now.');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _staffIdCtrl,
                decoration: const InputDecoration(labelText: 'Staff ID'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v == null || !v.contains('@') ? 'Invalid email' : null,
              ),
              TextFormField(
                controller: _newPasswordCtrl,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (v) => v == null || v.length < 6 ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              if (_message != null)
                Text(_message!, style: const TextStyle(color: Colors.green)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _reset,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}