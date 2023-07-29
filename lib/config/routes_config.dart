import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/pages/exercises_pages/start_exercise_page.dart';
import 'package:fitness_app/pages/mytraining_pages/accomodate_training_page.dart';
import 'package:fitness_app/pages/mytraining_pages/add_exercise.dart';
import 'package:fitness_app/pages/mytraining_pages/mytraining_page.dart';
import 'package:fitness_app/pages/set_reminder_page.dart';
import 'package:fitness_app/pages/set_weekly_goal_page.dart';
import 'package:flutter/material.dart';
import '../pages/auth_pages/login_page.dart';
import '../pages/auth_pages/register_page.dart';
import '../pages/auth_pages/succes_regis_page.dart';
import '../pages/discover_pages/discover_page.dart';
import '../pages/discover_pages/nutritions_page.dart/detail_nutrition_page.dart';
import '../pages/discover_pages/nutritions_page.dart/list_nutrition_page.dart';
import '../pages/discover_pages/nutritions_page.dart/nutrition_screen.dart';
import '../pages/discover_pages/workout_before_18.dart';
import '../pages/error_page.dart';
import '../pages/exercises_pages/done_exercise_screen.dart';
import '../pages/exercises_pages/exercise_detail_page.dart';
import '../pages/exercises_pages/exercise_tracker_page.dart';
import '../pages/exercises_pages/list_exercise_page.dart';
import '../pages/home_pages/home_page.dart';
import '../pages/main_pages/profile_page.dart';
import '../pages/main_pages/reports_page.dart';
import '../pages/on_boarding_pages/on_boarding_page.dart';
import '../pages/on_boarding_pages/welcome_page.dart';
import '../pages/person_pages/change_password.dart';
import '../pages/person_pages/edit_profile_screen.dart';
import '../widgets/bottom_navigation_widget.dart';

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
      case '/doneExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/doneExercise'),
            builder: (context) => const DoneExerciseScreen());
      case '/listExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/listExercise'),
            builder: (context) => ListExercisePage(
                exercise: settings.arguments as List<ExerciseModel>));
      case '/myTraining':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/myTraining'),
            builder: (context) => MyTrainingPage(
                exercises: settings.arguments as List<ExerciseModel>));
      case '/addExercises':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/addExercises'),
            builder: (context) => AddExercisePage(
                exercises: settings.arguments as List<ExerciseModel>));
      case '/startExercise':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/startExercise'),
            builder: (context) => StartExercisePage(
                exercise: settings.arguments as List<ExerciseModel>));
      case '/exerciseTracker':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/exerciseTracker'),
            builder: (context) => const ExerciseTrackerPage());
      case '/setReminder':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/setReminder'),
            builder: (context) => const SetReminderPage());
      case '/accomodateExercises':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/accomodateExercises'),
            builder: (context) => const AccomodateExercisePage());
      case '/setWeekly':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/setWeekly'),
            builder: (context) => const SetWeeklyGoalPage());
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
