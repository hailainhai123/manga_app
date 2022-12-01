import 'package:get/get.dart';
import 'package:manga_app/models/user_infomation.dart';

import '../../arbe_module/api/api_dio_controller.dart';

class UserController extends GetxController with StateMixin<UserInformation>{
  @override
  void onInit() {
    getUserInformation();
    // TODO: implement onInit
    super.onInit();
  }

  void getUserInformation() async {
    await ApiDioController.getUserInformation()
    .then((value) => change(value, status: RxStatus.success()));
  }
}