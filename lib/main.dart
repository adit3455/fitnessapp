import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/blocs/my_training_bloc/my_training_bloc.dart';
import 'package:fitness_app/blocs/nutrition_bookmarks_bloc/nutrition_bookmarks_bloc.dart';
import 'package:fitness_app/blocs/set_weekly_goal_bloc/set_weekly_goal_bloc.dart';
import 'package:fitness_app/config/exercise_config.dart';
import 'package:fitness_app/config/routes_config.dart';
import 'package:fitness_app/repository/auth_repository.dart';
import 'package:fitness_app/repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import 'package:fitness_app/repository/isar_repo/isar_my_training.dart';
import 'package:fitness_app/repository/isar_repo/isar_nutrition_.dart';
import 'package:fitness_app/repository/isar_repo/isar_set_weekly.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/obscure_form_cubit/obscure_form_cubit.dart';
import 'blocs/start_exercise_bloc/start_exercise_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'config/notification_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  await NotificationConfig().scheduledDaily();

  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthBloc(AuthRepository())),
              BlocProvider(create: (context) => ObscureFormCubit()),
              BlocProvider(
                  create: (context) =>
                      StartExerciseBloc(exerciseConfig: ExerciseConfig())),
              BlocProvider(
                  create: (context) =>
                      NutritionBookmarksBloc(isarNutrition: IsarNutrition())),
              BlocProvider(
                  create: (context) =>
                      MyTrainingBloc(isarMyTraining: IsarMyTraining())),
              BlocProvider(
                  create: (context) => SetWeeklyGoalBloc(
                      isarSetWeekly: IsarSetWeekly(),
                      firebaseExerciseModule: FirebaseExerciseModule())
                    ..add(SetWeeklyGoalStarted()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppUtils.themeData,
              onGenerateRoute: AppRoutesConfig.onGenerateRoute,
              initialRoute: AuthRepository().firebaseAuthCurrentUser,
            ));
      }));
}
