import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';
import 'package:live_streaming/screens/streaming.dart';
import 'package:live_streaming/screens/watch_live.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ).copyWith(
          scaffoldBackgroundColor: bgColor,
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: bgColor,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: secondaryThemeColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              fontSize: 11,
              color: secondaryThemeColor,
            ),
          ),
          iconTheme: const IconThemeData(color: secondaryThemeColor)),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        WatchLiveScreen.routeName: (context) => const WatchLiveScreen(),
        StreamingScreen.routeName: (context) => const StreamingScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
