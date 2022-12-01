import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manga_app/binding/app_binding.dart';

import 'arbe_module/api/custom_log.dart';
import 'arbe_module/utils/user_pref.dart';
import 'constant/routers.dart';
import 'constant/theme.dart';
import 'firebase_options.dart';
import 'models/user_infomation.dart';
import 'utils/global_controller.dart';

void main() async {
  await GetStorage.init();
  UserPref().call();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final globalController = Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDefault();
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      name: "Comic3k",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken(true);
    globalController.setToken(token ?? "");
    CustomLog.log('Initialized default app $app');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      globalController.refreshToken();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserInformation prefUser = UserPref().getUser();
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme(),
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBinding(),
      initialRoute: prefUser.id != "" ? kRouteIndex : kLoginPage,
      builder: EasyLoading.init(),
      getPages: pages,
    );
  }
}
