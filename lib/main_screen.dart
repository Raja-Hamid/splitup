import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:splitup/app_theme.dart';
import 'package:splitup/main_controller.dart';
import 'package:splitup/theme_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController _mainController = Get.find<MainController>();
  final TextEditingController _totalBillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = ThemeController.instance;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('SplitUp'),
        actions: [
          Obx(() {
            return CupertinoSwitch(
              inactiveTrackColor: Colors.grey.shade300,
              value: themeController.isDarkMode,
              onChanged: (_) => themeController.toggleTheme(),
            );
          }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
        decoration: BoxDecoration(
          gradient: theme.extension<BackgroundTheme>()?.backgroundGradient,
        ),
        child: Column(
          children: [
            buildGlassCard(
              context: context,
              padding: EdgeInsets.symmetric(vertical: 25.h),
              child: Column(
                children: [
                  Text('Total Per Person', style: theme.textTheme.displaySmall),
                  SizedBox(height: 5.h),
                  Obx(() {
                    return Text(
                      'Rs. ${_mainController.individualBill}',
                      style: theme.textTheme.displayLarge,
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            buildGlassCard(
              context: context,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _totalBillController,
                    decoration: InputDecoration(
                      prefixText: 'Rs. ',
                      labelText: 'Bill Amount',
                    ),
                    style: theme.textTheme.displayMedium,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    onChanged: (value) {
                      _mainController.setTotalBill(
                        double.tryParse(value) ?? 0.0,
                      );
                      _mainController.calculateIndividualBill();
                    },
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Text('Split', style: theme.textTheme.displaySmall),
                      Spacer(),
                      GestureDetector(
                        child: Icon(Icons.remove),
                        onTap: () => _mainController.removePerson(),
                      ),
                      SizedBox(width: 5.w),
                      Obx(() {
                        return Text(
                          '${_mainController.totalPersons}',
                          style: theme.textTheme.displaySmall,
                        );
                      }),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        child: Icon(Icons.add),
                        onTap: () => _mainController.addPerson(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text('Tip', style: theme.textTheme.displaySmall),
                      Spacer(),
                      Obx(() {
                        return Text(
                          'Rs. ${_mainController.tip}',
                          style: theme.textTheme.displaySmall,
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;

                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        inactiveTrackColor: isDark
                            ? Colors.white24
                            : Colors.grey.shade300,
                        thumbColor: isDark
                            ? Colors.purpleAccent
                            : Colors.deepPurpleAccent,
                        overlayColor: isDark
                            ? Colors.purpleAccent.withValues(alpha: 0.3)
                            : Colors.deepPurpleAccent.withValues(alpha: 0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 20,
                        ),
                        trackShape: const RoundedRectSliderTrackShape(),
                        valueIndicatorShape:
                            const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: isDark
                            ? Colors.black
                            : Colors.white,
                        valueIndicatorTextStyle: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Slider(
                        value: _mainController.tip,
                        onChanged: (value) => _mainController.setTip(value),
                        min: 0,
                        max: 300,
                        divisions: 6,
                        label: 'Rs. ${_mainController.tip.round()}',
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildGlassCard({
  required BuildContext context,
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.3),
            width: isDark ? 1.0 : 1.5,
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0x33B39DDB),
                    blurRadius: 28,
                    offset: const Offset(0, 18),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(-6, -6),
                  ),
                ],
        ),
        child: child,
      ),
    ),
  );
}
