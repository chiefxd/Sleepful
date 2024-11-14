import 'dart:async';

class BreathingExerciseController {
  int _breathDuration = 3;
  bool _isBreathing = false;
  Timer? _timer;

  int get breathDuration => _breathDuration;

  bool get isBreathing => _isBreathing;

  void startBreathing() {
    _isBreathing = true;
    _timer = Timer.periodic(Duration(seconds: _breathDuration), (timer) {
      _isBreathing = !_isBreathing;
    });
  }

  void stopBreathing() {
    _timer?.cancel();
    _isBreathing = false;
  }

  void setBreathDuration(int duration) {
    _breathDuration = duration;
  }

  void dispose() {
    _timer?.cancel();
  }
}