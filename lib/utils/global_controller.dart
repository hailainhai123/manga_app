import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../arbe_module/api/custom_log.dart';
import '../arbe_module/utils/user_pref.dart';
import '../models/user_infomation.dart';

class GlobalController extends GetxController {
  var userLogin = false.obs;
  var accessToken = "".obs;
  final UserInformation prefUser = UserPref().getUser();

  @override
  void onInit() async {
    super.onInit();
    if (prefUser.id != "") {
      userLogin.value = true;
    }
    Timer.periodic(const Duration(minutes: 30), (timer) {
      refreshToken();
    });
  }

  setToken(String apiToken) {
    accessToken.value = apiToken;
    CustomLog.log("token $apiToken");
    log(apiToken);
    update();
  }

  void refreshToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    String refreshToken = await user.getIdToken(true);
    setToken(refreshToken);
  }
}
