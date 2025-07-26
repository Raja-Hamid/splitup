import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:splitup/constants/app_theme.dart';
import 'package:splitup/controllers/main_controller.dart';
import 'package:splitup/ui/widgets/glass_card.dart';
import 'package:splitup/ui/widgets/theme_toggle.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('SplitUp'),
        actions: [
          ThemeToggle(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
        decoration: BoxDecoration(
          gradient: theme.extension<BackgroundTheme>()?.backgroundGradient,
        ),
        child: Column(
          children: [
            GlassCard(
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
            GlassCard(
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
                            ? Colors.grey
                            : Colors.deepPurpleAccent,
                        overlayColor: isDark
                            ? Colors.purpleAccent.withValues(alpha: 0.1)
                            : Colors.deepPurpleAccent.withValues(alpha: 0.2),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 20.r,
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
