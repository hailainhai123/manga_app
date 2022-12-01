import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/home/home_controller.dart';
import 'package:manga_app/stl_widgets/image_network.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/routers.dart';
import '../../../constant/styles.dart';
import '../../../stl_widget/title_widget.dart';

class OtherManga extends GetView<HomeController> {
  const OtherManga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverToBoxAdapter(
        child: Obx(() => SizedBox(
              width: double.infinity,
              height: 240,
              child: ListView.builder(
                  itemCount: controller.newComics.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(kBookDetails, parameters: {
                          'id': controller.newComics[index].id ?? ""
                        });
                      },
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 187,
                              width: 149,
                              margin: const EdgeInsets.only(right: 16),
                              child: NetWorkImageApp(
                                  urlImage: controller
                                          .newComics[index].cover?[0].url ??
                                      ""),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              width: 149,
                              child: Text('${controller.newComics[index].name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.notoSansFont.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                    );
                  }),
            )),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16),
    );
  }
}
