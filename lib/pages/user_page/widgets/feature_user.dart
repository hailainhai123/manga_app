import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/utils/global_controller.dart';

import '../../../arbe_module/utils/user_pref.dart';
import '../../../models/user_infomation.dart';

class FeatureUser extends StatelessWidget {
  const FeatureUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          itemFeature('assets/svg/dollar-sign.svg', 'Nạp tiền'),
          itemFeature('assets/svg/ticket.svg', 'Phiếu đọc truyện của tôi'),
          itemFeature('assets/svg/avatar.svg', 'Khung avatar của tôi'),
          itemFeature('assets/svg/sticker.svg', 'Sticker của tôi'),
          itemFeature('assets/svg/manga.svg', 'Manga Card'),
          itemFeature('assets/svg/console.svg', 'Trò chơi'),
          const Divider(),
          itemFeature('assets/svg/mail.svg', 'Tin nhắn của tôi'),
          itemFeature('assets/svg/message-circle.svg', 'Bình luận của tôi'),
          itemFeature('assets/svg/level-up.svg', 'Level của tôi'),
          InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Get.snackbar('Thông báo', 'Đăng xuất thành công',
                      snackPosition: SnackPosition.TOP);
                  Get.find<GlobalController>().userLogin.value = false;
                  UserPref().setUser(UserInformation());
                });
              },
              child: itemFeature('assets/svg/level-up.svg', 'Đăng xuất')),
        ],
      ),
    );
  }

  Widget itemFeature(String assetName, String text) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SvgPicture.asset(assetName)),
          const SizedBox(
            width: 32,
          ),
          Text(
            text,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
