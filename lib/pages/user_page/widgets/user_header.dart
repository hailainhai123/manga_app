import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/pages/user_page/user_controller.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/theme.dart';
import '../../../stl_widgets/image_network.dart';

class UserHeader extends GetView<UserController> {
  const UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            IconsPath.userBackground,
          ),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: NetWorkImageApp(
                      urlImage: controller
                          .state?.avatarUrl ??
                          ""),),
            ),
            const SizedBox(
              height: 4,
            ),
            Text('${controller.state?.displayName}',
                style: GoogleFonts.notoSans(
                    fontSize: 18, fontWeight: FontWeight.w500,)),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 8),
              color: kPrimaryColor.withOpacity(0.3),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('232', style: GoogleFonts.notoSans(
                          fontSize: 20, fontWeight: FontWeight.w600,color: Colors.yellow),),
                      Text('tiền xu', style: GoogleFonts.notoSans(
                          fontSize: 18, fontWeight: FontWeight.w600,),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('12', style: GoogleFonts.notoSans(
                          fontSize: 20, fontWeight: FontWeight.w600,color: Colors.yellow),),
                      Text('điểm', style: GoogleFonts.notoSans(
                          fontSize: 18, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('3', style: GoogleFonts.notoSans(
                          fontSize: 20, fontWeight: FontWeight.w600,color: Colors.yellow),),
                      Text('phiếu', style: GoogleFonts.notoSans(
                          fontSize: 18, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
