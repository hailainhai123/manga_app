import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/bookcase_page/bookcase_controller.dart';

import '../../constant/icons_path.dart';
import '../../constant/routers.dart';
import '../../constant/styles.dart';
import '../../stl_widgets/image_network.dart';

class BookCasePage extends GetView<BookcaseController> {
  BookCasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BookcaseController(), permanent: true);
    return Obx(() {
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tủ Sách'),
            bottom: const TabBar(
              indicatorColor: Colors.yellow,
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  child: Text('Lịch Sử'),
                ),
                Tab(
                  child: Text('Theo Dõi'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(kBookDetails);
                  },
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(bottom: 16),
                          height: 248,
                          width: double.infinity,
                          child: Row(
                            children: [
                              ItemView(248, context),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text('Doraemon'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Fujiko F.Fujio',
                                      style:
                                          TextStyle(color: Color(0xffC0C2C3)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'The manga was first serialized in December 196, with its 1,345 individual chapters compiled into 45 tankōbon volumes and published ...',
                                      style:
                                          TextStyle(color: Color(0xffC0C2C3)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(kBookDetails);
                  },
                  child: ListView.builder(
                      itemCount: controller.listBookMark.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          height: 248,
                          width: double.infinity,
                          child: Row(
                            children: [
                              // ItemViewBookmark(248, index, context),
                              Container(
                                  height: 248,
                                  width: MediaQuery.of(context).size.width / 3 + 32,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: NetWorkImageApp(
                                      urlImage: controller
                                          .listBookMark[index].cover?[0].url ??
                                          ""),),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${controller.listBookMark[index].name}'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${controller.listBookMark[index].totalViews} lượt xem',
                                      style:
                                          TextStyle(color: Color(0xffC0C2C3)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${controller.listBookMark[index].description}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xffC0C2C3)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset('assets/svg/bookmark.svg')
                                  ]),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget ItemView(double heightItem, BuildContext context) {
    return Container(
        height: heightItem,
        width: MediaQuery.of(context).size.width / 3 + 32,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(IconsPath.baseImage), fit: BoxFit.cover),
        ),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff1f1f1f).withOpacity(0.1),
                Color(0xff1f1f1f)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Center(
                  child: Text('',
                      maxLines: 1,
                      style: Styles.notoSansFont
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ));
  }

  Widget ItemViewBookmark(double heightItem, int index, BuildContext context) {
    return Container(
        height: heightItem,
        width: MediaQuery.of(context).size.width / 3 + 32,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(IconsPath.baseImage), fit: BoxFit.cover),
        ),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color(0xff1f1f1f).withOpacity(0.1),
                const Color(0xff1f1f1f)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Center(
                  child: Text('',
                      maxLines: 1,
                      style: Styles.notoSansFont
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ));
  }
}
