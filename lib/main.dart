import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/blocs/my_training_bloc/my_training_bloc.dart';
import 'package:fitness_app/config/exercise_config.dart';
import 'package:fitness_app/config/routes_config.dart';
import 'package:fitness_app/repository/auth_repository.dart';
import 'package:fitness_app/repository/isar_repo/isar_my_training.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/obscure_form_cubit/obscure_form_cubit.dart';
import 'blocs/start_exercise_bloc/start_exercise_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
                      MyTrainingBloc(isarMyTraining: IsarMyTraining()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppUtils.themeData,
              onGenerateRoute: AppRoutesConfig.onGenerateRoute,
              initialRoute: AuthRepository().firebaseAuthCurrentUser,
            ));
      }));
}
