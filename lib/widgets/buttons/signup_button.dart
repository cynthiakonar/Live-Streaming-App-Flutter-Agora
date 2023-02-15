import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/controllers/login_controller.dart';
import 'package:live_streaming/utils/colors.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Obx(() {
      return loginController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryThemeColor,
              ),
            )
          : GestureDetector(
              onTap: () => loginController.googleLogin(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
