import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/api_url.dart';
import 'package:manga_app/pages/home/home_controller.dart';
import 'package:manga_app/stl_widgets/image_network.dart';

import '../../../constant/routers.dart';
import '../../../stl_widget/title_widget.dart';

class MangaFavorite extends GetView<HomeController> {
  const MangaFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ChildHomeWidget(
          title: 'Đề cử',
          showRight: true,
          url: ApiURL.topNovelUrl,
          child: Obx(
            () => SizedBox(
              height: 248,
              width: double.infinity,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(kBookDetails,
                          parameters: {'id': controller.favorite().id ?? ""});
                    },
                    child: item(248, context,
                        controller.favorite().cover?[0].url ?? ""),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                              controller.favorite().rate?.avg.round() ?? 0,
                              (index) =>
                                  SvgPicture.asset('assets/svg/star.svg')),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('${controller.favorite().name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('${controller.favorite().lastChapter} Chương',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${controller.favorite().shortDescription}',
                          style: const TextStyle(color: Color(0xffC0C2C3)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget item(double heightItem, BuildContext context, String urlImage) {
    return Container(
        height: heightItem,
        width: MediaQuery.of(context).size.width / 3 + 32,
        margin: const EdgeInsets.only(right: 16),
        child: NetWorkImageApp(urlImage: urlImage));
  }
}
