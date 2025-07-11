import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/on_generate_route.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/password_field.dart';
import '../providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

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
                  validator: (value) => Validators.validatePasswordMatch(
                    newPasswordController.text,
                    value,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('New password: ${newPasswordController.text}');
                  Navigator.pop(context);
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final isLoading = ref.watch(loadingProvider);

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
                  user?.username.isNotEmpty == true
                      ? user!.username[0].toUpperCase()
                      : '?',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: user?.email ?? 'user@example.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: TextEditingController(text: user?.email ?? 'user@example.com'),
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
                onPressed: isLoading
                    ? null
                    : () async {
                  print('Log Out button pressed');
                  ref.read(loadingProvider.notifier).state = true;
                  try {
                    await ref.read(signOutProvider).call();
                    print('User logged out');
                    Navigator.pushReplacementNamed(context, PageConst.login);
                  } catch (e) {
                    print('Logout error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
                    );
                  } finally {
                    ref.read(loadingProvider.notifier).state = false;
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}