import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get getUser => _user;

  Future googleLogin() async {
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
    isLoading(false);
    Get.offNamed(HomeScreen.routeName);
    return;
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.offNamed(LoginScreen.routeName);
  }
}
