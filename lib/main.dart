import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/setup_controller.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';
import 'package:live_streaming/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final startup = Get.put(SetupController());
  await startup.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SetupController setup = Get.find<SetupController>();
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
      },
      home: setup.route,
    );
  }
}
