// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/rewards_provider.dart';

import 'rewards_redeem.dart';

class RewardsCard extends StatelessWidget {
  final String title;
  final String minutes;
  final String imagePath;
  final String soundId;

  final int points;

  const RewardsCard({
    super.key,
    required this.title,
    required this.minutes,
    required this.imagePath,
    required this.soundId,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final rewardsProvider = Provider.of<RewardsProvider>(context);
    final isUnlocked =
        rewardsProvider.isRewardUnlocked(soundId);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            height: 140,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            minutes,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 24,
            child: ElevatedButton(
              onPressed: isUnlocked
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RewardsRedeem(
                            soundId: soundId,
                            imagePath: imagePath,
                            title: title,
                            minutes: minutes,
                            points: points,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                disabledBackgroundColor: Theme.of(context)
                    .colorScheme
                    .primary,
                disabledForegroundColor:
                    Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              child: Text(
                isUnlocked ? 'Redeemed' : 'Redeem for $points pts',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
