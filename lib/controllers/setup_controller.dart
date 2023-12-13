import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/models/user.dart';
import 'package:live_streaming/screens/home.dart';
import 'package:live_streaming/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupController extends GetxController {
  RxBool isLoggedIn = true.obs;
  late SharedPreferences _prefs;
  var route;
  late RouteFactory onGenerateRoute;
  RxBool isUserUpdated = false.obs;
  final _userRef = FirebaseFirestore.instance.collection('users');
  User user = User(
    uid: '',
    username: '',
    email: '',
  );

  @override
  void onInit() {
    setup();
    super.onInit();
  }

  setup() async {
    await SharedPreferences.getInstance().then((value) {
      _prefs = value;
      isLoggedIn.value = _prefs.getBool('isLoggedIn') ?? false;
    });

    route = isLoggedIn.value ? const HomeScreen() : const LoginScreen();

    user = await setUser();
  }

  Future<User> setUser() async {
    await SharedPreferences.getInstance().then((value) {
      _prefs = value;
    });
    var snapshot = await _userRef.doc(_prefs.getString('uid')).get();
    return User.fromMap(snapshot.data()!);
  }
}
