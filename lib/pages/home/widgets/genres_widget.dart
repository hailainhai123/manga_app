import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/icons_path.dart';
import 'package:manga_app/constant/routers.dart';
import 'package:manga_app/pages/home/home_controller.dart';
import 'package:manga_app/stl_widget/title_widget.dart';

import '../../../constant/api_url.dart';
import '../../../constant/styles.dart';

class GenresWidget extends GetView<HomeController> {
  const GenresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ChildHomeWidget(
        title: 'Thể loại',
        showRight: false,
        url: '',
        child: Obx(() {
          return SizedBox(
              height: 80,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: controller.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(kGridNovelPage, parameters: {
                          'title': controller.categories[index].name ?? "",
                          'url':
                              "${ApiURL.gridNovelUrl}${controller.categories[controller.currentCategoryIndex.value].id}/book"
                        });
                      },
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(IconsPath.baseImage),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(40)),
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      const Color(0xff1f1f1f).withOpacity(0.4),
                                      const Color(0xff1f1f1f)
                                    ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Center(
                                  child: Text(
                                      controller.categories[index].name ?? "",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: Styles.notoSansFont.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ],
                          )),
                    );
                  }));
        }),
      ),
    );
  }
}
