import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xff9e9e9e);
  static const Color transparent = Color(0x00000000);

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    colors: [Color(0xFFD1C4E9), Color(0xFFB39DDB), Color(0xFF8E7CC3)],
    stops: [0.0, 0.7, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      const BackgroundTheme(backgroundGradient: lightBackgroundGradient),
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: black,
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        color: black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      displayMedium: GoogleFonts.poppins(
        color: black,
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
      ),
      displayLarge: GoogleFonts.poppins(
        color: black,
        fontSize: 25.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: GoogleFonts.poppins(
        color: black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      labelStyle: GoogleFonts.poppins(
        color: black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: grey),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    iconTheme: IconThemeData(color: black),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      const BackgroundTheme(backgroundGradient: darkBackgroundGradient),
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        color: white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      displayMedium: GoogleFonts.poppins(
        color: white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
      ),
      displayLarge: GoogleFonts.poppins(
        color: white,
        fontSize: 25.sp,
        fontWeight: FontWeight.w900,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: GoogleFonts.poppins(
        color: white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      labelStyle: GoogleFonts.poppins(
        color: white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w900,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: grey),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    iconTheme: IconThemeData(color: white),
  );
}

@immutable
class BackgroundTheme extends ThemeExtension<BackgroundTheme> {
  final Gradient? backgroundGradient;

  const BackgroundTheme({this.backgroundGradient});

  @override
  BackgroundTheme copyWith({Gradient? backgroundGradient}) {
    return BackgroundTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  BackgroundTheme lerp(ThemeExtension<BackgroundTheme>? other, double t) {
    if (other is! BackgroundTheme) return this;
    return BackgroundTheme(
      backgroundGradient: Gradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      ),
    );
  }
}
