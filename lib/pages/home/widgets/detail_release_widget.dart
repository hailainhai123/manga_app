import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/home/home_controller.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/routers.dart';
import '../../../stl_widgets/image_network.dart';

class DetailRelease extends GetView<HomeController> {
  const DetailRelease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        right: 16,
      ),
      sliver: Obx(() => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  height: 146,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(kBookDetails, parameters: {
                        'id': controller.listNewRelease[index].id ?? ""
                      });
                    },
                    child: Column(
                      children: [
                        SizedBox(
                            height: 146,
                            width: MediaQuery.of(context).size.width / 3 - 12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: NetWorkImageApp(
                                  urlImage: controller.listNewRelease[index]
                                          .cover?[0].url ??
                                      ""),
                            )),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${controller.listNewRelease[index].name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                // return Container();
              },
              childCount: controller.listNewRelease.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.7,
            ),
          )),
    );
  }
}
