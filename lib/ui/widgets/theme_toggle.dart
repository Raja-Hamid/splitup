import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:splitup/controllers/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    return GestureDetector(
      onTap: () => themeController.toggleTheme(),
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Obx(() {
          final isDark = themeController.isDarkMode;
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 70.w,
            height: 35.h,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: isDark ? Colors.black : Colors.grey.shade300,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.wb_sunny,
                    color: isDark ? Colors.grey : Colors.orange,
                    size: 20,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.nightlight_round,
                    color: isDark ? Colors.yellow : Colors.grey,
                    size: 20.sp,
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: isDark
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDark ? Icons.nightlight_round : Icons.wb_sunny,
                      size: 16.sp,
                      color: isDark ? Colors.black : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
