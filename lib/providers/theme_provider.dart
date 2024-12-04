import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark; // Default to dark theme

  ThemeProvider() {
    // Initialize theme based on time when the provider is created
    _currentTheme = getThemeBasedOnTime(); 
  }

  ThemeMode get currentTheme => _currentTheme;

  void setTheme(ThemeMode theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  // Helper function to determine theme based on time (now public)
  ThemeMode getThemeBasedOnTime() { // Removed the underscore
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 18) {
      return ThemeMode.light; // Light mode from 6 AM to 6 PM
    } else {
      return ThemeMode.dark; // Dark mode for the rest of the time
    }
  }
}