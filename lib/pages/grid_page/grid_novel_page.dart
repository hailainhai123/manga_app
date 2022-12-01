import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/theme.dart';
import 'grid_pages_controller.dart';

class GridNovelPage extends GetView<GridPagesController> {
  const GridNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.url.value = Get.parameters['url'] ?? '';
    String title = Get.parameters['title'] ?? "";
    return Scaffold(
      appBar: AppBar(
        elevation: 0.6,
        shadowColor: Color(0xff838383),
        leading: GestureDetector(
            onTap: () {
              Get.back();
              Get.delete<GridPagesController>();
            },
            child: const Icon(Icons.arrow_back_ios, color: kSecondaryColor)),
        // you can put Icon as well, it accepts any widget.
        title: Text(title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 20,
              childAspectRatio: 160 / 228,
            ),
            itemCount: controller.gridNovel.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                      "/book_details/${controller.gridNovel[index].id}");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 162 / 187,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl:
                              controller.gridNovel[index].cover![0].url ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(controller.gridNovel[index].name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 14)),
                    const SizedBox(width: 4),
                    Text('${controller.gridNovel[index].totalViews} lượt xem',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: kGreyColor)),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
