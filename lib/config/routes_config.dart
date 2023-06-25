import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/pages/exercises_pages/start_exercise_page.dart';
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
      // case '/doneExercise':
      //   return MaterialPageRoute(
      //       settings: const RouteSettings(name: '/doneExercise'),
      //       builder: (context) => DoneExerciseScreen(
      //             accomodateExercise: settings.arguments as List<ExerciseModel>,
      //           ));
      case '/doneExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/doneExercise'),
            builder: (context) => const DoneExerciseScreen());

      case '/listExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/listExercise'),
            builder: (context) => ListExercisePage(
                exercise: settings.arguments as List<ExerciseModel>));
      case '/startExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/startExercise'),
            builder: (context) => StartExercisePage(
                exercise: settings.arguments as List<ExerciseModel>));
      case '/exerciseTracker':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/exerciseTracker'),
            builder: (context) => const ExerciseTrackerPage());

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
