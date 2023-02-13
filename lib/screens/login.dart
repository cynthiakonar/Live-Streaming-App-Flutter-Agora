import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/constants/colors.dart';
import 'package:live_streaming/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/live_logo.gif"),
          GestureDetector(
            onTap: () {
              Get.off(() => const HomeScreen());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
              decoration: BoxDecoration(
                color: primaryThemeColor.withOpacity(0.82),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/google_logo.png",
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
