import 'package:flutter/foundation.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    debugPrint('========================================');
    debugPrint('Twimzi Initialization Started');
    debugPrint('========================================');

    await _initializeStorage();
    await _initializeTheme();
    await _initializeSession();

    debugPrint('========================================');
    debugPrint('Twimzi Initialization Complete');
    debugPrint('========================================');
  }

  static Future<void> _initializeStorage() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  static Future<void> _initializeTheme() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  static Future<void> _initializeSession() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}