import 'package:flutter/material.dart';

import '../../../../core/routes/on_generate_route.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/username_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
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
                  'Sign Up for Just Chat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32.0),
                UsernameField(
                  controller: usernameController,
                ),
                const SizedBox(height: 16.0),
                EmailField(
                  controller: emailController,
                ),
                const SizedBox(height: 16.0),
                PasswordField(
                  controller: passwordController,
                ),
                const SizedBox(height: 16.0),
                PasswordField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  isConfirmPassword: true,
                  passwordToMatch: passwordController.text,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint(
                        'Signup validated with username: ${usernameController.text}, '
                            'email: ${emailController.text}',
                      );
                      Navigator.pushReplacementNamed(context, PageConst.home);
                    } else {
                      debugPrint('Signup validation failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PageConst.login);
                  },
                  child: Text(
                    'Already have an account? Log in',
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