import 'dart:async';
import 'package:flutter/material.dart';

class BreathingExerciseController extends ChangeNotifier {
  int _breathDuration = 3;
  bool _isBreathing = false; // Flag to track breathing state
  Timer? _timer; // Timer for breathing exercise
  Timer? _timeRemainingTimer; // Timer for updating time
  int _secondsRemaining = 0; // Add variable to track remaining seconds
  String _buttonText = 'START'; // Text displayed on the circle

  int get breathDuration => _breathDuration;
  bool get isBreathing => _isBreathing;
  int get secondsRemaining => _secondsRemaining;
  String get buttonText => _buttonText;

  // Function to start the breathing exercise
  void startBreathing() {
    _isBreathing = true;
    _buttonText = 'BREATHE IN';
    _secondsRemaining = _breathDuration * 60;

    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_secondsRemaining > 0) {
        _buttonText =
            _buttonText == 'BREATHE IN' ? 'BREATHE OUT' : 'BREATHE IN';
        notifyListeners(); // Add notifyListeners here to update the button text
      } else {
        stopBreathing();
      }
    });

    // Timer for updating time remaining
    _timeRemainingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners(); // Add notifyListeners here to update the timer
      } else {
        _timeRemainingTimer?.cancel();
      }
    });

    // Timer to stop breathing exercise after the specified duration
    Timer(Duration(minutes: _breathDuration), () {
      stopBreathing();
    });

    notifyListeners();
  }

  // Function to stop the breathing exercise
  void stopBreathing() {
    _isBreathing = false;
    _buttonText = 'START';
    _timer?.cancel();
    _timeRemainingTimer?.cancel(); // Cancel time remaining timer

    notifyListeners();
  }

  void setBreathDuration(int duration) {
    _breathDuration = duration;

    notifyListeners();
  }

  void dispose() {
    _timer?.cancel();
    _timeRemainingTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
