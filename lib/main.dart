import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/config/routes_config.dart';
import 'package:fitness_app/repository/auth_repository.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/export_blocs.dart';

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
          BlocProvider(create: (context) => ObscureFormCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppUtils.themeData,
          onGenerateRoute: AppRoutesConfig.onGenerateRoute,
          initialRoute: AuthRepository().firebaseAuthCurrentUser,
        ),
      );
    },
  ));
}
