import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
// import '../../Components/plus_button.dart';
// import '../../Navbar/bottom_navbar.dart';

class SoundsNight extends StatefulWidget {
  const SoundsNight({super.key});

  @override
  State<SoundsNight> createState() => _SoundsNightState();
}

class _SoundsNightState extends State<SoundsNight> {
  final player = AudioPlayer();
  double _currentSliderValue = 0.0;
  double _sliderMaxValue = 1680.0;
  bool audioPlay = false;


  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    player.positionStream.listen((position) {
      setState(() {
        _currentSliderValue = position.inSeconds.toDouble();
      });
    });
    player.durationStream.listen((duration) {
      setState(() {
        _sliderMaxValue = duration?.inSeconds.toDouble() ?? 0.0;
      });
    });

    player.playerStateStream.listen((state) {
      if (state.processingState != ProcessingState.ready &&
          state.processingState != ProcessingState.completed) {
        setState(() {
          audioPlay = false; // Update isPlaying to false when not playing
        });
      }
    });

  }

  Future<void> _initAudioPlayer() async {
    await player.setAudioSource(AudioSource.asset('assets/audio/your_audio_file.mp3'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!audioPlay) {
      player.pause();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double menuFontSize = screenWidth * 0.06;
    double titleFontSize = screenWidth * 0.079;
    double subtitleFontSize = screenWidth * 0.045;
    double miniFontSize = screenWidth * 0.035;

    return Scaffold(
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
              'Night',
              style: TextStyle(
                fontSize: menuFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Color(0xFFAB9FD1),
              ),
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(10.0),
            child:Align(
              alignment: Alignment.center,
              child:AspectRatio(aspectRatio: 1.0,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/images/night.jpg",
                    width: 289,
                    height: 289,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Center(
                    child:Text(
                    "Night",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                      fontFamily: 'Montserrat',
                      color:Color(0xFFAB9FD1),
                      ),
                    ),
                  ),
                    const SizedBox(height: 5.0,),

                    Center(
                      child: Text(
                        "Calm, Soothing",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF6A5B9A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 1.0,),

                    Center(
                      child: Text(
                        "28m",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF6A5B9A),
                        ),
                      ),
                    ),

                    // time
                    const SizedBox(height: 18.0,),

                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 8.0),
                      child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<Duration?>(
                            stream: player.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              return Text(_formatDuration(position),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: miniFontSize,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF6A5B9A),
                                ),
                              );
                            },
                          ),
                          StreamBuilder<Duration?>(
                            stream: player.durationStream,
                            builder: (context, snapshot) {
                              final duration = snapshot.data ?? Duration.zero;
                              return Text(_formatDuration(duration),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: miniFontSize,
                                fontFamily: 'Montserrat',
                                color: Color(0xFF6A5B9A),
                              ),
                              );
                            },
                          ),
                        ],
                      ),
                          // Expanded(
                          //   flex:0,
                          //   child:Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text(
                          //       "00:00",
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize:miniFontSize,
                          //         fontFamily: 'Montserrat',
                          //         color: Color(0xFF6A5B9A),
                          //       ),
                          //     ),
                          //   )
                          // ),

                          // Expanded(
                          //   flex:0,
                          //   child:Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Text(
                          //       "28:00",
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize:miniFontSize,
                          //         fontFamily: 'Montserrat',
                          //         color: Color(0xFF6A5B9A),
                          //       ),
                          //     ),
                          //   ),
                          ),
                        ],
                      ),
                    ),
            Center(
              child:SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Color(0xFF6A5B9A),
                    inactiveTrackColor: Color(0xFFB4A9D6),
                    thumbColor: Color(0xFF6A5B9A),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 6.0),
                    trackHeight: 3.0,
                  ),
                  child: Slider(
                    value: _currentSliderValue,
                    max: _sliderMaxValue,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        if (value > 1680.0) {
                          value = 1680.0;
                        }
                        Duration desiredTime = Duration(seconds: value.toInt());
                        player.seek(desiredTime);
                      });
                    },
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 30.0,
                  color: Color(0xFF6A5B9A),
                  icon: const Icon(Icons.fast_rewind),
                  onPressed: () {
                    player.pause();
                  },
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  iconSize: 30.0,
                  color: Color(0xFF120C23),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF6A5B9A)),
                    shape: WidgetStateProperty.all<OutlinedBorder>(const CircleBorder()),

                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  onPressed: () {
                    player.play();
                    setState(() {
                      audioPlay = true;
                    });
                  },
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  iconSize: 30.0,
                  color: Color(0xFF6A5B9A),
                  icon: const Icon(Icons.fast_forward),
                  onPressed: () {
                    player.pause();
                  },
                ),
              ],
            ),
            // BottomNavbar(selectedIndex: -1),
          ],
        ),
      ),

    );
  }
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
