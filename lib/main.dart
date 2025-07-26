import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:splitup/constants/app_theme.dart';
import 'package:splitup/controllers/main_controller.dart';
import 'package:splitup/ui/screens/main_screen.dart';
import 'package:splitup/controllers/theme_controller.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  Get.put(MainController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 873),
      builder: (context, child) {
        return GetBuilder<ThemeController>(
          init: ThemeController.instance,
          builder: (controller) {
            return GetMaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: controller.themeMode,
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            );
          },
        );
      },
    );
  }
}
