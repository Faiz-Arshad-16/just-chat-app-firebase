import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/on_generate_route.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            Navigator.pushReplacementNamed(context, PageConst.home);
          } else {
            Navigator.pushReplacementNamed(context, PageConst.login);
          }
        },
        loading: () {},
        error: (_, __) => Navigator.pushReplacementNamed(context, PageConst.login),
      );
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Just Chat',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}