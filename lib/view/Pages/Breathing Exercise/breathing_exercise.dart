import 'package:flutter/material.dart';
import 'package:sleepful/controller/Breathing%20Exercise/breathing_exercise_controller.dart';

class BreathingExercise extends StatefulWidget {
  const BreathingExercise({super.key});

  @override
  State<BreathingExercise> createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise> {
  final _controller = BreathingExerciseController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double breatheFontSize = screenWidth * 0.05;

    return Scaffold(
      // Section 1: Title and Back Button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/buttonBack.png',
              width: 48,
              height: 48,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Breathing Exercise',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),

      // Section 2: Breathing Contents
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 30),

                  // Breathing Circle
                  GestureDetector(
                    onTap: () {
                      if (!_controller.isBreathing) {
                        _controller.startBreathing();
                      } else {
                        _controller.stopBreathing();
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer Circle (Border)
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 5),
                          ),
                        ),

                        // Inner Circle (Animated)
                        AnimatedContainer(
                          duration:
                              Duration(seconds: _controller.breathDuration),
                          width: _controller.buttonText == 'BREATHE IN'
                              ? 280
                              : 240,
                          height: _controller.buttonText == 'BREATHE IN'
                              ? 280
                              : 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          child: Center(
                            child: Text(
                              _controller.buttonText,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Timer and Duration Controls
                  if (!_controller.isBreathing) ...[
                    // Show when not breathing
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Pick the time durations:',
                            style: TextStyle(
                              fontSize: breatheFontSize,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),

                          SizedBox(height: 10),

                          // Pick Time Button
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10), // Add padding
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (_controller.breathDuration > 1) {
                                        _controller.setBreathDuration(
                                            _controller.breathDuration - 1);
                                      }
                                    });
                                  },
                                ),
                                Text('${_controller.breathDuration} mins',
                                    style: TextStyle(
                                      fontSize: breatheFontSize,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (_controller.breathDuration < 5) {
                                        _controller.setBreathDuration(
                                            _controller.breathDuration + 1);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Show when breathing
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'You\'ve set the duration \nfor ${_controller.breathDuration} minutes!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: breatheFontSize,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB4A9D6),
                            ),
                          ),

                          SizedBox(height: 10),

                          // Time Remaining Display
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1F124A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              _controller
                                  .formatTime(_controller.secondsRemaining),
                              style: TextStyle(
                                fontSize: breatheFontSize,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
