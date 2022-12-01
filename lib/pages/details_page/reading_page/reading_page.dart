import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/pages/details_page/reading_page/reading_controller.dart';
import 'package:manga_app/stl_widgets/image_network.dart';

import '../../../constant/theme.dart';
import '../../../stl_widgets/loading_widget.dart';

enum ReadingType { slide, vertical, horizontal }

class ReadingPage extends GetView<ReadingController> {
  final ReadingType readingType = ReadingType.vertical;

  const ReadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDetailsChapter();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Chapter 1',
            style:
                GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: controller.obx(
            (state) => Column(
                  children: [
                    Expanded(
                        child: PageView(
                      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                      /// Use [Axis.vertical] to scroll vertically.
                      controller: controller.pageController,
                      scrollDirection: Axis.horizontal,
                      children: controller.state!.content!
                          .map((e) => Container(
                              color: Colors.white,
                              child: NetWorkImageApp(
                                urlImage: e.url!,
                                fit: BoxFit.fitWidth,
                              )))
                          .toList(),
                    )),
                    Container(
                      height: 72,
                      color: kPrimaryColor,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 36,
                              height: 36,
                              padding: const EdgeInsets.only(left: 6),
                              decoration: BoxDecoration(
                                  color: const Color(0xff353535),
                                  borderRadius: BorderRadius.circular(18)),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 36,
                            padding: const EdgeInsets.only(left: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xff353535),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chapter 1',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.yellow),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.expand_more,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 36,
                              height: 36,
                              padding: const EdgeInsets.only(left: 6),
                              decoration: BoxDecoration(
                                  color: const Color(0xff353535),
                                  borderRadius: BorderRadius.circular(18)),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            onLoading: const LoadingWidget(),
            onEmpty: const Text('Không có dữ liệu'),
            onError: (error) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Đã có lỗi xảy ra $error"),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Quay lại'))
                  ],
                ))));
  }
}
