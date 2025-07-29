import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  //static const String _prefKey = 'theme_mode';

  // Light theme colors
  final Color _lightPrimary = Colors.lightBlue;
  final Color _lightSecondary = Colors.blueAccent;
  final Color _lightBackground = Colors.white;
  final Color _lightSurface = Colors.white;
  
  // Dark theme colors
  final Color _darkPrimary = Colors.blueGrey;
  final Color _darkSecondary = Colors.lightBlueAccent;
  final Color _darkBackground = Colors.black;
  final Color _darkSurface = Colors.grey[900]!;

  // ThemeProvider() {
  //   _loadTheme();
  // }

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  // Future<void> _loadTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final themeIndex = prefs.getInt(_prefKey) ?? ThemeMode.light.index;
  //   _themeMode = ThemeMode.values[themeIndex];
  //   notifyListeners();
  // }

  // Future<void> toggleTheme() async {
  //   _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_prefKey, _themeMode.index);
  //   notifyListeners();
  // }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Garamond',
        scaffoldBackgroundColor: _lightBackground,
        primaryColor: _lightPrimary,
        colorScheme: ColorScheme.light(
          primary: _lightPrimary,
          secondary: _lightSecondary,
          background: _lightBackground,
          surface: _lightSurface,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: _lightPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _lightPrimary,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _lightPrimary,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Garamond',
        scaffoldBackgroundColor: _darkBackground,
        primaryColor: _darkPrimary,
        colorScheme: ColorScheme.dark(
          primary: _darkPrimary,
          secondary: _darkSecondary,
          background: _darkBackground,
          surface: _darkSurface,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: _darkSurface,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkPrimary,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _darkSecondary,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _darkSecondary,
          foregroundColor: Colors.black,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      );
}