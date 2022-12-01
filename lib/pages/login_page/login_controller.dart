import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:manga_app/arbe_module/event_dispatcher/event_dispatcher.dart';
import 'package:manga_app/arbe_module/event_dispatcher/event_id.dart';

import '../../arbe_module/api/api_dio_controller.dart';
import '../../arbe_module/api/custom_log.dart';
import '../../arbe_module/authen/authen_helper.dart';
import '../../constant/routers.dart';
import '../../utils/global_controller.dart';

class LoginController extends GetxController {
  final GlobalController globalController = Get.find();
  var loading = false.obs;

  void setLoading() => loading.value = !loading.value;

  void signInWithGoogle() async {
    loading.value = true;
    AuthenticationHelper.instance.handleGoogleSignIn(
      (success) async {
        loading.value = false;
        globalController.userLogin.value = true;
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) return;
        String token = await user.getIdToken();
        ApiDioController.getAndSaveToken(token).then((value) {
          Get.snackbar('Thông báo', 'Đăng nhập thành công',
              snackPosition: SnackPosition.TOP);
          Get.offAndToNamed(kRouteIndex);
        });
      },
      (errorMessage) => {
        loading.value = false,
        CustomLog.log("Flutter lỗi =======> $errorMessage"),
      },
    );
  }

  void signInWithApple() async {
    loading.value = true;
    AuthenticationHelper.instance.signInWithApple((success) async {
      loading.value = false;
      globalController.userLogin.value = true;
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      String token = await user.getIdToken();
      ApiDioController.getAndSaveToken(token).then((value) {
        Get.snackbar('Thông báo', 'Đăng nhập thành công',
            snackPosition: SnackPosition.TOP);
        Get.offAndToNamed(kRouteIndex);
        onLoginSuccess();
      });
    });
  }

  void skipLogin() async {
    Get.offAndToNamed(kRouteIndex);
  }

  void onLoginSuccess() {
    EventDispatcher().postEvent(eventId: EventId.onUserLogin);
  }
}
