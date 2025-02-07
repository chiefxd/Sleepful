import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Sounds/sound_part.dart';

// RewardSound class (using SoundPart as the base)
class RewardSound extends SoundPart {
  final String id;
  bool isUnlocked;
  final int points;

  RewardSound({
    required this.id,
    required String imagePaths,
    required String titles,
    required String minutes,
    required this.points,
    this.isUnlocked = false,
  }) : super(
          key: UniqueKey(),
          soundPictures: imagePaths,
          soundTitle: titles,
          soundGenre: 'Reward Genre',
          soundDuration: minutes,
        );
}

class RewardsProvider extends ChangeNotifier {
  final List<RewardSound> _rewardSounds = [
    RewardSound(
      id: 'reward_sound_1',
      imagePaths:
          'assets/images/Contoh 1.png',
      titles: 'Title A',
      minutes: '2m',
      points: 5,
    ),
    RewardSound(
      id: 'reward_sound_2',
      imagePaths:
          'assets/images/Contoh 2.png',
      titles: 'Title B',
      minutes: '6m',
      points: 10,
    ),
    RewardSound(
      id: 'reward_sound_3',
      imagePaths: 'assets/images/rain.jpg',
      titles: 'Title C',
      minutes: '4m',
      points: 15,
    ),
    RewardSound(
      id: 'reward_sound_4',
      imagePaths:
          'assets/images/winter.jpg',
      titles: 'Title D',
      minutes: '8m',
      points: 20,
    ),
    RewardSound(
      id: 'reward_sound_5',
      imagePaths:
          'assets/images/Contoh 3.png',
      titles: 'Title E',
      minutes: '10m',
      points: 25,
    ),
  ];

  final Set<String> _unlockedRewardIds = {};

  Set<String> get unlockedRewardIds => _unlockedRewardIds;

  // check if a reward is unlocked
  bool isRewardUnlocked(String soundId) {
    return _unlockedRewardIds.contains(soundId);
  }

  List<RewardSound> get unlockedSounds =>
      _rewardSounds.where((sound) => sound.isUnlocked).toList();

  // unlock a reward by its ID
  void unlockSound(String soundId) async {
    final soundIndex = _rewardSounds.indexWhere((sound) => sound.id == soundId);
    if (soundIndex != -1) {
      _rewardSounds[soundIndex].isUnlocked = true;

      _unlockedRewardIds.add(soundId);

      notifyListeners();

      // Create a new document in 'redeemedSounds' collection
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
      unlockSound(soundId);
    }
  }
}
