import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../stl_widgets/comment_child.dart';
import '../book_details_controller.dart';
import 'description_widget.dart';

class DetailsComment extends GetView<BookDetailsController> {
  const DetailsComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DescriptionWidget(
          title: "Bình luận",
          showAll: true,
          show: () {
            Get.toNamed("/comments/${controller.id}");
          },
          description: "",
          child: Obx(() => controller.listComments.isEmpty
              ? const Center(child: Text('Chưa có bình luận'))
              : Column(
                  children: controller.listComments
                      .asMap()
                      .map((key, value) =>
                          MapEntry(key, CommentChild(comment: value)))
                      .values
                      .toList(),
                ))),
    );
  }
}
