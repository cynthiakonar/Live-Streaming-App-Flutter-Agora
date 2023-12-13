import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';
import 'package:live_streaming/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:live_streaming/models/user.dart' as model;

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final googleSignIn = GoogleSignIn();
  model.User _user = model.User(uid: '', username: '', email: '');
  final _userRef = FirebaseFirestore.instance.collection('users');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future googleLogin(BuildContext context) async {
    try {
      isLoading(true);
      final user = await googleSignIn.signIn();
      if (user == null) return;

      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _user = model.User.fromMap(
        {
          "uid": user.id,
          "username": user.displayName,
          "email": user.email,
        },
      );

      // adding user to firestore if not exists
      if (!(await _userRef.doc(user.id).get()).exists) {
        await _userRef.doc(user.id).set(_user.toMap());
      }

      // persist login state
      final SharedPreferences prefs = await _prefs;
      await prefs.setString("uid", _user.uid);
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
    prefs.remove('uid');
    Get.offNamed(LoginScreen.routeName);
  }
}
