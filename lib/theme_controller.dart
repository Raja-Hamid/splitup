import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static final ThemeController _instance = ThemeController._internal();
  factory ThemeController() => _instance;

  ThemeController._internal();

  static ThemeController get instance => _instance;
  final _themeMode = ThemeMode.light.obs;
  final _isDarkMode = false.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _isDarkMode.value;

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    _themeMode.value = _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
