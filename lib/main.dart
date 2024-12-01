import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Profile/about_us.dart';
import 'package:sleepful/view/Pages/Profile/change_password.dart';
import 'package:sleepful/view/Pages/Profile/change_theme.dart';
import 'package:sleepful/view/Pages/Profile/edit_profile.dart';
import 'package:sleepful/view/Pages/Profile/logout.dart';
import 'package:sleepful/view/Pages/home_page.dart';
import 'package:sleepful/view/Pages/signin_page.dart';
import 'package:sleepful/view/Pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepful',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
            0xFF120C23), // Set the default scaffold background color
      ),
      routes: {
        '/signIn': (context) => const SignIn(),
        '/home': (context) => const HomePage(),
        '/editProfile': (context) => EditProfile(),
        '/change_password': (context) => ChangePassword(),
        '/change_theme': (context) => ChangeTheme(),
        '/about_us': (context) => AboutUs(),
        '/logout': (context) => Logout(),
      },
      home: FutureBuilder(
        future: Firebase.initializeApp(), // Ensure Firebase is initialized
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Show splash screen while loading
          } else if (snapshot.hasError) {
            // Show a user-friendly error page if Firebase fails to initialize
            return Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          } else {
            // After Firebase initialization, listen to auth state
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen(); // Show splash screen during auth check
                } else if (userSnapshot.hasData) {
                  return const HomePage(); // User is signed in
                } else {
                  return const SignIn(); // User is not signed in
                }
              },
            );
          }
        },
      ),
    );
  }
}
