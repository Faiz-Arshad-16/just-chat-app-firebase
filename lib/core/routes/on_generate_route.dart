import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/chat/presentation/pages/home_page.dart';
import 'package:chat_app/features/user/presentation/pages/login_page.dart';
import 'package:chat_app/features/user/presentation/pages/profile_page.dart';
import 'package:chat_app/features/user/presentation/pages/signup_page.dart';
import 'package:chat_app/features/user/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class PageConst {
  static const String splash = "/";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String home = "/home";
  static const String profile = "/profile";
  static const String chat = "/chat";
}

class OnGenerateRoute {
  static Route? route(RouteSettings settings) {
    final name = settings.name;

    Widget page;

    switch (name) {
      case PageConst.splash:
        page = const SplashScreen();
        break;
      case PageConst.login:
        page = const LoginPage();
        break;
      case PageConst.signUp:
        page = const SignupPage();
        break;
      case PageConst.profile:
        page = const ProfilePage();
        break;
      case PageConst.home:
        page = const HomePage();
        break;
      case PageConst.chat:
        page = const ChatPage();
        break;
      default:
        page = const ErrorPage();
    }

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      settings: settings,
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error Page"),
      ),
    );
  }
}