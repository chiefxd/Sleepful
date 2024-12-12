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
        // We'll provide ThemeProvider later when the user is authenticated.
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider('default')
            ..initializeTheme(), // Initialize with default if no user
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
  bool _isInitializing = true; // Variable to control the splash screen display

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _listenForAuthChanges(); // Listen for auth changes
  }

  // Simulate a delay for the splash screen to show
  Future<void> _initializeApp() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Show splash for 2 seconds
    setState(() {
      _isInitializing = false; // After the delay, stop showing the splash
    });
  }

  final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFE4DCFF),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF120C23), // Example primary color in color scheme
      // secondary: Colors.pink, // Example secondary color
      // onPrimary: Colors.white, // Text color on primary buttons
      // onSecondary: Colors.black, // Text color on secondary buttons
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF120C23)),
      bodyMedium: TextStyle(color: Color(0xFF120C23)),
      bodySmall: TextStyle(color: Color(0xFF120C23)), // Example body text color
    ),
  );

  final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF120C23),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFB4A9D6), // Example primary color in color scheme
      // secondary: Colors.pink, // Example secondary color
      // onPrimary: Colors.white, // Text color on primary buttons
      // onSecondary: Colors.black, // Text color on secondary buttons
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFB4A9D6)),
      bodyMedium: TextStyle(color: Color(0xFFB4A9D6)),
      bodySmall: TextStyle(color: Color(0xFFB4A9D6)), // Example body text color
    ),
  );

  void _listenForAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // This will now rebuild the UI with the new user.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // If the app is still initializing, show the SplashScreen
    if (_isInitializing) {
      return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark, // Default theme for loading state
        home: const SplashScreen(),
      );
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState != ConnectionState.active) {
          // Return SplashScreen if the authentication state is not yet determined
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark, // Default theme for loading state
            home: const SplashScreen(),
          );
        }

        final User? currentUser = userSnapshot.data;

        // If the user is logged in, update ThemeProvider with user UID
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<UserDataProvider>.value(
                value: context.read<UserDataProvider>()),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(currentUser?.uid ?? 'default')
                ..initializeTheme(),
            ),
          ],
          // MaterialApp with ThemeProvider
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Sleepful',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeProvider
                    .currentTheme, // Get the current theme from ThemeProvider
                routes: {
                  '/signIn': (context) => const SignIn(),
                  '/home': (context) => const HomePage(),
                  '/editProfile': (context) => EditProfile(),
                  '/change_password': (context) => ChangePassword(),
                  '/change_theme': (context) => ChangeTheme(),
                  '/about_us': (context) => AboutUs(),
                },
                home: currentUser != null ? const HomePage() : const SignIn(),
              );
            },
          ),
        );
      },
    );
  }
}
