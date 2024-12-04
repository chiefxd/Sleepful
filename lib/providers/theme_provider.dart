import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark; // Default theme
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userId; // Pass the user ID when initializing ThemeProvider
  bool _isAuto = false; // Track if the "auto" mode is active

  ThemeProvider(this.userId) {
    _loadThemePreference();
  }

  ThemeMode get currentTheme => _isAuto
      ? getThemeBasedOnTime()
      : _currentTheme; // Return theme dynamically

  bool get isAuto => _isAuto; // Expose the auto mode state

  void setTheme(ThemeMode theme, {bool isAuto = false}) async {
    _currentTheme = theme;
    _isAuto = isAuto; // Set auto mode
    await _saveThemePreference(theme, isAuto: isAuto); // Save to Firestore
    notifyListeners();
  }

  // Load theme preference from Firestore
  Future<void> _loadThemePreference() async {
    try {
      final doc = await _firestore.collection('Users').doc(userId).get();
      if (doc.exists && doc.data()?['theme'] != null) {
        String theme = doc.data()?['theme'];
        if (theme == 'light') {
          _currentTheme = ThemeMode.light;
          _isAuto = false;
        } else if (theme == 'dark') {
          _currentTheme = ThemeMode.dark;
          _isAuto = false;
        } else if (theme == 'auto') {
          _isAuto = true; // Correctly enable auto mode
          _currentTheme = getThemeBasedOnTime(); // Dynamically calculate
        }
      } else {
        // If no preference exists, set a default and save it
        _currentTheme = ThemeMode.dark; // Default to dark
        _isAuto = false; // Default to non-auto
        await _saveThemePreference(_currentTheme);
      }
    } catch (e) {
      print("Error loading theme preference: $e");
    }
  }

  // Save theme preference to Firestore
  Future<void> _saveThemePreference(ThemeMode theme,
      {bool isAuto = false}) async {
    try {
      final themeString = isAuto
          ? 'auto'
          : theme == ThemeMode.light
              ? 'light'
              : 'dark';

      await _firestore.collection('Users').doc(userId).set(
        {'theme': themeString},
        SetOptions(merge: true), // Merge with existing data
      );
    } catch (e) {
      print("Error saving theme preference: $e");
    }
  }

  // Helper function to determine theme based on time
  ThemeMode getThemeBasedOnTime() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 18) {
      return ThemeMode.light; // Light mode from 6 AM to 6 PM
    } else {
      return ThemeMode.dark; // Dark mode for the rest of the time
    }
  }
}
