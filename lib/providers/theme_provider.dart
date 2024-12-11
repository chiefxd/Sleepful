import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userId;
  bool _isAuto = false;

  ThemeProvider(this.userId) {
    _loadThemePreference();
  }

  ThemeMode get currentTheme => _isAuto ? getThemeBasedOnTime() : _currentTheme;

  bool get isAuto => _isAuto;

  void setTheme(ThemeMode theme, {bool isAuto = false}) async {
    _currentTheme = theme;
    _isAuto = isAuto;
    await _saveThemePreference(theme, isAuto: isAuto);
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> initializeTheme() async {
    await _loadThemePreference();
    notifyListeners();
  }

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
          _isAuto = true;
          _currentTheme = getThemeBasedOnTime();
        }
      } else {
        _currentTheme = ThemeMode.dark;
        _isAuto = false;
      }
    } catch (e) {
      print("Error loading theme preference: $e");
    }
  }

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
        SetOptions(merge: true),
      );
    } catch (e) {
      print("Error saving theme preference: $e");
    }
  }

  ThemeMode getThemeBasedOnTime() {
    final now = DateTime.now();
    return now.hour >= 6 && now.hour < 18 ? ThemeMode.light : ThemeMode.dark;
  }
}
