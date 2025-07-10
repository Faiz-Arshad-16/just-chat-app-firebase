import 'package:flutter/material.dart';

import '../../../../core/routes/on_generate_route.dart';
import '../widgets/password_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Show dialog to change password
  void _showChangePasswordDialog(BuildContext context) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PasswordField(
                  controller: newPasswordController,
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                ),
                const SizedBox(height: 16.0),
                PasswordField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm new password',
                  isConfirmPassword: true,
                  passwordToMatch: newPasswordController.text,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  debugPrint('New password: ${newPasswordController.text}');
                  Navigator.pop(context); // Close dialog
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const mockUsername = 'User'; // Mock username for profile picture
    const mockEmail = 'user@example.com'; // Mock email

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48.0,
                child: Text(
                  mockUsername.isNotEmpty ? mockUsername[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: mockEmail,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: TextEditingController(text: mockEmail),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () => _showChangePasswordDialog(context),
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Logged out');
                  Navigator.pushReplacementNamed(context, PageConst.login);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}