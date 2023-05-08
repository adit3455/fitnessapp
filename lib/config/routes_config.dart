import 'package:fitness_app/pages/auth_pages/register_page.dart';
import 'package:fitness_app/pages/auth_pages/succes_regis_page.dart';
import 'package:flutter/material.dart';

import '../pages/export_pages.dart';

class AppRoutesConfig {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (context) => const HomePage());
      case '/welcome':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/welcome'),
            builder: (context) => const WelcomePage());
      case '/boarding':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/boarding'),
            builder: (context) => const OnBoardingPage());
      case '/login':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/login'),
            builder: (context) => const LoginPage());
      case '/register':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/register'),
            builder: (context) => const RegisterPage());
      case '/successRegis':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/successRegis'),
            builder: (context) => const SuccessRegistrationPage());

      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
