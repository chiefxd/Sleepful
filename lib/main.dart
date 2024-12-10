import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/rewards_provider.dart';
import 'package:sleepful/providers/theme_provider.dart';
import 'package:sleepful/providers/user_data_provider.dart';
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

  // Initialize UserDataProvider and fetch user data
  final userDataProvider = UserDataProvider();
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await userDataProvider.fetchAndSetUserData(user.uid);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>.value(value: userDataProvider),
        ChangeNotifierProvider(
          create: (context) => RewardsProvider()..fetchUnlockedSounds(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserDataProvider _userDataProvider;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _listenForAuthChanges();
  }

  void _initializeApp() async {
    // Initialize user data provider and fetch initial data
    _userDataProvider = UserDataProvider();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _userDataProvider.fetchAndSetUserData(user.uid);
    }
  }

  void _listenForAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // When auth state changes, update the user-specific providers
      if (user != null) {
        _userDataProvider.fetchAndSetUserData(user.uid).then((_) {
          setState(() {}); // Rebuild UI with new user data
        });
      } else {
        setState(() {}); // Rebuild UI when user logs out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState != ConnectionState.active) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system, // Use system theme when no user
            home: const SplashScreen(),
          );
        }

        final User? currentUser = userSnapshot.data;

        if (currentUser == null) {
          // Force dark theme for SignIn page even when user is logged out
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark, // Always dark mode for SignIn
            home: const SignIn(),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<UserDataProvider>.value(
                value: _userDataProvider),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(currentUser.uid)..initializeTheme(),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Sleepful',
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.blue,
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: const Color(0xFF120C23),
                ),
                themeMode: themeProvider
                    .currentTheme, // Use the current theme for logged-in users
                routes: {
                  '/signIn': (context) => const SignIn(),
                  '/home': (context) => const HomePage(),
                  '/editProfile': (context) => EditProfile(),
                  '/change_password': (context) => ChangePassword(),
                  '/change_theme': (context) => ChangeTheme(),
                  '/about_us': (context) => AboutUs(),
                },
                home: const HomePage(),
              );
            },
          ),
        );
      },
    );
  }
}
