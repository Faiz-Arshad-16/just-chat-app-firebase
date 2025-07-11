import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/on_generate_route.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/username_field.dart';
import '../providers/auth_provider.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isLoading = ref.watch(loadingProvider);

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
                UsernameField(controller: usernameController),
                const SizedBox(height: 16.0),
                EmailField(controller: emailController),
                const SizedBox(height: 16.0),
                PasswordField(controller: passwordController),
                const SizedBox(height: 16.0),
                PasswordField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  validator: (value) =>
                      Validators.validatePasswordMatch(passwordController.text, value),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    print('Sign Up button pressed');
                    if (formKey.currentState!.validate()) {
                      print('Form validated');
                      ref.read(loadingProvider.notifier).state = true;
                      try {
                        final user = await ref.read(signUpProvider).call(
                          emailController.text,
                          passwordController.text,
                          usernameController.text,
                        );
                        print('Sign-up result: user=${user?.uid}');
                        if (user != null) {
                          print('Navigating to ${PageConst.home}');
                          Navigator.pushReplacementNamed(context, PageConst.home);
                        } else {
                          print('Sign-up returned null user');
                        }
                      } catch (e) {
                        print('Sign-up error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign-up failed: $e')),
                        );
                      } finally {
                        ref.read(loadingProvider.notifier).state = false;
                      }
                    } else {
                      print('Form validation failed');
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
                      : const Text('Sign Up'),
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