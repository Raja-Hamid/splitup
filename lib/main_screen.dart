import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:splitup/main_controller.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SplitUp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            buildGlassCard(
              padding: EdgeInsets.symmetric(vertical: 25.h),
              child: Column(
                children: [
                  Text(
                    'Total Per Person',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Obx(() {
                    return Text(
                      'Rs. ${_mainController.individualBill}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25.sp,
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            buildGlassCard(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _totalBillController,
                    decoration: InputDecoration(
                      prefixText: 'Rs. ',
                      prefixStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      labelText: 'Bill Amount',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w900,
                    ),
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
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Icon(Icons.remove, color: Colors.white),
                        onTap: () => _mainController.removePerson(),
                      ),
                      SizedBox(width: 5.w),
                      Obx(() {
                        return Text(
                          '${_mainController.totalPersons}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      }),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        child: Icon(Icons.add, color: Colors.white),
                        onTap: () => _mainController.addPerson(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Spacer(),
                      Obx(() {
                        return Text(
                          'Rs. ${_mainController.tip}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    return Slider(
                      value: _mainController.tip,
                      onChanged: (value) => _mainController.setTip(value),
                      min: 0,
                      max: 300,
                      divisions: 6,
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

Widget buildGlassCard({required Widget child, required EdgeInsets padding}) {
  return Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.white24),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.r,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );
}
