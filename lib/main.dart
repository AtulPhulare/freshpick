import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshpick/core/constants/app_colors.dart';
import 'core/logger/debug_log_service.dart';
import 'config/routes/app_routes.dart';

final logger = DebugLogService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fresh Pick',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
              ),
              fontFamily: "Poppins",
              scaffoldBackgroundColor: AppColors.background,
            ),
            initialRoute: AppRoutes.onboarding,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
