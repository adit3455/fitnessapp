import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/pages/auth_pages/register_page.dart';
import 'package:fitness_app/pages/auth_pages/succes_regis_page.dart';
import 'package:fitness_app/pages/discover_pages/workout_before_18.dart';
import 'package:fitness_app/pages/discover_pages/nutritions_page.dart/detail_nutrition_page.dart';
import 'package:fitness_app/pages/exercises_pages/exercise_detail_page.dart';
import 'package:fitness_app/pages/person_pages/change_password.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

import '../pages/export_pages.dart';

class AppRoutesConfig {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (context) => const HomePage());
      case '/bottom':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/bottom'),
            builder: (context) => const BottomNavigationWidget());
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
      case '/discover':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/discover'),
            builder: (context) => const DiscoverPage());
      case '/reports':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/reports'),
            builder: (context) => const ReportsPage());
      case '/profil':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/profil'),
            builder: (context) => const ProfilePage());
      case '/editProfil':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/editProfil'),
            builder: (context) => const EditProfileScreen());
      case '/changePassword':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/changePassword'),
            builder: (context) => const ChangePassword());
      case '/nutrition':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/nutrition'),
            builder: (context) => const NutritionScreen());
      case '/workoutBeforeEighteen':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/workoutBeforeEighteen'),
            builder: (context) => const WorkOutBeforeEighteenPage());
      case '/detailNutrition':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/detailNutrition'),
            builder: (context) => DetailNutritionPage(
                foodModel: settings.arguments as FoodModel));
      case '/listNutrition':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/listNutrition'),
            builder: (context) => ListNutritionPage(
                foodModel: settings.arguments as List<FoodModel>));
      case '/allExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/allExercise'),
            builder: (context) => const AllExercisesPage());
      case '/exerciseDetail':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/exerciseDetail'),
            builder: (context) => ExerciseDetailPage(
                  exercise: settings.arguments as ExerciseModel,
                  index: settings.arguments as int,
                ));

      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
