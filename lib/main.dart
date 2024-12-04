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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<ThemeMode> _initializeApp() async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 2));

    // Retrieve saved theme mode (for simplicity, fallback to light mode)
    // Replace this with your preferred method of storing/retrieving user preferences.
    return ThemeMode
        .dark; // Replace with ThemeMode.dark if default is dark mode
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        final themeMode = snapshot.data ?? ThemeMode.dark;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: const SplashScreen(),
          );
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
                home: const SplashScreen(),
              );
            }

            final User? currentUser = userSnapshot.data;

            return ChangeNotifierProvider<ThemeProvider>(
              key: ValueKey(
                  currentUser?.uid ?? 'default'), // Replace provider on login
              create: (_) => ThemeProvider(currentUser?.uid ?? 'default')
                ..initializeTheme(),
              child: Builder(builder: (context) {
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
              }),
            );
          },
        );
      },
    );
  }
}
