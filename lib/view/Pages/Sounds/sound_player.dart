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
    // Handle audio interruptions (e.g., phone calls)
    player.playingStream.listen((playing) {
      if (!playing) {
        // Audio was interrupted, pause playback
        setState(() {
          audioPlay = false;
        });
      }
    });
  }

  // Initialize audio session to handle interruptions
  Future<void> _initAudioSession() async {
    final audioSession = await AudioSession.instance;
    await audioSession.configure(const AudioSessionConfiguration.speech());
    audioSession.interruptionEventStream.listen((event) {
      if (event.begin) {
        // Another app is requesting audio focus, pause playback
        if (audioPlay) {
          player.pause();
          setState(() {
            audioPlay = false; 
          });
        }
      } else {
        // Interruption ended, resume playback if it was playing before
        if (audioPlay) { // Or use a flag to remember previous state
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
      'soundTitle': 'Rain',
      'audioPath': 'assets/sounds/rain.mp3',
      'imagePath': 'assets/images/rain.jpg'
    },
    {
      'soundTitle': 'Night',
      'audioPath': 'assets/sounds/night.mp3',
      'imagePath': 'assets/images/night.jpg'
    },
    {
      'soundTitle': 'Mix',
      'audioPath': 'assets/sounds/mix.mp3',
      'imagePath': 'assets/images/mix.jpg'
    },
    {
      'soundTitle': 'Winter',
      'audioPath': 'assets/sounds/winter.mp3',
      'imagePath': 'assets/images/winter.jpg'
    },
    {
      'soundTitle': 'Comfort',
      'audioPath': 'assets/sounds/comfort.mp3',
      'imagePath': 'assets/images/comfort.jpg'
    },
    {
      'soundTitle': 'Title A',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 1.png'
    },
    {
      'soundTitle': 'Title B',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 2.png'
    },
    {
      'soundTitle': 'Title C',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 3.png'
    },
    {
      'soundTitle': 'Title D',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Contoh 1.png'
    },
    {
      'soundTitle': 'Title E',
      'audioPath': 'assets/sounds/winter contoh.mp3',
      'imagePath': 'assets/images/Long.png'
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
    } else {
      // Handle the case when the sound is not found
      audioPath = 'assets/sounds/default.mp3'; // Default sound if not found
      imagePath = 'assets/images/default.jpg'; // Default image if not found
    }
  }

  @override
  Widget build(BuildContext context) {

    
    double screenWidth = MediaQuery.of(context).size.width;
    double menuFontSize = screenWidth * 0.06;
    // double titleFontSize = screenWidth * 0.079;
    // double subtitleFontSize = screenWidth * 0.045;
    // double miniFontSize = screenWidth * 0.035;

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
              color: Color(0xFFAB9FD1),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the sound image
            Image.asset(imagePath),

            // Playback controls
            Slider(
              value: _currentSliderValue,
              max: _sliderMaxValue,
              onChanged: (value) {
                setState(() {
                  _currentSliderValue = value;
                  player.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            IconButton(
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
          ],
        ),
      ),
    );
  }

  // ... (Rest of your SoundPlayerPage code - playback controls, UI, etc.) ...
}
