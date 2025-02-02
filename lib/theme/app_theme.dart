import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales
  static const Color primaryColor = Color(0xFF000080);
  static const Color accentColor = Colors.blueAccent;
  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF333333);
  static const Color textColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF666666);

  // Tema global de la app
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark, // Modo oscuro
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF1D617B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Cambiado a blanco para modo oscuro
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.white70, // Cambiado a blanco claro
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.white70, // Cambiado a blanco claro
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            const TextStyle(color: Colors.white), // Color de las etiquetas
        hintStyle:
            const TextStyle(color: Colors.white), // Color de los placeholders
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Borde normal
        ),
      ),
    );
  }
}
