import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackuniv/common/color.dart';
import 'package:hackuniv/pages/onboarding/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'pages/Homepage/home.dart';
import 'pages/auth/login.dart';

bool show = true;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pref = await SharedPreferences.getInstance();
  show = pref.getBool('ON_BORDING') ?? true;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "product",
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset("asstes/images/logo.png"),
        ),
        backgroundColor: AppColor.backgroundColor,
        nextScreen: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return show ? const OnboadringScreen() : const HomeScreen();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                width: 100,
                height: 100,
                color: Colors.white,
                child: const CircularProgressIndicator(),
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.hasError.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
        splashTransition: SplashTransition.scaleTransition,
        animationDuration: const Duration(seconds: 2),
        // pageTransitionType: PageTransitionType.scale,
        duration: 2000,
      ),
    );
  }
}
