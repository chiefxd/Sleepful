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
  // double _currentSliderValue = 0.0;
  // double _sliderMaxValue = 900.0;
  bool audioPlay = false;
  late String audioPath; // To store audio path
  late String imagePath; // To store image path

  @override
  void initState() {
    super.initState();
    _setAudioAndImagePaths(widget.soundTitle);
    _initAudioPlayer();

    // player.positionStream.listen((position) {
    //   setState(() {
    //     _currentSliderValue = position.inSeconds.toDouble();
    //   });
    // });
    // player.durationStream.listen((duration) {
    //   setState(() {
    //     _sliderMaxValue = duration?.inSeconds.toDouble() ?? 0.0;
    //   });
    // });
  }

  Future<void> _initAudioPlayer() async {
    await player.setAudioSource(AudioSource.asset(audioPath));
  }

  void _setAudioAndImagePaths(String soundTitle) {
    switch (soundTitle) {
      case 'Rain':
        audioPath = 'assets/sounds/rain contoh.mp3';
        imagePath = 'assets/images/rain.jpg';
        break;
      case 'Night':
        audioPath = 'assets/sounds/night contoh.mp3';
        imagePath = 'assets/images/night.jpg';
        break;
      case 'Mix':
        audioPath = 'assets/sounds/mix contoh.mp3';
        imagePath = 'assets/images/mix.jpg';
        break;
      case 'Winter':
        audioPath = 'assets/sounds/winter contoh.mp3';
        imagePath = 'assets/images/winter.jpg';
        break;
      case 'Comfort':
        audioPath = 'assets/sounds/comfort contoh.mp3';
        imagePath = 'assets/images/comfort.jpeg';
        break;
      case 'Title A':
        audioPath = 'assets/sounds/TitleA.mp3';
        imagePath = 'assets/images/Contoh 1.png';
        break;
      case 'Title B':
        audioPath = 'assets/sounds/TitleB.mp3';
        imagePath = 'assets/images/Contoh 2.png';
        break;
      // Add cases for other sounds...
      default:
        audioPath = 'assets/sounds/default.mp3'; // Default sound if not found
        imagePath = 'assets/images/default.jpg'; // Default image if not found
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // ... (Rest of your SoundPlayerPage code - playback controls, UI, etc.) ...
}