import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/details_page/widgets/book_info_widget.dart';
import 'package:manga_app/pages/details_page/widgets/comic_details_comment.dart';

import '../../constant/styles.dart';
import '../../constant/theme.dart';
import '../../stl_widgets/loading_widget.dart';
import 'book_details_controller.dart';

class BookDetailsPage extends GetView<BookDetailsController> {
  const BookDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.id = Get.parameters['id'] ?? "";
      controller.getNovelDetails();
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        top: false,
        child: controller.obx(
            (state) => Stack(
                  children: [
                    Container(
                        color: const Color(0xff1f1f1f),
                        // color: Colors.blue,
                        child: CustomScrollView(slivers: <Widget>[
                          SliverAppBar(
                            backgroundColor: Colors.transparent,
                            pinned: true,
                            leading: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  )),
                            ),
                            title: Container(
                              color: Colors.transparent,
                              // height: 80,
                              width: double.infinity,
                            ),
                            expandedHeight: 401,
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: const EdgeInsets.only(bottom: 16),
                              centerTitle: true,
                              background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${controller.state!.cover![0].url}'),
                                          fit: BoxFit.cover))),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 16, bottom: 8),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Thể loại'),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(
                                              controller.state!.tags!.length,
                                              (index) => Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 12),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kSecondaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.5)),
                                                        width: 5,
                                                        height: 5,
                                                      ),
                                                      Text(controller
                                                          .state!.tags![index])
                                                    ],
                                                  ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('${controller.state?.name}',
                                      maxLines: 2,
                                      style: Styles.notoSansFont.copyWith(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('${controller.state!.description}',
                                  style: Styles.notoSansFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: BookInfoWidget(),
                          ),
                          const SliverToBoxAdapter(
                            child: DetailsComment(),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 80)),
                        ])),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: const Color(0xff1F1F1F).withOpacity(0.8),
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: IconButton(
                                        onPressed: () {
                                          controller.bookmark(context);
                                        },
                                        icon: Obx(() => Icon(
                                              controller.bookmarked.value
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: kSecondaryColor,
                                              size: 30,
                                            ))),
                                  ),
                                  Expanded(
                                    child: Container(
                                        color: Colors.transparent,
                                        height: 60,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ))),
                                            onPressed: () {
                                              controller.readNow();
                                            },
                                            child: const Text(
                                              'Read Now',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              "/comments/${controller.id}");
                                        },
                                        icon: const Icon(
                                          Icons.comment,
                                          color: kSecondaryColor,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                ))),
      ),
    );
  }
}
