import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  int _points = 0;
  DateTime? _lastRewardTime;

  // Getter for name
  String get name => _name;

  // Getter for email
  String get email => _email;

  // Getter for points
  int get points => _points;

  // Getter for lastRewardTime
  DateTime? get lastRewardTime => _lastRewardTime;

  // Helper function to get user name from Firestore
  Future<String> getUserName(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        final fullName = snapshot.data()?['name'] ?? ''; // Get the full name
        final firstName = fullName.split(' ').first; // Extract the first name

        return firstName;
      } else {
        return ''; // User not found
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user name: $e');
      }
      return ''; // Error occurred
    }
  }

  Future<String> getFullName(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        final fullName = snapshot.data()?['name'] ?? ''; // Get the full name

        return fullName;
      } else {
        return ''; // User not found
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user name: $e');
      }
      return ''; // Error occurred
    }
  }

  // Fetch the user's email
  Future<String> getUserEmail(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        final email = snapshot.data()?['email'] ?? '';
        return email;
      } else {
        return ''; // User not found
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user email: $e');
      }
      return ''; // Error occurred
    }
  }

  // Modified updateUserData method
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update(data);

      // Update the local _name variable and notify listeners
      if (data.containsKey('name')) {
        _name = data['name'];
        notifyListeners(); // Trigger a rebuild of widgets listening to this provider
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  // Method to fetch and set initial user data
  Future<void> fetchAndSetUserData(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        _name = snapshot.data()?['name'] ?? '';
        _email = snapshot.data()?['email'] ?? '';
        if (snapshot.data()!.containsKey('points')) {
          // 'points' field exists, fetch the value
          _points = snapshot.data()?['points'] ?? 0;
        } else {
          // 'points' field does not exist, create it
          await _createPointsField(uid);
          _points = 0;
        }
        // Fetch last reward time
        _lastRewardTime = snapshot.data()?['lastRewardTime']?.toDate();

        // Check if it's time to award points
        _checkAndAwardDailyPoints(uid);
      } else {
        // New user - Create 'points' field with 0 value
        await _createPointsField(uid); // Call the function to create the field
        _points = 0;
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Function to create the 'points' field
  Future<void> _createPointsField(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);
      await userDoc
          .set({'points': 0}, SetOptions(merge: true)); // Use merge: true
    } catch (e) {
      print("Error creating points field: $e");
    }
  }

  Future<void> deductPoints(int pointsToDeduct) async {
    if (pointsToDeduct > _points) {
      throw Exception('Insufficient points to deduct.');
    }

    _points -= pointsToDeduct;
    notifyListeners();

    // Update points in Firestore
    try {
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userDoc.update({'points': _points});
    } on FirebaseException catch (error) {
      // Handle specific FirebaseException types
      print('Error deducting points: ${error.code}');
      // Revert points deduction if update fails
      _points += pointsToDeduct;
      notifyListeners();
    }
  }

  // Function to check and award daily points
  Future<void> _checkAndAwardDailyPoints(String uid) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(uid);

      if (_lastRewardTime == null) {
        // First time user opens the app, give reward
        _points += 2;
        _lastRewardTime = DateTime.now();
        // Update Firestore
        await userDoc.update({'lastRewardTime': _lastRewardTime, 'points': _points});
        notifyListeners();
        return; // Exit to avoid further checks
      }

      final now = DateTime.now();
      final timeSinceLastReward = now.difference(_lastRewardTime!);

      if (timeSinceLastReward >= const Duration(hours: 24)) {
        // More than 24 hours have passed

        // Calculate the next reward time (24 hours from the last reward time)
        final nextRewardTime = _lastRewardTime!.add(const Duration(hours: 24));

        if (now.isBefore(nextRewardTime)) {
          // If the current time is before the next reward time (within the 24-hour window)
          // Give the reward
          _points += 2;
          _lastRewardTime = DateTime.now();
          // Update Firestore
          await userDoc.update({'lastRewardTime': _lastRewardTime, 'points': _points});
          notifyListeners();
        } else {
          // More than 24 hours passed, but user didn't open the app before 24 hours from last reward
          // Do not give reward here; user missed the opportunity.

          // Now set _lastRewardTime to a point in the past so it is awarded next day
          // Correct logic to reflect a missed opportunity - do not award points.
          _lastRewardTime = nextRewardTime;
          // Update Firestore to reflect skipped reward - update to nextRewardTime
          await userDoc.update({'lastRewardTime': _lastRewardTime}); 
        }
      }
    } catch (e) {
      print("Error updating reward data in Firestore: $e");
      // Consider handling errors, e.g., reverting local changes or showing an error message
    }
  }
}
