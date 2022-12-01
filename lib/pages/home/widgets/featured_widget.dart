import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/models/home/new_model/novel_response_model.dart';
import 'package:manga_app/pages/home/home_controller.dart';
import 'package:manga_app/stl_widgets/image_network.dart';

import '../../../constant/api_url.dart';
import '../../../constant/icons_path.dart';
import '../../../constant/routers.dart';
import '../../../constant/styles.dart';
import '../../../stl_widget/title_widget.dart';

class Featured extends GetView<HomeController> {
  const Featured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ChildHomeWidget(
        title: 'Truyện Hot',
        showRight: true,
        url: ApiURL.hotNovelUrl,
        child: Obx(() => SizedBox(
              height: 248,
              width: double.infinity,
              child: Row(
                children: [
                  controller.featured.isNotEmpty
                      ? SizedBox(
                          width: 180,
                          child: ItemView(
                              248, context, controller.featured[0], null))
                      : const SizedBox(),
                  controller.featured.length > 1
                      ? Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: ItemView(118, context,
                                    controller.featured[1], BoxFit.fitWidth),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              controller.featured.length > 2
                                  ? ItemView(118, context,
                                      controller.featured[2], BoxFit.cover)
                                  : const SizedBox()
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            )),
      ),
    );
  }

  Widget ItemView(double heightItem, BuildContext context,
      ComicResponseModel comic, BoxFit? fit) {
    return InkWell(
      onTap: () {
        Get.toNamed(kBookDetails, parameters: {'id': comic.id ?? ""});
      },
      child: Container(
          height: heightItem,
          // width: MediaQuery.of(context).size.width / 3 + 32,
          margin: const EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: NetWorkImageApp(
                          urlImage: comic.cover?[0].url ?? "", fit: fit),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          const Color(0xff1f1f1f).withOpacity(0.1),
                          const Color(0xff1f1f1f)
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text('${comic.name}',
                          maxLines: 1,
                          style: Styles.notoSansFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
