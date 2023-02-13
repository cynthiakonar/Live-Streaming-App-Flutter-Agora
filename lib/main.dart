import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/screens/login.dart';

void main() {
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
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 11),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
