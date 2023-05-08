import 'package:fitness_app/config/routes_config.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppUtils.themeData,
        onGenerateRoute: AppRoutesConfig.onGenerateRoute,
        initialRoute: '/welcome',
      );
    },
  ));
}
