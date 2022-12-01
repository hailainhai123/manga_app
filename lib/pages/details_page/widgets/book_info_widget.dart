import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/routers.dart';
import 'package:manga_app/pages/details_page/book_details_controller.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/theme.dart';
import '../../../utils/global_controller.dart';
import '../../vote_dialog/vote_dialog_page.dart';

class BookInfoWidget extends GetView<BookDetailsController> {
  const BookInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xfff6f6f6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24),
            // height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.remove_red_eye_outlined,
                              color: kGreyColor),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Lượt xem',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kGreyColor)),
                          Text('${controller.state!.totalViews}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: const Duration(milliseconds: 700),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Get.find<GlobalController>().userLogin.value
                            ? const VoteDialogPage()
                            : requireLoginWidget();
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position: Tween(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0))
                              .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.star_outline, color: kGreyColor),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Đánh giá',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kGreyColor)),
                            Text('${controller.state!.rate?.total}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.view_sidebar_outlined, color: kGreyColor),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Số chương',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kGreyColor)),
                          Text('${controller.state!.lastChapter}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget requireLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Vui lòng đăng nhập để sử dụng chức năng này!',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Get.toNamed(kLoginPage);
            }, child: const Text('Đăng nhập')),
            const SizedBox(width: 16),
            ElevatedButton(onPressed: () {
              Get.toNamed(kRegisterPage);
            }, child: const Text('Đăng ký')),
          ],
        )
      ],
    );
  }
}
