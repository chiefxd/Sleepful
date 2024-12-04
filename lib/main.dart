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

  // Get the currently signed-in user (this will be null if not signed in)
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Initialize the theme provider if the user is logged in
  ThemeProvider? themeProvider;
  if (currentUser != null) {
    themeProvider = ThemeProvider(currentUser.uid);
    await themeProvider.initializeTheme(); // Wait for theme to load
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider ?? ThemeProvider('default'),
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
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
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
      home: FutureBuilder<void>(
        future: _initializeApp(), // Add a delay before checking the auth state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Show splash screen while waiting
          } else {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen(); // Wait for auth state
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

  // This function simulates loading or delay
  Future<void> _initializeApp() async {
    // Simulate a delay of 3 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 3));
  }
}
