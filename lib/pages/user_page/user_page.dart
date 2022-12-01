import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/pages/user_page/user_controller.dart';
import 'package:manga_app/pages/user_page/widgets/feature_user.dart';
import 'package:manga_app/pages/user_page/widgets/user_header.dart';

import '../../constant/theme.dart';

class UserPage extends GetView<UserController> {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang của tôi',
            style: GoogleFonts.notoSans(
                fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: controller.obx(
        (state) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: kPrimaryColor,
              child: Column(
                children: const [
                  Divider(),
                  UserHeader(),
                  FeatureUser(),
                ],
              ),
            ),
          ),
        ),
        onLoading: const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
