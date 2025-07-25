import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color white = Color(0xffFFFFFF);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
}
