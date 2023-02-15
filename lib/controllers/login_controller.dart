import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';
import 'package:live_streaming/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // To be stored in profile controller
  GoogleSignInAccount? get getUser => _user;

  Future googleLogin(BuildContext context) async {
    try {
      isLoading(true);
      final user = await googleSignIn.signIn();
      if (user == null) return;
      _user = user;

      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // persist login state
      final SharedPreferences prefs = await _prefs;
      await prefs.setBool("isLoggedIn", true);

      Get.offNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    } finally {
      isLoading(false);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await _prefs;
    prefs.remove('isLoggedIn');
    Get.offNamed(LoginScreen.routeName);
  }
}
