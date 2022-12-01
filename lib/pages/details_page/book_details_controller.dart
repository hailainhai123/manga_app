import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manga_app/models/home/new_model/novel_response_model.dart';

import '../../arbe_module/api/api_dio_controller.dart';
import '../../models/comment_model.dart';
import '../../models/reading_state_model.dart';
import '../../utils/global_controller.dart';
import '../../utils/utils.dart';

class BookDetailsController extends GetxController
    with StateMixin<ComicResponseModel> {
  var bookmarked = false.obs;
  var rate = 0.0.obs;
  var onLoadDetails = true.obs;
  var id = "";
  var pageComment = 1.obs;
  var listComments = <CommentModel>[].obs;
  final readingState = ReadingStateModel(bookId: "", currentChapter: 0).obs;
  final globalController = Get.find<GlobalController>();
  var rating = 0.0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    var list = [...listComments];
    super.onReady();

    getReadingState();
    getNovelComments();
  }

  void getReadingState() async {
    await ApiDioController.getReadingState(id).then((value) async {
      readingState.update((readingState) {
        readingState!.bookId = id;
      });
      if (value == null) {
        return;
      } else {
        readingState.update((val) {
          if (val != null) {
            val.rate = value.rate;
            val.followed = value.followed;
            val.currentChapter = value.currentChapter ?? 0;
            val.lastReadAt = value.lastReadAt;
          }
        });
        bookmarked.value = readingState().followed ?? false;
      }
    });
  }

  Future getNovelDetails() async {
    await ApiDioController.getNovelDetails(id)
        .then((value) => value == null
            ? change(value, status: RxStatus.error(""))
            : change(value, status: RxStatus.success()))
        .onError((error, stackTrace) =>
            change(value, status: RxStatus.error(error.toString())))
        .catchError((error) {
      change(value, status: RxStatus.error(error));
    });
  }

  void getNovelComments() async {
    await ApiDioController.getNovelComments(id, pageComment.value, 2)
        .then((value) {
      listComments.value = value;
    });
  }

  void readNow() async {
    await ApiDioController.getListChapter(id, 1, nextPage: (success) {}).then(
        (value) => Get.toNamed("/reading/${value[0].id}", parameters: {
              'title': state?.name ?? "",
              'bookId': id,
              'lastChap': value.length.toString()
            }));
  }

  void bookmark(BuildContext context) {
    readingState.value.followed = !bookmarked.value;
    globalController.userLogin.value
        ? setReadingSate(true)
        : showDialogLogin(context);
  }

  void setReadingSate(bool isBookmark) async {
    EasyLoading.show(status: isBookmark ? null : "Đang gửi đánh giá");
    await ApiDioController.setReadingState(readingState()).then((value) {
      if (value == null) {
        EasyLoading.dismiss();
        return;
      }
      EasyLoading.dismiss();
      if (value['message'] == 'success' && isBookmark) {
        bookmarked.value = !bookmarked.value;
      } else {
        Get.back();
      }

      if (value['message'] == 'success' && !isBookmark) {
        Utils.showSuccess("Đánh giá thành công", "Cám ơn đánh giá của bạn!");
      }
    });
  }

  void updateReadingState() async {
    await ApiDioController.setReadingState(readingState());
  }

  Future<Object?> showDialogLogin(BuildContext context) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return requireLoginWidget();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget requireLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Đăng nhập để sử dụng tất cả chức năng ',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Đăng nhập')),
            const SizedBox(width: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Đăng ký')),
          ],
        )
      ],
    );
  }
}
