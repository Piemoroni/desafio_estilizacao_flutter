import 'package:flutter/material.dart';
import 'pallet.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: Pallet.background,
      primaryColor: Pallet.primary,

      appBarTheme: const AppBarTheme(
        backgroundColor: Pallet.primary,
        centerTitle: true,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallet.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}