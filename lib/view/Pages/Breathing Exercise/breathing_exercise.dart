import 'package:flutter/material.dart';
import 'package:sleepful/controller/breathing_exercise_controller.dart';

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
              color: Color(0xFFB4A9D6),
            ),
          ),
        ),
      ),

      // Section 2: Breathing Contents
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 30),

              // Breathing Circle
              GestureDetector(
                onTap: () {
                  if (_controller.isBreathing) {
                    _controller.stopBreathing();
                  } else {
                    _controller.startBreathing();
                  }
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.isBreathing ? Colors.blue : Color(0xFF7D64CA),
                  ),
                  child: Center(
                    child: Text(
                      _controller.isBreathing ? 'Breathe Out' : 'Breathe In',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Pick Time Text
              Center(
                child: Text(
                  'Pick the time durations:',
                  style: TextStyle(
                    fontSize: breatheFontSize,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB4A9D6),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Pick Time Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
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
                        color: Color(0xFFB4A9D6),
                      )),
                  IconButton(
                    icon: Icon(Icons.add),
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
            ],
          ),
        ],
      ),
    );
  }
}
