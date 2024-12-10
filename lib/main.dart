import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(user?.uid ?? 'default')..initializeTheme(),
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
  @override
  void initState() {
    super.initState();
    _initializeApp(); // Initialize theme mode
    _listenForAuthChanges(); // Listen for auth changes
  }

  Future<ThemeMode> _initializeApp() async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 2));

    // Retrieve saved theme mode (for simplicity, fallback to light mode)
    // Replace this with your preferred method of storing/retrieving user preferences.
    return ThemeMode.dark;
  }

  void _listenForAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // This will now rebuild the UI with the new user.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        final themeMode = snapshot.data ?? ThemeMode.dark;

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            // Check for active connection state to avoid UI rebuild before user data available.
            if (userSnapshot.connectionState != ConnectionState.active) {
              return MaterialApp(
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
                home: const SplashScreen(),
              );
            }

            final User? currentUser = userSnapshot.data;

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
              home: currentUser != null ? const HomePage() : const SignIn(),
            );
          },
        );
      },
    );
  }
}
