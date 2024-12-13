import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundPlayer extends StatefulWidget {
  final String soundTitle;

  const SoundPlayer({super.key, required this.soundTitle});

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  final player = AudioPlayer();
  double _currentSliderValue = 0.0;
  double _sliderMaxValue = 900.0;
  bool audioPlay = false;
  late String audioPath; // To store audio path
  late String imagePath; // To store image path
  late String genre; // To store genre

  @override
  void initState() {
    super.initState();
    _setAudioAndImagePaths(widget.soundTitle);
    _initAudioPlayer();
    _initAudioSession();

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

    player.playingStream.listen((playing) {
      if (!playing) {
        setState(() {
          audioPlay = false;
        });
      }
    });

    // Automatically play audio
    player.play().then((_) {
      setState(() {
        audioPlay = true;
      });
    });
  }

  @override
  void dispose() {
    // Stop and dispose of the audio player
    player.stop();
    player.dispose();
    super.dispose();
  }

  // Initialize audio session to handle interruptions
  Future<void> _initAudioSession() async {
    final audioSession = await AudioSession.instance;
    await audioSession.configure(const AudioSessionConfiguration.speech());
    audioSession.interruptionEventStream.listen((event) {
      if (event.begin) {
        if (audioPlay) {
          player.pause();
          setState(() {
            audioPlay = false;
          });
        }
      } else {
        if (audioPlay) {
          player.play();
        }
      }
    });
  }

  Future<void> _initAudioPlayer() async {
    await player.setAudioSource(AudioSource.asset(audioPath));
  }

  List<Map<String, dynamic>> sounds = [
    {
      'soundTitle': 'Cloudy',
      'audioPath': 'assets/sounds/rain.mp3',
      'imagePath': 'assets/images/rain.jpg',
      'genre': 'Rain, Relaxing'
    },
    {
      'soundTitle': 'Fireplace',
      'audioPath': 'assets/sounds/night.mp3',
      'imagePath': 'assets/images/night.jpg',
      'genre': 'Cozy, Ambience'
    },
    {
      'soundTitle': 'Sleep Mix',
      'audioPath': 'assets/sounds/mix.mp3',
      'imagePath': 'assets/images/mix.jpg',
      'genre': 'Relaxing, Calm'
    },
    {
      'soundTitle': 'Frosty',
      'audioPath': 'assets/sounds/winter.mp3',
      'imagePath': 'assets/images/winter.jpg',
      'genre': 'Calm, Cold'
    },
    {
      'soundTitle': 'Midnight',
      'audioPath': 'assets/sounds/comfort.mp3',
      'imagePath': 'assets/images/comfort.jpeg',
      'genre': 'Soothing'
    },
    {
      'soundTitle': 'Title A',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 1.png',
      'genre': 'Relaxing'
    },
    {
      'soundTitle': 'Title B',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 2.png',
      'genre': 'Relaxing'
    },
    {
      'soundTitle': 'Title C',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 3.png',
      'genre': 'Relaxing'
    },
    {
      'soundTitle': 'Title D',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 1.png',
      'genre': 'Relaxing'
    },
    {
      'soundTitle': 'Title E',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Long.png',
      'genre': 'Relaxing'
    },
  ];

  void _setAudioAndImagePaths(String soundTitle) {
    // Attempt to find the sound in the list
    final soundData = sounds.firstWhere(
      (sound) => sound['soundTitle'] == soundTitle,
      orElse: () => {}, // Return an empty map if not found
    );

    // Use the retrieved data if found
    if (soundData.isNotEmpty) {
      audioPath = soundData['audioPath'];
      imagePath = soundData['imagePath'];
      genre = soundData['genre'];
    } else {
      // Handle the case when the sound is not found
      audioPath = 'assets/sounds/default.mp3'; // Default sound if not found
      imagePath = 'assets/images/default.jpg'; // Default image if not found
      genre = 'Relaxing';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double menuFontSize = screenWidth * 0.06;
    double titleFontSize = screenWidth * 0.079;
    double subtitleFontSize = screenWidth * 0.045;
    double miniFontSize = screenWidth * 0.035;

    final totalDuration = Duration(seconds: _sliderMaxValue.toInt());
    final currentPosition = Duration(seconds: _currentSliderValue.toInt());

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
            widget.soundTitle,
            style: TextStyle(
              fontSize: menuFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      imagePath,
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
                    child: Text(
                      widget.soundTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '$genre',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "${totalDuration.inMinutes} minutes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: miniFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(currentPosition),
                    style: TextStyle(
                      fontSize: miniFontSize,
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    _formatDuration(totalDuration),
                    style: TextStyle(
                      fontSize: miniFontSize,
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.secondary,
                thumbColor: Theme.of(context).colorScheme.primary,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                trackHeight: 3.0,
              ),
              child: Slider(
                value: _currentSliderValue,
                max: _sliderMaxValue,
                onChanged: (value) {
                  setState(() {
                    _currentSliderValue = value;
                    player.seek(Duration(seconds: value.toInt()));
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 30.0,
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.fast_rewind),
                  onPressed: () {
                    player.seek(Duration(
                        seconds: (_currentSliderValue - 10)
                            .clamp(0, _sliderMaxValue)
                            .toInt()));
                  },
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  iconSize: 30.0,
                  color: Theme.of(context).colorScheme.secondary,
                  icon: Icon(audioPlay ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      audioPlay = !audioPlay;
                      if (audioPlay) {
                        player.play();
                      } else {
                        player.pause();
                      }
                    });
                  },
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  iconSize: 30.0,
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.fast_forward),
                  onPressed: () {
                    player.seek(Duration(
                        seconds: (_currentSliderValue + 10)
                            .clamp(0, _sliderMaxValue)
                            .toInt()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
