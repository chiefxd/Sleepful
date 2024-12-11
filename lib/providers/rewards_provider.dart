import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Sounds/sound_part.dart';

// RewardSound class (using SoundPart as the base)
class RewardSound extends SoundPart {
  final String id;
  bool isUnlocked;
  final int points; // Add points property

  RewardSound({
    required this.id,
    required String imagePaths, // Renamed to match rewards_page.dart
    required String titles, // Renamed to match rewards_page.dart
    required String minutes, // Renamed to match rewards_page.dart
    required this.points, // Points required to unlock
    this.isUnlocked = false,
  }) : super(
          key: UniqueKey(),
          soundPictures: imagePaths, // Use imagePaths for soundPictures
          soundTitle: titles, // Use titles for soundTitle
          soundGenre: 'Reward Genre', // You might want to adjust this
          soundDuration: minutes, // Use minutes for soundDuration
        );
}

class RewardsProvider extends ChangeNotifier {
  final List<RewardSound> _rewardSounds = [
    // Add your reward sounds here (as RewardSound objects)
    // Example:
    RewardSound(
      id: 'reward_sound_1',
      imagePaths:
          'assets/images/Contoh 1.png', // Assuming this is your image path
      titles: 'Title A', // Assuming this is your title
      minutes: '2m', // Assuming this is your duration
      points: 5, // Assuming this is the points required
    ),
    RewardSound(
      id: 'reward_sound_2',
      imagePaths:
          'assets/images/Contoh 2.png', // Assuming this is your image path
      titles: 'Title B', // Assuming this is your title
      minutes: '6m', // Assuming this is your duration
      points: 10, // Assuming this is the points required
    ),
    RewardSound(
      id: 'reward_sound_3',
      imagePaths: 'assets/images/rain.png', // Assuming this is your image path
      titles: 'Title C', // Assuming this is your title
      minutes: '4m', // Assuming this is your duration
      points: 15, // Assuming this is the points required
    ),
    RewardSound(
      id: 'reward_sound_4',
      imagePaths:
          'assets/images/winter.png', // Assuming this is your image path
      titles: 'Title D', // Assuming this is your title
      minutes: '8m', // Assuming this is your duration
      points: 20, // Assuming this is the points required
    ),
    RewardSound(
      id: 'reward_sound_5',
      imagePaths:
          'assets/images/Contoh 3.png', // Assuming this is your image path
      titles: 'Title E', // Assuming this is your title
      minutes: '10m', // Assuming this is your duration
      points: 25, // Assuming this is the points required
    ),
    // ... more reward sounds
  ];

  List<RewardSound> get unlockedSounds =>
      _rewardSounds.where((sound) => sound.isUnlocked).toList();

  // Function to unlock a reward by its ID
  void unlockSound(String soundId) async {
    final soundIndex = _rewardSounds.indexWhere((sound) => sound.id == soundId);
    if (soundIndex != -1) {
      _rewardSounds[soundIndex].isUnlocked = true;
      notifyListeners();

      // Create a new document in 'redeemedSounds' subcollection
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc
          .collection('redeemedSounds')
          .doc(soundId)
          .set({'soundId': soundId});
    }
  }

  Future<void> fetchUnlockedSounds() async {
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final querySnapshot = await userDoc.collection('redeemedSounds').get();

    for (final doc in querySnapshot.docs) {
      final soundId = doc.data()['soundId'] as String;
      unlockSound(soundId); // Unlock sounds based on data from Firestore
    }
  }
}
