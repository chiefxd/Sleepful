import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/theme_provider.dart';
import 'package:sleepful/view/Pages/Authentication/signin_page.dart';
import 'package:sleepful/view/Pages/Profile/about_us.dart';
import 'package:sleepful/view/Pages/Profile/change_password.dart';
import 'package:sleepful/view/Pages/Profile/change_theme.dart';
import 'package:sleepful/view/Pages/Profile/edit_profile.dart';
import 'package:sleepful/view/Pages/home_page.dart';
import 'package:sleepful/view/Pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Get the currently signed-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final themeProvider = ThemeProvider(currentUser!.uid);
  await themeProvider.initializeTheme(); // Wait for theme to load

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepful',
      theme: ThemeData(
        // Define your light theme here
        scaffoldBackgroundColor:
            Colors.white, // Example: Set background to white
        primarySwatch: Colors.blue, // Example: Set primary color to blue
        // ... other light theme properties ...
      ),
      darkTheme: ThemeData(
        // Your existing dark theme
        scaffoldBackgroundColor: const Color(0xFF120C23),
      ),
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
      routes: {
        '/signIn': (context) => const SignIn(),
        '/home': (context) => const HomePage(),
        '/editProfile': (context) => EditProfile(),
        '/change_password': (context) => ChangePassword(),
        '/change_theme': (context) => ChangeTheme(),
        '/about_us': (context) => AboutUs(),
      },
      home: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 3)), // Simulate splash screen duration
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Show splash screen
          } else {
            // After splash screen, check auth state
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                // Keep showing SplashScreen while waiting for auth state
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
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
