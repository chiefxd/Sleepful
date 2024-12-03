import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';

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

  // Getter for name
  String get name => _name;

  // Getter for email
  String get email => _email;


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
        notifyListeners(); // Notify listeners after setting initial data
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
