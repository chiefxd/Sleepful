import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  int _points = 0;
  

  // Getter for name
  String get name => _name;

  // Getter for email
  String get email => _email;

  // Getter for points
  int get points => _points;

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
    _points -= pointsToDeduct;
    notifyListeners();

    // Update points in Firestore
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await userDoc.update({'points': _points});
  }
}
