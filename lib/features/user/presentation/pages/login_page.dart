import 'package:flutter/material.dart';

import '../../../../core/routes/on_generate_route.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login to Just Chat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32.0),
                EmailField(
                  controller: emailController,
                ),
                const SizedBox(height: 16.0),
                PasswordField(
                  controller: passwordController,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint('Login validated with email: ${emailController.text}');
                      Navigator.pushReplacementNamed(context, PageConst.home);
                    } else {
                      debugPrint('Login validation failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                    Navigator.pushReplacementNamed(context, PageConst.signUp);
                  },
                  child: Text(
                    'Don’t have an account? Sign up',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}